module Encoder (
    input wire clk,
    input wire rst_n,
    input wire horario,
    input wire antihorario,
    output reg A,
    output reg B
);

    reg [1:0] seq_horario [0:3];
    reg [1:0] seq_antihorario [0:3];

    reg [2:0] step;
    reg active;
    reg direction; // 0 = horario, 1 = antihorario

    initial begin
        seq_horario[0] = 2'b00;
        seq_horario[1] = 2'b10;
        seq_horario[2] = 2'b11;
        seq_horario[3] = 2'b01;

        seq_antihorario[0] = 2'b00;
        seq_antihorario[1] = 2'b01;
        seq_antihorario[2] = 2'b11;
        seq_antihorario[3] = 2'b10;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            A <= 0;
            B <= 0;
            step <= 0;
            active <= 0;
            direction <= 0;
        end else begin
            if (!active) begin
                if (horario && !antihorario) begin
                    direction <= 0;
                    active <= 1;
                    step <= 0;
                end else if (!horario && antihorario) begin
                    direction <= 1;
                    active <= 1;
                    step <= 0;
                end
            end else begin
                // Em rotação ativa
                if (step < 4) begin
                    if (direction == 0) begin
                        {A, B} <= seq_horario[step];
                    end else begin
                        {A, B} <= seq_antihorario[step];
                    end
                    step <= step + 1;
                end else begin
                    active <= 0; // rotação concluída
                    step <= 0;
                end
            end
        end
    end

endmodule
