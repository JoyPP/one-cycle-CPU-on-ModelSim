module npc(PC,imminstr,NPC,pcfour,branch,zero,jump,aluresult);
    input   [31:2]   PC ;       //output pc,for counting nextpc
    input   [25:0]   imminstr ; //instr jump and branch for next pc
    input            branch ;   //instr branch
    input            zero;      //if branch,beq?
    input   [1:0]    jump   ;   //instr jump 
    input   [31:0]   aluresult ;//alu result,for jr
    output  [31:2]   NPC ;      //nextpc
    output  [31:2]   pcfour ;   //pc+4
    
    parameter       Nojump = 2'b00, J = 2'b01, JAL = 2'b10, JR = 2'b11;//[1:0]jump
    reg   [31:2]    NPC ;
    reg   [31:2]    pcfour ;
      
    always @(*)
       begin
          pcfour <= PC + 1;      //pc+4
          if (branch && zero)         //if beq
             NPC <= {{14{imminstr[15]}},imminstr[15:0]} + pcfour ;
          else 
             begin
                if ((jump != Nojump)&&(jump != JR))   //if jump and jump!=jr
                   NPC <= {PC[31:28],imminstr} ;
                else if (jump == JR)      //jr ,npc<=GPR[rs]
                   NPC <= aluresult[31:2];
                else if (jump == Nojump)   //no jump and no branch,pc+4
                   NPC <= pcfour;
             end
       end
 
endmodule
