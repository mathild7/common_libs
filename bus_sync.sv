`default_nettype none
module  bus_sync 
    #(
    parameter BUS_WIDTH  =1,
    parameter NUM_RETIME =2   
    )
    
    (
    input   wire                i_clk_b,
    input   wire [BUS_WIDTH-1:0] i_data_a,
    output  reg [BUS_WIDTH-1:0] o_data_b
    
);



   logic [BUS_WIDTH-1:0]   sync_reg1;
   logic [BUS_WIDTH-1:0]   sync_reg2;
   
   
cov_core_bits_sync #(
	.BUS_WIDTH   (BUS_WIDTH  ), 
	.NUM_RETIME  (NUM_RETIME )
	) cov_core_bits_sync (
	.i_clk_b     (i_clk_b    ), 
	.i_data_a    (i_data_a   ), 
	.o_data_b    (sync_reg1  ));
	
always @(posedge i_clk_b) begin
	sync_reg2 <= sync_reg1;
end

always @(posedge i_clk_b) begin
	if (sync_reg2 == sync_reg1)
		o_data_b <= sync_reg2;
end
	
	
endmodule

`default_nettype wire	
	