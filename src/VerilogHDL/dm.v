module dm_4k(addr,din,we,clk,dout);
    input   [11:2]  addr;   //address bus
    input           we;     //memory write enable
    input           clk;    //clock
    input   [31:0]  din;    //32-bit input data
    output  [31:0]  dout;   //32-bit memory output
    
    wire  [31:0]   dout;
    reg   [31:0]   dm[1023:0];//1024 32-bit dm-regs
    
    initial
       $readmemh("data.txt",dm);  //lead datas into dmreg
       
  
    always @(negedge clk)
       if (we)
          dm[addr] <= din;  //if we enable,write into dmreg
          
 
    assign   dout = dm[addr];   //output data
    
endmodule