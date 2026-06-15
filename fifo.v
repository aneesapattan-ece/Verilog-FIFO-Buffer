module fifo(
    input clk,
    input reset,
    input write_en,
    input read_en,
    input [7:0] write_data,
    output reg [7:0] read_data,
    output full,
    output empty
);

reg [7:0] mem [0:7];

reg [2:0] write_ptr;
reg [2:0] read_ptr;
reg [3:0] count;

assign full  = (count == 8);
assign empty = (count == 0);

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        write_ptr <= 0;
        read_ptr <= 0;
        count <= 0;
        read_data <= 0;
    end
    else
    begin
        // Write Operation
        if(write_en && !full)
        begin
            mem[write_ptr] <= write_data;
            write_ptr <= write_ptr + 1;
            count <= count + 1;
        end

        // Read Operation
        if(read_en && !empty)
        begin
            read_data <= mem[read_ptr];
            read_ptr <= read_ptr + 1;
            count <= count - 1;
        end
    end
end

endmodule