
`timescale 1ns/1ps


// Small ALU. Inputs: inA, inB. Output: out. 
// Operations: bitwise and (op = 0)
//             bitwise or  (op = 1)
//             addition (op = 2)
//             subtraction (op = 6)
//             slt  (op = 7)
//             nor (op = 12)
module ALU (out, zero, inA, inB, op);
  parameter N = 8;
  output [N-1:0] out;
  output zero;
  input  [N-1:0] inA, inB;
  input    [3:0] op;
  reg [N-1:0] out;

 // Place your Verilog code here 
  always @(*)
  begin
      case (op)
       4'b0000: out=inA&inB;
       4'b0001: out=inA|inB;
       4'b0010: out=inA+inB;
       4'b0110: out=inA-inB;
       4'b0111: out=((inA < inB)?1:0);
       4'b1100: out=~( inA | inB);
       default: out=4'bxxxx;
       endcase
  end
  assign zero= ((out==0)?1:0);

RegFile reg1(.rdA (inA), .rdB(inB));
endmodule


// Register File. Read ports: address raA, data rdA
//                            address raB, data rdB
//                Write port: address wa, data wd, enable wen.
module RegFile (clock, reset, raA, raB, wa, wen, wd, rdA, rdB);
	input clock;
	input reset;
	input wen;
	input[4:0] raA, raB;
	input [4:0] wa;
	input [31:0] wd;
	output [31:0] rdA, rdB;
	reg [31:0] mem[0:31];
	reg [31:0] rdA, rdB;
	reg [4:0] i;

	always@(*)
	begin
		rdA = mem[raA];
		rdB = mem[raB];

	end

 	always@(negedge clock or reset)
	begin
  	if(~reset)
		for(i=0; i<32; i=i+1)
			mem[i]<=0;
	else
		if(wen)
			mem[wa] <= wd;
	
	end

ALU alu1(.out(wd));
endmodule

