module FFTcontrol(
clk,
FFTin,
sink_valid,
sink_sop,
sink_eop,
realFFTin,
imagFFTin
);

input clk;
input [3:0] FFTin;

output reg sink_valid;
output reg sink_sop;
output reg sink_eop;

output[3:0] realFFTin; //output from control module, into fft module
output[3:0] imagFFTin;

reg[18:0] count;

initial
begin
count =19'd1;
sink_valid=0;
end 

assign realFFTin = FFTin;
assign imagFFTin = 4'd0;

always @(posedge clk)
begin 
begin
count <= count+1'b1;
end 
if (count ==19'd262144)
begin 
sink_eop<=1;
end 
if (count==19'd0)
begin
sink_eop<=0;
sink_sop<=1;
sink_valid<=1;
end 
if (count ==19'd1)
begin
sink_sop<=0;
end
end

endmodule



