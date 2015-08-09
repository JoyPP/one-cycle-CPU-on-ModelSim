module extender(immext,extout,extop);
    input   [15:0]   immext;
    input   [1:0]    extop;
    output  [31:0]   extout;
    
    parameter   O_ExT = 2'b00, sign_ExT = 2'b01, lui_ExT = 2'b10;
    wire      [31:0]  extout;
    
    mux3_32 mux3_0({16'b0,immext},{{16{immext[15]}},immext},{immext,16'b0},extop,extout);
       
endmodule
