module CONTROLHAZARD (
    input wire clk,
    input wire rstn,
    input wire [31:0] INST,
    output reg s
);
reg [1:0] state=2'b00;
always @(posedge rstn) begin
    s=0;
end
always @(negedge clk) begin
    if(state==2'b00)begin//预测分支不发生1 
        if(INST[6:0]==7'b1101111)begin//JAL
            state=state+1;
            s=1;
        end
        if(INST[6:0]==7'b1100011)begin//beq
            state=state+1;
            s=1;
        end
        else begin
            s=0;
        end
    end
    if(state==2'b01)begin//预测分支不发生2
        if(INST[6:0]==7'b1101111)begin//JAL
            state=state+1;
            s=1;
        end
        if(INST[6:0]==7'b1100011)begin//beq
            state=state+1;
            s=1;
        end
        else begin
            state=state-1;
            s=0;
        end
    end
    if(state==2'b10)begin//预测分支发生2
        if(INST[6:0]==7'b1101111)begin//JAL
            state=state+1;
            s=1;
        end
        if(INST[6:0]==7'b1100011)begin//beq
            state=state+1;
            s=1;
        end
        else begin
            state=state-1;
            s=0;
        end
    end
    if(state==2'b10)begin//预测分支发生2
        if(INST[6:0]==7'b1101111)begin//JAL
            s=1;
        end
        if(INST[6:0]==7'b1100011)begin//beq
            s=1;
        end
        else begin
            state=state-1;
            s=0;
        end
    end
end

endmodule //CONTROLHAZARD