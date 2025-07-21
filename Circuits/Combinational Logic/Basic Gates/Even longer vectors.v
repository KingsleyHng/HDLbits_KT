module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );
    
    
    genvar i;
    generate 
        for(i=0; i<=98; i=i+1)begin : gen_and
            assign out_both[i] = in[i] & in[i+1];  
        end
    endgenerate
    
    genvar u;
    generate 
        for(u=1; u<=99; u=u+1)begin : gen_any
            assign out_any[u] = in[u] | in[u-1];  
        end
    endgenerate
    
    
    genvar k;
    generate 
        for(k=0; k<=98; k=k+1)begin : gen_different
            assign out_different[k] = (in[k] !== in[k+1]);
        end
        
        assign out_different[99] = (in[99] !== in[0]);
    endgenerate
    

endmodule
