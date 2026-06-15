module testbench;

reg clk;
reg reset;
reg write_en;
reg read_en;
reg [7:0] write_data;

wire [7:0] read_data;
wire full;
wire empty;

fifo uut(
    .clk(clk),
    .reset(reset),
    .write_en(write_en),
    .read_en(read_en),
    .write_data(write_data),
    .read_data(read_data),
    .full(full),
    .empty(empty)
);

always #5 clk = ~clk;

initial
begin
    $dumpfile("dump.vcd");
    $dumpvars(0, testbench);

    clk = 0;
    reset = 1;
    write_en = 0;
    read_en = 0;
    write_data = 0;

    #10 reset = 0;

    // Write Data
    write_en = 1;

    write_data = 8'h11; #10;
    write_data = 8'h22; #10;
    write_data = 8'h33; #10;
    write_data = 8'h44; #10;

    write_en = 0;

    #20;

    // Read Data
    read_en = 1;

    #10;
    #10;
    #10;
    #10;

    read_en = 0;

    #20;

    $finish;
end

endmodule