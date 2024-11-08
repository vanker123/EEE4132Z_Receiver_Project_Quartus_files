module Receiver_project_top_level(
	input wire reset
);	
wire[3:0] 	receiver1;
wire[3:0] 	receiver2;
wire[3:0] 	receiver3;
wire[3:0] 	receiver4;



wire 			osenable;
assign 		osenable 		= 1;
wire 			clk;
reg  [19:0] address;
wire [19:0]	fftpts;
assign 		fftpts			=20'd262144;
wire 			source_Ready;
assign 		source_Ready	=1;

wire       	sink_valid1;
wire        sink_sop1;   
wire        sink_eop1; 
wire       	sink_valid2;
wire        sink_sop2;   
wire        sink_eop2;
wire       	sink_valid3;
wire        sink_sop3;   
wire        sink_eop3; 
wire       	sink_valid4;
wire        sink_sop4;   
wire        sink_eop4;  



wire [3:0]  realFFT1in;
wire [3:0]  imagFFT1in;
wire [7:0]  realOutput1;
wire [7:0]  imagOutput1;
wire [7:0]  Real_multi_out1;	
wire [7:0]  imag_multi_out1 ;
wire 			sink_ready1;
wire 			source_valid1;

wire [3:0]  realFFT2in;
wire [3:0]  imagFFT2in;
wire [7:0]  realOutput2;
wire [7:0]  imagOutput2;
wire [7:0]  Real_multi_out2;	
wire [7:0]  imag_multi_out2 ;
wire 			sink_ready2;
wire 			source_valid2;	

wire [3:0]  realFFT3in;
wire [3:0]  imagFFT3in;
wire [7:0]  realOutput3;
wire [7:0]  imagOutput3;
wire [7:0]  Real_multi_out3;	
wire [7:0]  imag_multi_out3 ;
wire 			sink_ready3;
wire 			source_valid3;	

wire [3:0]  realFFT4in;
wire [3:0]  imagFFT4in;
wire [7:0]  realOutput4;
wire [7:0]  imagOutput4;
wire [7:0]  Real_multi_out4;	
wire [7:0]  imag_multi_out4 ;
wire 			sink_ready4;
wire 			source_valid4;	

wire 			isink_valid1; 
wire 			isink_ready1; 
wire 			isink_sop1; 
wire 			isink_eop1; 
wire 			isource_valid1; 
wire [7:0] 	irealOutput1; 
wire [7:0] 	iimagiOutput1;

wire 			isink_valid2; 
wire 			isink_ready2; 
wire 			isink_sop2; 
wire 			isink_eop2; 
wire 			isource_valid2; 
wire [7:0] 	irealOutput2; 
wire [7:0] 	iimagiOutput2;

wire 			isink_valid3; 
wire 			isink_ready3; 
wire 			isink_sop3; 
wire 			isink_eop3; 
wire 			isource_valid3; 
wire [7:0] 	irealOutput3; 
wire [7:0] 	iimagiOutput3;

wire 			isink_valid4; 
wire 			isink_ready4; 
wire 			isink_sop4; 
wire 			isink_eop4; 
wire 			isource_valid4; 
wire [7:0] 	irealOutput4; 
wire [7:0] 	iimagiOutput4;

wire [15:0] DataOutput1;
wire [15:0] DataOutput2;
wire [15:0] DataOutput3;
wire [15:0] DataOutput4;


wire [1:0] 	sink_error;
assign 		sink_error	=2'b00;
wire [7:0] 	XFactor;
assign 		XFactor 		= 8'b00000101;
wire 			InverseFFT;
assign 		InverseFFT 	= 1;
wire 			ForwardFFT;
assign 		ForwardFFT 	= 0;
wire 			wren;
assign 		wren 		   = 1;

Internal_OSC Internal_OSC_inst (
	.oscena (osenable),
	.clkout (clk) 
);

