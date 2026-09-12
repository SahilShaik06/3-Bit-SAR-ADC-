


`timescale 1ns / 1ps
//sar logic, in the sar adc will run the binary search algorithm "guessing" the digital version of the analog input signal 
//the sar will initally put out 100 as its first guess and will turn "on" the first capacitor and run the function vx= (4c/8c)(vref) -vin 
//if we get a negative value were good and place b2=1 and keep that capacitor on and turn on the next MSB (same with the cap)
//if it was positive we went too high, (b2=0) turn that cap off and turn on the next MSB, run till all 3 bits are found 
//check the rest of the github repo for the analog portion aswell as a video explaining the process
//this module is clock based 


module sar_logic (
    input logic clk, 
    input logic reset_neg, //reset but is complimented if its 0 we push it to a known state   
    input logic start, // need a high signal to start the fsm 
    input logic comp_out, //the output from the comparator will tell us if its pos or neg, which decides the bit for b2, b1, b0
    //if comp_out =1 vin was above the current DAC value
    output logic [2:0] dac, //is what is turning "on"/driving the capacitor bit [2] is 4c, [1] 2c, [0] 1c
    //by turning on were putting the bottom plate of any given cap to the vref instead of GND
    output logic [2:0] result, //the bits discovered so far 
    output logic done, //indicates were done on a high 
    output logic sample_top, //will drive S2, hich is the top cap switch 
    //3 bit control bits to choose which of the swithes will be on
    output logic [2:0] sw_in,
    output logic [2:0] sw_ref, 
    output logic [2:0] sw_gnd
);

    typedef enum logic [2:0] {IDLE, SAMPLE, HOLD, CONVERT, FINISH} state_t; //all states of the fsm, new state is HOLD, will allow a delay between the top cap opening and the bottom cap switching

    state_t state; // 2 bit register holds thse 5 states 
    logic [1:0] bit_i;   //2, 1, 0 is the current bit were testing start at 2 and decremenet each cycle 

    //core logic
    //two things happening, latch prev answer comparator gives a bit from last cycle if vin above dac val current bit stays 1, if below clear it 
    //set up the next test, set the next lower bit to 1, and leave the resolved ones as is 
    //dac accumulates, after cycle 1 with b2=1 dac becomes 110 for cycle 2, 4c is kept 2c is turned on for the test , if b2 was 0 then we woud be at 010 
    //THEREFORE dac at each step is eexactly the row of on/off states 
    //during convert stage, satte stays on convert for three cycles while dac will chnage very cycle 




    always_ff @(posedge clk or negedge reset_neg) begin
        if(!reset_neg) begin //so reset_neg is high, hardcode the state and values, were in idle mode and everything is set to 0 and bit 2
            state <= IDLE; 
            dac <= 3'b000; 
            result <= 3'b000; 
            bit_i <= 2'd2; 
            done <= 1'b0; 
        end 
        //else the reset is low (rmr negated logic) 
        else begin 
            case (state) //case statement based on the state 


                IDLE: begin 
                    done <=1'b0; //set done to 0 since were not done
                    //wait for the start high then sample
                    if (start) begin 
                        state<=SAMPLE;

                    end 
                end 

                SAMPLE: begin 
                    //will track the vin, which will hold the top plate to vcm (of cap)
                    state<= HOLD;
                end

                HOLD: begin
                    //now the top plate was held, bottom plates are now on Vin
                    dac <= 3'b100; //msb is set to 1
                    state<= CONVERT;

                end 

            //while entering convert sample already set the dac to 100
            //array already set and the comparator has responded to that , bit_i = 2

                CONVERT: begin 
                    //comp_out figuring what is higher or lower 
                    //making general cases instead of hardcoding to not need more hw/lines of code 
                    //if comp_out high then we went higher than vin, therefore bit IS 1 and were right go to next bit and turn on 
                    result[bit_i] <=comp_out; //MSB is set to result 
                    //very important covers both cases 

                    dac[bit_i]<= comp_out; //go to next MSB, keep cap on if comp_out =1, turn off if 0 
                    //we still have more bits to go 

                    if(bit_i>0) begin 
                        //turn the next MSB on 
                        dac[bit_i-1] <= 1'b1;
                        bit_i <= bit_i -1; 
                    end 
                    //if were done then just go to the finish stage 
                
                    else begin 
                        state<=FINISH; 
                    end 

                end 

                //last stage , all it does is just indicate were done and send to IDLE but the actual result is done on line 72
                FINISH: begin 
    
                    done <=1'b1;
                    bit_i<=2'd2; //reset it 
                    state<=IDLE;

                end 
            endcase
        end

    end //end of the always_ff

    //the decode which is similar to the control unit of the RISC-V, ill have 3 bits which represents which switches will be on 

    //top plate switch will open one cycle BEFORE the bottom plates will "move"
    assign sample_top = (state==IDLE) || (state==SAMPLE);
    //now the bottom plates will track the Vin through sample and HOLD
    logic sample; 

    assign sample = sample_top || (state==HOLD);

    //is the decode part, will replcaite one bit three times, so if the state was 1'b1, itll be 111, during sampling we read thrse three lines, so all the caps will go to vin
    //else dac will choose which cap will go to vref if 1, or gnd 0
    //& will work on all three cpas at once, if sample is high, then 3(~sample) is 000, which will make sw_ref and sw_gnd zero making vin closed 
    //if sample drops s_in goes to 000 and dac will choose vref vs ground per cap, rmr that one of three sitches is closed per cap always
    assign sw_in = {3{sample}};
    assign sw_ref = dac & {3{~sample}};
    assign sw_gnd = ~dac & {3{~sample}};


endmodule 