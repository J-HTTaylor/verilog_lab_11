module binary(
input w,
input clock,
input r,

output z,
output [2:0] binary
);

wire [2:0] state;
wire [2:0] next;

dff msb_init( //high to low
    .Default(1'b0),
    .D(next[2]),
    .clk(clock),
    .reset(r),
    .Q(state[2])
);

dff bit_init(
    .Default(1'b0),
    .D(next[1]),
    .clk(clock),
    .reset(r),
    .Q(state[1])
);

dff lsb_init(
    .Default(1'b0),
    .D(next[0]),
    .clk(clock),
    .reset(r),
    .Q(state[0])
);

assign z = (binary == 3'b010) | (binary == 3'b100) ;

assign next[2] = (w & state[2]) | (w & state[1] & state[0]); 
assign next[1] = (~state[1] & state[0]) | (state[1] & ~state[0]) | (w & ~state[2] & ~state[1]);
assign next[0] = (~w & ~state[1] & ~state[0]) | (w & ~state[2] & ~state[1]) | (w & ~state[2] & ~state[0]) | (~w &state[1] & state[0]);
assign binary = {state[2],state[1],state[0]};    
    endmodule