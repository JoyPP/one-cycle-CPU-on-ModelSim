module testbench();
    reg    clk ;
    reg    rst ;
    
    //instantiate module of mips
    mips MIPS(clk,rst);

    //initialize test
    initial 
       begin
           clk <= 1 ;
           rst <= 1 ;
           #20 rst <= 0 ;
           
           #12000 $stop ;
       end
        
   
    //generate clock
    always
       #40 clk=~clk ;
    
endmodule