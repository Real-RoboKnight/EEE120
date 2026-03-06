`timescale 1ns/1ns

// IMPORTANT: DO NOT MODIFY ANYTHING BETWEEN HERE AND *****

// Module to provide stimulus to the ALU
module my_test(num_tests,values,addr,filename);
output [3:0]   num_tests;       // how many tests to apply: limit is 16
output [17:0]  values;          // the values to apply plus expected response
output [511:0] filename;        // the VCD filename to use
input  [2:0]   addr;            // the address into the memory of values

wire [511:0] filename;          // the VCD filename to use
reg [17:0] test_vals [0:7];     // memory to hold the input and expected output

// The bits of the test_vals memory are:
// 17    - expected overfl value
// 16    - expected cout value
// 15:12 - expected y value
// 11    - cin input
// 10    - arith input
//  9    - invert input
//  8    - pass input
//  7:4  - a input
//  3:0  - b input

initial    // check for too many tests
begin
   #1 if ( num_tests > 8 )
      begin
         $display("Too many tests - the limit is 8!");
         $finish;
      end
end

assign values = test_vals[addr];

// IMPORTANT: ONLY MODIFY BELOW THIS LINE *****

assign num_tests = 8;                // how many tests you want to run
assign filename = "alu_add.vcd";     // the name of the VCD file

// Each assignment to test_vals[#] is one test.
// NOTE: The maximum number of tests is 8, and they are numbered 0-7.
// NOTE: The tests MUST be numbered consecutively starting with 0.

initial
begin
//Since we are testing addition, the center nibble should either be a 4(add), or a 12 (add w/ cin)
   test_vals[0] = 18'h0_3_4_1_2; // Check small numbers add correctly
   test_vals[1] = 18'h0_0_4_0_0; // Check that there are no stuck bits
   test_vals[2] = 18'h2_D_4_7_6; // Check that one large unsigned number and a smaller number add correctly
   test_vals[3] = 18'h1_A_4_F_B; // Check that two negative numbers add correctly with no overflow
   test_vals[4] = 18'h3_1_4_9_8; // Check that overflow happens correctly.
   test_vals[5] = 18'h0_1_C_0_0; // Check Cin adds correctly
   test_vals[6] = 18'h2_B_C_5_5; // Check Cin adds correctly
   test_vals[7] = 18'h1_0_C_8_7; // Check Cin adds correctly, and -(-8) = -8, as there is no positive representatation
end

endmodule
