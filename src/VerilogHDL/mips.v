module mips(clk,rst);
    input      clk ;
    input      rst ;
    
    wire   [31:26] opcode;
    wire   [5:0]   funct;
    wire   [1:0]   RegDst;
    wire           ALUSrc;
    wire   [1:0]   MemtoReg;
    wire           RegWe;
    wire           MemWe;
    wire           Branch;
    wire   [1:0]   Jump;
    wire   [1:0]   ExtOp;
    wire   [1:0]   ALUOp;
    wire   [31:0]  Instr;
    
    assign opcode = Instr[31:26];
    assign funct = Instr[5:0];
    
    controller CONTROL(opcode,funct,RegDst,ALUSrc,MemtoReg,RegWe,MemWe,Branch,Jump,ExtOp,ALUOp);
    datapath   DATAPATH(RegDst,ALUSrc,MemtoReg,RegWe,MemWe,Branch,Jump,ExtOp,ALUOp,clk,rst,Instr);
    
endmodule
