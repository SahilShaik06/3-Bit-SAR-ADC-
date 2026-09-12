`timescale 1ns / 1ps
//will model the comparator to check if the sar logic is working properly 
//vinput will be above the voltage the dac cap is provuding 
//will sweep the input from the each of the 8 code ranges and will check the result 
//will compare to hand calculated values, can be found on github 


module tb_sar_logic (
    );
    //every previous port is an internal wire 
    logic clk;
    logic reset_neg;
    logic start;
    logic comp_out;
    logic [2:0] dac;
    logic [2:0] result;
    logic done;
    

    localparam real VREF= 1.8; //hard code this 
    localparam real LSB= VREF / 8.0; //0.225 

    real vin; //depends on what it is 

    int pass_count = 0; 
    int fail_count = 0; 

    always #5 clk = ~clk; //10ns clk 
    //the dac output will be dac *LSB, comparatoe will see if vin is above it or less than 
    //were just trying to mimick what the analog stuff does here for the Test bench, analog will do dac* 0.225v 
    assign comp_out = (vin > (dac* LSB));
    
    sar_logic dut(
        .clk       (clk),
        .reset_neg (reset_neg),
        .start     (start),
        .comp_out  (comp_out),
        .dac       (dac),
        .result    (result),
        .done      (done)

    );

    //will check one conversion cycle 
    //resusable, allows us to have mui;tiple calls with there own params, we do this so we can have muiltiple cases wihtout having to redo it 8 times, v and expected change for each one 

    task automatic run_one(input real v, input logic [2:0] expected);
        begin
            vin = v;
 //on negedge because signals chnage on the pso edge clk, easier to see the data if its on negedge
            //start pulse one cycle, on for one cycle for idle
            @(negedge clk);
            start = 1'b1;
            @(negedge clk);
            start = 1'b0;
 
            // wait for the conversion to finish 
            //wait for fsm to show a high on done, dont need 5 clk cycles just waiting for the signal
            @(posedge done);
            @(negedge clk); //letting reuslt be there before we read it 
            //=== three so we can actually comparae instead of getting a x just from two 

            if (result === expected) begin
                pass_count = pass_count + 1;
                $display("PASS   vin=%0.3f V   expected=%b   got=%b", v, expected, result);
            end
            else begin
                fail_count = fail_count + 1;
                $display("FAIL   vin=%0.3f V   expected=%b   got=%b", v, expected, result);
            end
        end
    endtask
 
    // test 
    //intial blk starts at the begining and then executes everything 

    initial begin
    //setting as a defined value so we dont get errors or x's
        start     = 1'b0;
        vin       = 0.0;
        reset_neg = 1'b0; //rmr negated logic 

        //hold resert for two full cycles, release then wait a cycle our fsm is waiting in IDLE for a full cycle before we get our first test 

        repeat (2) @(negedge clk);
        reset_neg = 1'b1;
        @(negedge clk);
 
        $display(" 3-bit SAR logic testbench ");
        $display("Vref = %0.2f V, 1 LSB = %0.4f V", VREF, LSB);
        $display(" "); //line space 
        //run in sequence not paralel 
        //voltage in, voltage output 
        run_one(0.100, 3'b000);
        run_one(0.300, 3'b001);
        run_one(0.500, 3'b010);
        run_one(0.800, 3'b011);
        run_one(1.000, 3'b100);
        run_one(1.200, 3'b101);
        run_one(1.450, 3'b110);
        run_one(1.700, 3'b111);
 
        $display("");
        $display("--- %0d passed, %0d failed ---", pass_count, fail_count);
 
        if (fail_count == 0)
            $display("ALL TESTS PASSED");
        else
            $display("THERE WERE FAILURES");
 
        $finish;
    end

endmodule





