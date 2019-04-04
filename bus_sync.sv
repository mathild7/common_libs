`default_nettype none
module  bus_sync 
    #(
    parameter BUS_WIDTH  =1,
    parameter NUM_RETIME =2   
    )
    
    (
    input   logic                i_clk_b,
    input   logic [BUS_WIDTH-1:0] i_data_a,
    output  logic [BUS_WIDTH-1:0] o_data_b
    
);



   logic [BUS_WIDTH-1:0]   sync_reg1;
   logic [BUS_WIDTH-1:0]   sync_reg2;
   
   
bits_sync #(
	.BUS_WIDTH   (BUS_WIDTH  ), 
	.NUM_RETIME  (NUM_RETIME )
	) bits_sync (
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
	