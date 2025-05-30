module Encoder (
    input  clk,
    input  rst_n,
    input  horario,
    input  antihorario,
    output  A,
    output  B
);
    reg [1:0] state;             // Estado da máquina de passos (0 a 4)
//Sentido horário: 00 → 10 → 11 → 01 → 00
//Sentido anti-horário: 00 → 01 → 11 → 10 → 00

    assign A = state [1];
    assign B = state [0];
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= 0; 
        end else begin
           case (state)
        
            2'b00: begin
                if (horario && !antihorario) 
                state <= 2'b10;
                if (antihorario && !horario)
                state <= 2'b01;
        
            end
            2'b01: begin
                if (horario && !antihorario) 
                state <= 2'b00;
                if (antihorario && !horario)
                state <= 2'b11;
                
            end
            2'b10: begin
                if (horario && !antihorario) 
                state <= 2'b11;
                if (antihorario && !horario)
                state <= 2'b00;
            end
            2'b11: begin
                if (horario && !antihorario) 
                state <= 2'b01;
                if (antihorario && !horario)
                state <= 2'b10;
            end                                    
            
           endcase
            
        end
    end
endmodule
