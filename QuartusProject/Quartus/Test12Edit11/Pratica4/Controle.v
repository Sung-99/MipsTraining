module Controle(OPcode, RegWrite, ALUSrc, ALUOp, regDst, branch, MemRead, memtoReg, MemWrite);
    input [5:0] OPcode;      
    
    output RegWrite;     
    output ALUSrc;
	 output regDst;
	 output branch;
	 output MemRead;
	 output memtoReg;
	 output MemWrite;
    output [1:0] ALUOp;

	 wire op5, op4, op3, op2, op1, op0;
    assign {op5, op4, op3, op2, op1, op0} = OPcode;
   
	  wire tipoR;
	  wire lw;
	  wire sw;
	  wire beq;
	
	  assign tipoR = (~op5 & ~op4 & ~op3 & ~op2 & ~op1 & ~op0);
     assign lw       = ( op5 & ~op4 & ~op3 & ~op2 &  op1 &  op0);
     assign sw       = ( op5 & ~op4 &  op3 & ~op2 &  op1 &  op0); 
     assign beq      = (~op5 & ~op4 & ~op3 &  op2 & ~op1 & ~op0);
	  assign addi     = (~op5 & ~op4 & op3 &  ~op2 & ~op1 & ~op0);
	  
	  assign regDst	 = tipoR;          
     assign ALUSrc   = lw | sw | addi;           
     assign RegWrite = tipoR | lw | addi;      
     assign ALUOp    = {tipoR, beq};
	  assign branch = beq;
	  assign MemRead = lw;
	  assign memtoReg = lw;
	  assign MemWrite = sw;
	  
endmodule
