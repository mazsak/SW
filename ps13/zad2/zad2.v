module zad2 (CLOCK_50, CLOCK2_50, KEY, SW, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);

	input CLOCK_50, CLOCK2_50;
	input [0:0] KEY;
	input [0:0] SW;
	
	// I2C Audio/Video config interface
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;
	
	// Local wires.
	wire read_ready, write_ready, read, write;
	wire [23:0] readdata_left, readdata_right;
	wire [23:0] writedata_left, writedata_right;
	wire reset = ~KEY[0];
	
	wire noise_on = SW[0];
	wire signed [23:0] noise, data_left_out, data_right_out;
	reg signed [23:0] data_left, data_right;
	wire read_ena, write_ena, noise_ena;
	

	/////////////////////////////////
	// Your code goes here 
	/////////////////////////////////
	
	control_unit cu(CLOCK_50, reset, read_ready, write_ready, noise_on, read_ena,
						write_ena, noise_ena);
						
	noise_generator ng1 (CLOCK_50, noise_ena, noise);
	
	always@(*)
	begin
		data_left = (noise_on) ? (readdata_left ^ noise) : readdata_left;
		data_right = (noise_on) ? (readdata_right ^ noise) : readdata_right;
	end
	
	assign read = read_ena;
	assign write = write_ena;
	
	assign writedata_left = data_left;
	assign writedata_right = data_right;
	
	
/////////////////////////////////////////////////////////////////////////////////
// Audio CODEC interface. 
//
// The interface consists of the following wires:
// read_ready, write_ready - CODEC ready for read/write operation 
// readdata_left, readdata_right - left and right channel data from the CODEC
// read - send data from the CODEC (both channels)
// writedata_left, writedata_right - left and right channel data to the CODEC
// write - send data to the CODEC (both channels)
// AUD_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio CODEC
// I2C_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio/Video Config module
/////////////////////////////////////////////////////////////////////////////////
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);

endmodule

module noise_generator (clk, enable, Q);
	input clk, enable;
	output [23:0] Q;
	reg [2:0] counter;
	
	always@(posedge clk)
		if (enable)
			counter = counter + 1'b1;
			
	assign Q = {{8{counter[2]}}, counter, 13'd0};
endmodule

module control_unit(clk, reset, read_ready, write_ready, noise_on,
						read_ena, write_ena, noise_ena);
						
	input clk, reset, read_ready, write_ready, noise_on;
	output reg read_ena, write_ena, noise_ena;
	
	parameter [2:0] START=3'd0, READDATA=3'd1, WAITFORWRITE=3'd2, WRITEDATA=3'd3, NOISEADD=3'd4;
	reg[2:0] state;
	
	always@(posedge clk)
	begin
		if(reset) state<=START;
		else
			case(state)
				START: if(read_ready) state<=READDATA;
						else state<=START;
				READDATA: if (noise_on) state<=NOISEADD;
						else state<=WAITFORWRITE;
				WAITFORWRITE: if(write_ready) state<=WRITEDATA;
						else state<=WAITFORWRITE;
				WRITEDATA: state<=START;
				
				NOISEADD: state<=WAITFORWRITE;
				
				default: state<=START;
			endcase
	end
		
	always@(*)
	begin
		case(state)
			START: 
				begin
					write_ena=1'b0;
					read_ena=1'b0;
					noise_ena=1'b0;
				end
			READDATA: 
				begin
					write_ena=1'b0;
					read_ena=1'b1;
					noise_ena=1'b0;
				end
			WAITFORWRITE: 
				begin
					write_ena=1'b0;
					read_ena=1'b0;
					noise_ena=1'b0;
				end
			WRITEDATA: 
				begin
					write_ena=1'b1;
					read_ena=1'b0;
					noise_ena=1'b0;
				end
			NOISEADD: 
				begin
					write_ena=1'b0;
					read_ena=1'b0;
					noise_ena=1'b1;
				end
			default: 
				begin
					write_ena=1'b0;
					read_ena=1'b0;
					noise_ena=1'b0;
				end
		endcase
	end
	
endmodule


