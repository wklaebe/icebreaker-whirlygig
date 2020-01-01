module whirlygig(clk,out);

    parameter cCountResultWidth = 8;
    parameter cCountInvsInRing = 3;
    parameter cCountUnitsPool = 16;
    parameter cCountAddressBits = 4;
    parameter cCountAddressLatches = (cCountResultWidth * cCountAddressBits);
    parameter cCountUnits = cCountUnitsPool + cCountAddressLatches + cCountResultWidth;

    input wire clk;
    output wire [cCountResultWidth-1:0] out;

    wire [cCountUnits - 1:0] wInv;
    reg [cCountUnits - 1:0] rLatch;
    reg [cCountResultWidth - 1:0] rOut;
    reg flip;

    integer i;

    genvar g;
    for (g = 0; g < cCountUnits; g = g + 1) begin
        inv_ring #(.invs(cCountInvsInRing)) inv_ring_inst[g] (.out(wInv[g]));
    end

    always @(posedge clk) begin
        rLatch[0] <= wInv[0] ^ flip ^ rLatch[cCountUnits - 1];
        for (i = 1; i < cCountUnits; i = i + 1) begin
            rLatch[i] <= wInv[i] ^ flip ^ rLatch[i - 1];
        end

        flip <= ~flip;

        for (i = 0; i < cCountResultWidth; i = i + 1) begin
            rOut[i] <= (rOut[i] ^ ((rLatch[(rLatch[cCountUnitsPool + i * cCountAddressBits + cCountAddressBits - 1:cCountUnitsPool + i * cCountAddressBits])])));
        end
    end

    assign out = rOut;

endmodule

module inv_ring(out);

    parameter invs = 3;

    output wire out;

    wire [invs-1:0] buffers_in, buffers_out;

    assign buffers_in = ~{buffers_out[0], buffers_out[invs-1:1]};

    SB_LUT4 #(
        .LUT_INIT(16'd2)
    ) buffers[invs-1:0] (
        .O(buffers_out),
        .I0(buffers_in),
        .I1(1'b0),
        .I2(1'b0),
        .I3(1'b0)
    );

    assign out = buffers_out[0];

endmodule
