module top(
    input sw, // w
    output [9:0] led, // see IO table
    input btnC, // clk
    input btnU // reset
);

    onehot hot(
        .w(sw),
        .clock(btnC),
        .r(btnU),
        .z(led[0]),
        .Astate_out(led[2]),
        .Bstate_out(led[3]),
        .Cstate_out(led[4]),
        .Dstate_out(led[5]),
        .Estate_out(led[6])
    );
    // Hook up binary and one-hot state machines
      binary init(
        .w(sw),
        .clock(btnC),
        .r(btnU),
       
        .z(led[1]),
        .binary(led[9:7])
    );
    
endmodule