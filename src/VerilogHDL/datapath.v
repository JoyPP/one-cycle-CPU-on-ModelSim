module datapath(regdst,alusrc,memtoreg,regwe,memwe,branch,jump,extop,aluop,clk,rst,instr);
    input   [1:0]  regdst ;   //destinate register
    input          alusrc ;   //alu's 2nd data's source
    input   [1:0]  memtoreg ; //data's source written into reg 
    input          regwe ;    //GPR write enable
    input          memwe ;    //dm write enable
    input          branch ;   //branch
    input   [1:0]  jump ;     //jump
    input   [1:0]  extop ;    //extender signal
    input   [1:0]  aluop ;    //alu signal
    input          clk ;      //clock
    input          rst ;      //reset
    output  [31:0] instr ;    //im output instruction
    
    wire   [31:0]    instr ;   //32-bit instruction
    wire   [31:2]    PC ;      //address of im
    wire   [31:2]    NPC ;     //next pc
    wire   [31:2]    pcfour ;  //pc+4
    wire             zero ;    //alu count,about beq
    wire   [4:0]     a3 ;      //destinate register
    wire   [31:0]    writedata;//data written into GPR
    wire   [31:0]    rd1,rd2 ; //read GPR 2 data
    wire   [31:0]    extout ;  //immdata after extended
    wire   [31:0]    aludata2 ;//2nd data into alu   
    wire   [31:0]    result ;  //alu counts result
    wire   [31:0]    dmout ;   //data output by dm
    
    //pc logic
    pc   pcx(NPC,PC,clk,rst);
    
    //npc logic
    npc   npcx(PC,instr[25:0],NPC,pcfour,branch,zero,jump,result);
    
    //im logic
    im_4k   im(PC[11:2],instr);    
    
    //register file logic
    mux3_5 mux3_1(instr[20:16],instr[15:11],5'b11111,regdst,a3);
    mux3_32 mux3_2(result,dmout,{pcfour,2'b00},memtoreg,writedata);
    regfile GPR(instr[25:21],instr[20:16],a3,writedata,rd1,rd2,regwe,clk,rst);
    
    //extender logic
    extender EXTENDER(instr[15:0],extout,extop);
    
    //alu logic
    mux2_32 mux2_1(rd2,extout,alusrc,aludata2);
    alu   ALU(rd1,aludata2,result,aluop,zero);
    
    //dm logic
    dm_4k   dm(result[11:2],rd2,memwe,clk,dmout);
       
    
endmodule
