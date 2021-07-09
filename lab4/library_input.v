// Lab4
// Username: Fakas		AEM: 1787
// Username: tsitsopoulos	AEM: 2283

`timescale 1ns/1ps


// Small ALU. Inputs: inA, inB. Output: out. 
// Operations: bitwise and (op = 0)
//             bitwise or  (op = 1)
//             addition (op = 2)
//             subtraction (op = 6)
//             slt  (op = 7)
//             nor (op = 12)
module ALU (out, zero, inA, inB, op);
  parameter N = 32; // It was 8
  output [N-1:0] out;
  output zero;
  input  [N-1:0] inA, inB;
  input    [3:0] op;
  reg	 [N-1:0] out;
 // Place your Verilog code here 
  always @(*)
  begin
  case (op)
	4'b0000: out =  inA & inB;
	4'b0001: out =  inA | inB;
	4'b0010: out =  inA + inB;
	4'b0110: out =  inA - inB;
	4'b0111: out =  ((inA < inB)?2'b01:2'b00);
	4'b1100: out = ~(inA | inB);
	default: out =  {N{1'bx}};
  endcase
  end
  assign zero =  ((out == 0)?1:0);
  
 /* RegFile instance(
  .rdA (inA),
  .rdB (inB));
  endmodule*/


// Register File. Read ports: address raA, data rdA
//                            address raB, data rdB
//                Write port: address wa, data wd, enable wen.
module RegFile (clock, reset, raA, raB, wa, wen, wd, rdA, rdB);
  output [31:0] rdA, rdB;
  input		clock, reset, wen;
  input  [31:0] wd;
  input   [4:0] raA, raB, wa;
  reg    [31:0] data[31:0];
  reg	 [31:0] rdA, rdB;
  integer i;
  // Place your verilog code here. 
  // Remember that the register file should be written at the negative edge of the input clock 

  always @(negedge clock or negedge reset)
  begin
  if(~reset)
	for(i=0; i<=31; i=i+1)
		data[i] <= 32'b00;
  else
	if(wen)
		data[wa] <= wd;
  end

  always @(*)  //Asigxrono always...
  begin
  	rdA = data[raA];
  	rdB = data[raB];
  end

//  ALU instance(
//  .out(wd));

endmodule


