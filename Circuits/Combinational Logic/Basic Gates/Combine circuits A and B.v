module top_module (input x, input y, output z);

    wire z_IA1, z_IA2, z_IB1, z_IB2;
    wire or_out, and_out;
    
    A IA1(.x(x), .y(y), .z(z_IA1));
    A IA2(.x(x), .y(y), .z(z_IA2));    
    B IB1(.x(x), .y(y), .z(z_IB1));     
    B IB2(.x(x), .y(y), .z(z_IB2));
    
    
    assign or_out = z_IA1 | z_IB1;
    assign and_out = z_IA2 & z_IB2;
    
    assign z = or_out^and_out;
    
endmodule


module A (input x, input y, output z);
    assign z = (x^y) & x;
    
endmodule

module B ( input x, input y, output z ); 
    assign z = ~(x^y);
    
endmodule
