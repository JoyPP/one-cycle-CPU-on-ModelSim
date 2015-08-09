module regfile(a1,a2,a3,writedata,rd1,rd2,regwe,clk,rst);   
    input   [4:0]   a1,a2,a3;      //rs,rt,rd
    input   [31:0]  writedata;     //data to be written into register
    input           regwe;         //enable write data into register
    input           clk,rst;           //clock
    output  [31:0]  rd1,rd2;       //data be read from register
    
    reg   [31:0]   rf[31:0];   //32 registers
    wire           regwe;
    integer         i;
    
    always @(negedge clk or posedge rst)
       begin
          if (rst)
             for (i=0;i<32;i=i+1)  //32 regs <= 32'b0
                rf[i] <= 32'b0;           
          else if (regwe)         //regwe enable,write into reg
                rf[a3] <= writedata;
       end
    
    assign rd1 = (a1 != 0) ? rf[a1] : 0 ;//other regs and 0 reg
    assign rd2 = (a2 != 0) ? rf[a2] : 0 ;
        
endmodule
