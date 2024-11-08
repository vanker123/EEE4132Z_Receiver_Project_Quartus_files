module multiplier (
    input signed [7:0] RealPart,    // Real part of FFT output
    input signed [7:0] ImagPart,    // Imaginary part of FFT output
    input signed [7:0] multi_factor,  // Real part of the multiplier constant
    output reg signed [7:0] Real_multi_out, // Real part of the multiplication result
    output reg signed [7:0] imag_multi_out  // Imaginary part of the multiplication result
);

    always @(*) begin
        // Calculate the real part of the result
        Real_multi_out = (RealPart * multi_factor);
        
        // Calculate the imaginary part of the result
        imag_multi_out = (ImagPart * multi_factor);
    end

endmodule
