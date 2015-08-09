module pc(NPC,PC,clk,rst);
    input   [31:2]   NPC ;//next pc
    input            clk ;//clock
    input            rst ;//reset
    output  [31:2]   PC ;//output pc
    
    reg   [31:2]   PC ;
    
    always @(posedge clk or posedge rst)
       begin
          if (rst)
             PC <= 30'h0c00 ;
          else
             PC <= NPC;
       end
endmodule


