module alu(data1,data2,result,aluop,zero);
    
   input   [31:0]   data1,data2;
   input   [1:0]    aluop;
   output  [31:0]   result;
   output           zero;
   
   reg     [31:0]   result;
   wire             zero;
   parameter   ADD = 2'b00, SUB = 2'b01, OR = 2'b10, SLT = 2'b11;
   
   assign   zero = (result == 32'b0);  
   
   always @(*)
      case(aluop[1:0])
          2'b00: result = data1 + data2 ;
          2'b01: result = data1 - data2 ;
          2'b10: result = data1 | data2 ;
          2'b11: 
             begin
                if ( data1 < data2 )
                   result <= 1;
                 else result <= 0;
             end
      endcase
      
endmodule
