module onehot(
input w,
input clock,
input r,

output z, Astate_out, Bstate_out, Cstate_out, Dstate_out, Estate_out
);

wire Astate, Bstate, Cstate, Dstate, Estate;
wire Bnext, Cnext, Dnext, Enext;

    dff Adff(
    .Default(1'b1),
    .D(0), //Anext not needed as A is never called
    .clk(clock),
    .reset(r),
    .Q(Astate)
    );
    
    dff Bdff(
    .Default(1'b0),
    .D(Bnext),
    .clk(clock),
    .reset(r),
    .Q(Bstate)
    );
    
    dff Cdff(
    .Default(1'b0),
    .D(Cnext),
    .clk(clock),
    .reset(r),
    .Q(Cstate)
    );
    
    dff Ddff(
    .Default(1'b0),
    .D(Dnext),
    .clk(clock),
    .reset(r),
    .Q(Dstate)
    );
    
    dff Edff(
    .Default(1'b0),
    .D(Enext),
    .clk(clock),
    .reset(r),
    .Q(Estate)
    );
    
    assign z = Estate | Cstate;
    
    assign Astate_out = Astate;
    assign Bstate_out = Bstate;
    assign Cstate_out = Cstate;
    assign Dstate_out = Dstate;
    assign Estate_out = Estate;
    
    assign Bnext = ~w & (Astate| Dstate | Estate) ;
    assign Cnext = ~w & (Bstate | Cstate);
    assign Dnext = w & (Astate | Bstate | Cstate);
    assign Enext = w & (Dstate | Estate);
endmodule