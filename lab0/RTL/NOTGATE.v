module NOTGATE(
    input wire a_i
    output wire b_o

);

assign b_o=~a_i;

endmodule // NOTGATE