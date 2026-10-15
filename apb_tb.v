module apb_tb();
	reg clk,rst,pwrite,pselx,penable;
	reg [7:0] paddr;
	reg [31:0] pwdata;
	wire pready;
	wire [31:0]prdata;

	apb amba(.clk(clk),.rst(rst),.pwrite(pwrite),.pselx(pselx),.penable(penable),.paddr(paddr),.pwdata(pwdata),.pready(pready),.prdata(prdata));

	always #5 clk = ~clk;

	initial
	begin
		clk = 0;
		rst = 0;
		#6 rst = 1;
	end

	initial
	begin
		$monitor("pwrite = %b, penable = %b, paddr = %b, pwdata = %b, prdata = %b",pwrite,penable,paddr,pwdata,prdata);

		#10 pwrite = 1; pselx = 1; penable = 1; paddr = $random; pwdata = 32'hfffff;
		#20 pwrite = 0; pselx = 1; penable = 1;
		#10 pwrite = 1; pselx = 1; penable = 1; paddr = $random; pwdata = $random;
		#20 pwrite = 0; pselx = 1; penable = 1;
		#10 pwrite = 1; pselx = 1; penable = 1; paddr = $random; pwdata = $random;
		#20 pwrite = 0; pselx = 1; penable = 1;
		#10 pwrite = 1; pselx = 1; penable = 1; paddr = $random; pwdata = $random;
		#20 pwrite = 0; pselx = 1; penable = 1;

	end

	initial
	begin
		$fsdbDumpfile("dump.fsdb");
		$fsdbDumpvars(0,apb_tb);
		#100 $finish;
	end
endmodule 
