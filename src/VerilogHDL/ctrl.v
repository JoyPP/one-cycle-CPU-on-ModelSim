module controller(opcode,funct,regdst,alusrc,memtoreg,regwe,memwe,branch,jump,extop,aluop);
    input   [31:26] opcode;   //6-bit opcode
    input   [5:0]   funct ;   //6-bit function
    output  [1:0]   regdst;   //destinate register
    output          alusrc;   //alu's 2nd data's source
    output  [1:0]   memtoreg; //data's source written into reg 
    output          regwe;    //GPR write enable
    output          memwe;    //dm write enable
    output          branch;   //branch
    output   [1:0]  jump;     //jump
    output   [1:0]  extop;    //extender signal
    output   [1:0]  aluop;    //alu signal
    
    parameter   RD = 2'b00, RT = 2'b01, RA = 2'b10;   //[1:0]regdst
    parameter   Alu = 2'b00, DM = 2'b01, PCfour = 2'b10;   //[1:0]memtoreg 
    parameter   Nojump = 2'b00, J = 2'b01, JAL = 2'b10, JR = 2'b11;      //[1:0]jump
    parameter   O_ExT = 2'b00, sign_ExT = 2'b01, lui_ExT = 2'b10; //[1:0]extop
    parameter   ADD = 2'b00, SUB = 2'b01, OR = 2'b10, SLT = 2'b11;//[1:0]aluop
    
    reg   [13:0] controls;
    
    assign {regdst,alusrc,memtoreg,regwe,memwe,branch,jump,extop,aluop} = controls;
                 
    always @(*)
       case(opcode)
           6'b000000:   //Rtype
              begin
                  case(funct)
                      6'b100001: controls <= 14'b01000100000000 ;//addu
                      6'b100011: controls <= 14'b01000100000001 ;//subu
                      6'b101010: controls <= 14'b01000100000011 ;//slt
                      6'b001000: controls <= 14'b01000000110000 ;//jr
                  endcase
              end
           6'b001000: controls <= 14'b00100100000100 ;//addi
           6'b001001: controls <= 14'b00100100000100 ;//addiu
           6'b001101: controls <= 14'b00100100000010 ;//ori
           6'b000100: controls <= 14'b00000001000001 ;//beq
           6'b000010: controls <= 14'b00000000010000 ;//j
           6'b000011: controls <= 14'b10010100100000 ;//jal
           6'b100011: controls <= 14'b00101100000100 ;//lw
           6'b101011: controls <= 14'b00100010000100 ;//sw
           6'b001111: controls <= 14'b00100100001000 ;//lui
           default: controls <= 14'bxxxxxxxxxxxxxx ;//undefined instruction 
       endcase
       
       
endmodule