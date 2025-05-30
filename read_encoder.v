module Read_Encoder (
    input wire clk,
    input wire rst_n,
    input wire A,
    input wire B,
    output reg [1:0] dir
);

    reg [1:0] curr_state, prev_state;

    always @(negedge clk or posedge rst_n) begin
        if (!rst_n) begin
            curr_state <= 2'b00;
            prev_state <= 2'b00;
            dir <= 2'b00;
        end else begin
            prev_state <= curr_state;
            curr_state <= {A, B};

            case ({prev_state, curr_state})
                // Sentido horário: 00→10, 10→11, 11→01, 01→00
                4'b0010, 4'b1011, 4'b1101, 4'b0100: dir <= 2'b01;

                // Sentido anti-horário: 00→01, 01→11, 11→10, 10→00
                4'b0001, 4'b0111, 4'b1110, 4'b1000: dir <= 2'b10;

                default: dir <= 2'b00; 
            endcase
        end
    end
endmodule