always @(posedge clk or posedge reset) begin
        if (reset) begin
            address <= 20'b0;
        end else begin
            // Increment address to read next ROM data
            if (address < 20'b11110100001000111111) // Assuming maximum address for 1,000,000 entries
                address <= address + 20'b1;
            else
                address <= 0; // Loop back to start
        end
    end

//Instantiate ROM 1(Receiver1)
Receiver1	Receiver1_inst (
	.address ( address),//address input
	.clock 	( clk ),//internal clock input
	.q 		( receiver1 )//output from rom to FFt
	);
	
//Instantiate ROM 2(Receiver2)
receiver2 receiver2_inst(
	.address ( address),
	.clock 	( clk ),
	.q 		( receiver2 )
);

//Instantiate ROM 3(Receiver3)
Receiver3	Receiver3_inst (
	.address ( address),
	.clock 	( clk ),
	.q 		( receiver3 )
	);

//Instantiate ROM 4(Receiver4)
Receiver4	Receiver4_inst (
	.address ( address),
	.clock 	( clk ),
	.q 		( receiver4 )
	);	
	

FFTcontrol FFT1control_inst
(
	.clk(clk) ,	// internal clock
	.FFTin(receiver1) ,	// output from ROM for specific address
	.sink_valid(sink_valid1) ,	
	.sink_sop(sink_sop1) ,	
	.sink_eop(sink_eop1) ,	
	.realFFTin(realFFT1in),	
	.imagFFTin(imagFFT1in) 	
);
FFTcontrol FFT2control_inst
(
	.clk(clk) ,
	.FFTin(receiver2) ,	
	.sink_valid(sink_valid2) ,
	.sink_sop(sink_sop2) ,	
	.sink_eop(sink_eop2) ,
	.realFFTin(realFFT2in) ,	
	.imagFFTin(imagFFT2in) 	

);

FFTcontrol FFT3control_inst
(
	.clk(clk) ,	
	.FFTin(receiver3),
	.sink_valid(sink_valid3) ,	
	.sink_sop(sink_sop3) ,
	.sink_eop(sink_eop3) ,	
	.realFFTin(realFFT3in) ,	
	.imagFFTin(imagFFT3in) 	

);

FFTcontrol FFT4control_inst
(
	.clk(clk) ,	
	.FFTin(receiver4) ,	
	.sink_valid(sink_valid4) ,	
	.sink_sop(sink_sop4) ,
	.sink_eop(sink_eop4) ,	
	.realFFTin(realFFT4in) ,	
	.imagFFTin(imagFFT4in) 	
);
		
	
ReceiverFFT Receiver1FFT_inst (
	.clk          (clk),          
	.reset_n      (reset),      
	.sink_valid   (sink_valid1),   
	.sink_ready   (sink_ready1),   
	.sink_error   (sink_error),   
	.sink_sop     (sink_sop1),     
	.sink_eop     (sink_eop1),     
	.sink_real    (realFFT1in), 
	.sink_imag    (imagFFT1in),    
	.fftpts_in    (fftpts),    
	.inverse      (ForwardFFT),      
	.source_valid (source_valid1), 
	.source_ready (source_Ready), 
	.source_real  (realOutput1),  
	.source_imag  (imagOutput1)
	);

ReceiverFFT Receiver2FFT_inst (
	.clk          (clk),          
	.reset_n      (reset),      
	.sink_valid   (sink_valid2),   
	.sink_ready   (sink_ready2),   
	.sink_error   (sink_error),   
	.sink_sop     (sink_sop2),     
	.sink_eop     (sink_eop2),     
	.sink_real    (realFFT2in),    
	.sink_imag    (imagFFT2in),    
	.fftpts_in    (fftpts),    
	.inverse      (ForwardFFT),      
	.source_valid (source_valid2), 
	.source_ready (source_Ready), 
	.source_real  (realOutput2),  
	.source_imag  (imagOutput2)  
	);	
	
ReceiverFFT Receiver3FFT_inst (
	.clk          (clk),          
	.reset_n      (reset),      
	.sink_valid   (sink_valid3),   
	.sink_ready   (sink_ready3),   
	.sink_error   (sink_error),   
	.sink_sop     (sink_sop3),     
	.sink_eop     (sink_eop3),     
	.sink_real    (realFFT3in),    
	.sink_imag    (imagFFT3in),    
	.fftpts_in    (fftpts),    
	.inverse      (ForwardFFT),      
	.source_valid (source_valid3), 
	.source_ready (source_Ready), 
	.source_real  (realOutput3),  
	.source_imag  (imagOutput3)  
	);		

ReceiverFFT Receiver4FFT_inst (
	.clk          (clk),          
	.reset_n      (reset),      
	.sink_valid   (sink_valid4),   
	.sink_ready   (sink_ready4),   
	.sink_error   (sink_error),   
	.sink_sop     (sink_sop4),     
	.sink_eop     (sink_eop4),     
	.sink_real    (realFFT4in),    
	.sink_imag    (imagFFT4in),    
	.fftpts_in    (fftpts),    
	.inverse      (ForwardFFT),      
	.source_valid (source_valid4), 
	.source_ready (source_Ready), 
	.source_real  (realOutput4),  
	.source_imag  (imagOutput4)  
	);	
	
multiplier multiplier1_inst(
	.RealPart(realOutput1) ,	
	.ImagPart(imagOutput1) ,	
	.multi_factor(XFactor) ,	
	.Real_multi_out(Real_multi_out1) ,	
	.imag_multi_out(imag_multi_out1) 	
);

multiplier multiplier2_inst(
	.RealPart(realOutput2) ,	
	.ImagPart(imagOutput2) ,	
	.multi_factor(XFactor) ,	
	.Real_multi_out(Real_multi_out2) ,	
	.imag_multi_out(imag_multi_out2) 	
);

multiplier multiplier3_inst(
	.RealPart(realOutput3) ,	
	.ImagPart(imagOutput3) ,	
	.multi_factor(XFactor) ,	
	.Real_multi_out(Real_multi_out3) ,	
	.imag_multi_out(imag_multi_out3) 	
);

multiplier multiplier4_inst(
	.RealPart(realOutput4) ,	
	.ImagPart(imagOutput4) ,	
	.multi_factor(XFactor) ,	
	.Real_multi_out(Real_multi_out4) ,	
	.imag_multi_out(imag_multi_out4) 	
);


ReceiverFFT Receiver1iFFT_inst (
	.clk          (clk),     
	.reset_n      (reset),   
	.sink_valid   (isink_valid1),  
	.sink_ready   (isink_ready1),   
	.sink_error   (sink_error),   
	.sink_sop     (isink_sop1),     
	.sink_eop     (isink_eop1),     
	.sink_real    (Real_multi_out1),    
	.sink_imag    (imag_multi_out1),    
	.fftpts_in    (fftpts),    
	.inverse      (InverseFFT),      
	.source_valid (isource_valid1), 
	.source_ready (source_Ready), 
	.source_real  (irealOutput1), 
	.source_imag  (iimagiOutput1)  
	);	
	
ReceiverFFT Receiver2iFFT_inst (
	.clk          (clk),     
	.reset_n      (reset),   
	.sink_valid   (isink_valid2),  
	.sink_ready   (isink_ready2),   
	.sink_error   (sink_error),   
	.sink_sop     (isink_sop2),     
	.sink_eop     (isink_eop2),     
	.sink_real    (Real_multi_out2),    
	.sink_imag    (imag_multi_out2),    
	.fftpts_in    (fftpts),    
	.inverse      (InverseFFT),      
	.source_valid (isource_valid2), 
	.source_ready (source_Ready), 
	.source_real  (irealOutput2), 
	.source_imag  (iimagiOutput2)  
	);	
	
ReceiverFFT Receiver3iFFT_inst (
	.clk          (clk),     
	.reset_n      (reset),   
	.sink_valid   (isink_valid3),  
	.sink_ready   (isink_ready3),   
	.sink_error   (sink_error),   
	.sink_sop     (isink_sop3),     
	.sink_eop     (isink_eop3),     
	.sink_real    (Real_multi_out3),    
	.sink_imag    (imag_multi_out3),    
	.fftpts_in    (fftpts),    
	.inverse      (InverseFFT),      
	.source_valid (isource_valid3), 
	.source_ready (source_Ready), 
	.source_real  (irealOutput3), 
	.source_imag  (iimagiOutput3)  
	);	
	
ReceiverFFT Receiver4iFFT_inst (
	.clk          (clk),     
	.reset_n      (reset),   
	.sink_valid   (isink_valid4),  
	.sink_ready   (isink_ready4),   
	.sink_error   (sink_error),   
	.sink_sop     (isink_sop4),     
	.sink_eop     (isink_eop4),     
	.sink_real    (Real_multi_out4),    
	.sink_imag    (imag_multi_out4),    
	.fftpts_in    (fftpts),    
	.inverse      (InverseFFT),      
	.source_valid (isource_valid4), 
	.source_ready (source_Ready), 
	.source_real  (irealOutput4), 
	.source_imag  (iimagiOutput4)  
	);


RAM	RAM1_inst (
	.address ( address ),
	.clock ( clk ),
	.data ( {irealOutput1, iimagiOutput1} ),
	.wren ( wren ),
	.q ( DataOuput1 )
	);

RAM	RAM2_inst (
	.address ( address ),
	.clock ( clk ),
	.data ( {irealOutput2, iimagiOutput2} ),
	.wren ( wren ),
	.q ( DataOuput2 )
	);
	
RAM	RAM3_inst (
	.address ( address ),
	.clock ( clk ),
	.data ( {irealOutput3, iimagiOutput3} ),
	.wren ( wren ),
	.q ( DataOuput3 )
	);
	
	
RAM	RAM4_inst (
	.address ( address ),
	.clock ( clk ),
	.data ( {irealOutput4, iimagiOutput4} ),
	.wren ( wren ),
	.q ( DataOuput4 )
	);



endmodule



 
