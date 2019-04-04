module  bits_sync 
    #(
    parameter BUS_WIDTH  =1,
    parameter NUM_RETIME =2   
    )
    
    (
    input   wire                i_clk_b,
    input   wire[BUS_WIDTH-1:0] i_data_a,
    output  wire[BUS_WIDTH-1:0] o_data_b
    
);



   reg [NUM_RETIME-1:0][BUS_WIDTH-1:0]   sync_reg;

   genvar 			i;
   integer                      j;


   generate for (i=0; i < BUS_WIDTH; i=i+1)
     begin : db
        always @(posedge i_clk_b)
            begin
               for (j = 0; j < NUM_RETIME; j=j+1) begin
                 if (j==0) begin
                   sync_reg[j][i] <= i_data_a[i];
                 end else begin
                   sync_reg[j][i] <= sync_reg[j-1][i];
                 end
               end
            end    
        assign o_data_b[i] = sync_reg[NUM_RETIME-1][i];
    end   
   endgenerate


endmodule

