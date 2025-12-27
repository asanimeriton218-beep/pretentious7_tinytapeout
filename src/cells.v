module tt_um_m_prs_cpu (
    input  wire        clk,
    input  wire        rst_n,

    input  wire [7:0]  ui_in,    // switch_in
    output reg  [7:0]  uo_out,   // led_out

    input  wire [7:0]  uio_in,
    output wire [7:0]  uio_out,
    output wire [7:0]  uio_oe
);

    // Required by TinyTapeout
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire reset = ~rst_n;

    // ======================
    // CPU REGISTERS
    // ======================
    reg [7:0] PC;
    reg [7:0] ACC;
    reg [7:0] IR;

    wire [3:0] opcode  = IR[7:4];
    wire [3:0] operand = IR[3:0];

    reg [7:0] ALU_result;

    // ======================
    // RAM (16 bytes)
    // ======================
    reg [7:0] RAM [0:15];

    // ======================
    // STACK (8 entries)
    // ======================
    reg [7:0] STACK [0:7];
    reg [2:0] SP;

    // ======================
    // ALU
    // ======================
    always @(*) begin
        case (opcode)
            4'b0011: ALU_result = ACC + RAM[operand]; // ADD
            4'b0101: ALU_result = ACC - RAM[operand]; // SUB
            default: ALU_result = ACC;
        endcase
    end

    // ======================
    // CPU MAIN
    // ======================
    integer i;
    always @(posedge clk) begin
        if (reset) begin
            PC     <= 8'd0;
            ACC    <= 8'd0;
            IR     <= 8'd0;
            SP     <= 3'd0;
            uo_out <= 8'd0;

            for (i = 0; i < 16; i = i + 1)
                RAM[i] <= 8'd0;

        end else begin
            // FETCH
            IR <= RAM[PC[3:0]];
            PC <= PC + 8'd1;

            // EXECUTE
            case (opcode)

                4'b0000: begin
                    // NOP
                end

                4'b0001: begin
                    // LOAD
                    ACC <= RAM[operand];
                end

                4'b0010: begin
                    // STORE
                    RAM[operand] <= ACC;
                end

                4'b0011: begin
                    // ADD
                    ACC <= ALU_result;
                end

                4'b0101: begin
                    // SUB
                    ACC <= ALU_result;
                end

                4'b0110: begin
                    // PUSH
                    STACK[SP] <= ACC;
                    SP <= SP + 3'd1;
                end

                4'b0111: begin
                    // POP
                    SP <= SP - 3'd1;
                    ACC <= STACK[SP - 1];
                end

                4'b1000: begin
                    // JMP
                    PC <= {4'b0000, operand};
                end

                4'b1001: begin
                    // IO WRITE
                    uo_out <= ACC;
                end

                4'b1010: begin
                    // IO READ
                    ACC <= ui_in;
                end

                default: begin
                    // unused
                end
            endcase
        end
    end

endmodule
