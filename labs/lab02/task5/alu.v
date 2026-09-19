// alu.v
// 1-bit-opcode ALU: op=0 -> add, op=1 -> sub. 4-bit operands.

module alu (
    input      [3:0] a,
    input      [3:0] b,
    input            op,      // 0 = add, 1 = sub
    output reg [3:0] result
);

  reg [3:0] b_inv;
  reg [3:0] b_twos;

  // FIX 1: Added 'op' to the sensitivity list so result updates when op changes
  always @(a, b, op) begin
    case (op)
      1'b0: begin
        result = a + b;  // add
      end
      1'b1: begin
        // FIX 2: Replaced non-blocking (<=) with blocking (=) assignments 
        // so intermediate values (b_inv, b_twos) update immediately in sequence
        b_inv  = ~b;  // sub, via two's complement
        b_twos = b_inv + 1'b1;
        result = a + b_twos;
      end
    endcase
  end

endmodule