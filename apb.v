module apb(clk,rst,pwrite,pselx,penable,paddr,pwdata,pready,prdata);
	input clk,rst,pwrite,pselx,penable;
	input [7:0] paddr;
	input [31:0] pwdata;
	output pready;
	output reg [31:0]prdata;
	parameter idle = 0, setup = 1, access = 2;
	reg [1:0]cs,ns;
	reg [31:0]prdata_temp;
	reg [31:0]mem[255:0];
	integer i;

	assign pready = (pselx && penable);

	always@(posedge clk)
	begin
		if(!rst)
		begin
			prdata <= 0;
			cs <= 0;
			prdata_temp <= 0;
			for(i=0;i<256;i=i+1)
				mem[i] <= 0;
		end
		else
			cs <= ns;
	end

	always@(*)
	begin
		case(cs)
			idle: begin
				if(pselx)
					ns = setup;
				else
					ns = idle;
			end

			setup: begin
				if(pselx && penable)
					ns = access;
				else if(pselx && penable == 0)
					ns = setup;
				else
					ns = idle;
			end

			access: begin
				if(pwrite)
					mem[paddr] = pwdata;
				else
					prdata = mem[paddr];
				// ns = idle;
				if(pready)
					ns = idle;
				else
					ns = access;  
			end
					
		endcase
	end
endmodule
