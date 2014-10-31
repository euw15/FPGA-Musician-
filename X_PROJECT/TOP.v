`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:35:58 10/30/2014 
// Design Name: 
// Module Name:    TOP 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TOP(
	clock,
	reset,
	sw_tones,
	start,
	execute,
	record,
	a,
	b,
	c,
	d,
	e,
	f,
	g,
	an,
	JA,
	LEDS_OUT
);
//INPUT
input wire clock;
input wire reset;
input wire start;
input wire execute;
input wire record;
input wire [7:0] sw_tones;
output wire [7:0] LEDS_OUT;

//OUTPUT PORTS
output wire a;
output wire b;
output wire c;
output wire d;
output wire e;
output wire f;
output wire g;
output wire [3:0] an;
output wire [3:0] JA;

//VARIABLES
//reg clock;
wire read;
wire write;
wire listen;
wire [5:0] writeDirection;
wire [5:0] readDirection;
wire [5:0] limitDirection;

assign limitDirection = writeDirection;


wire WE;
wire finish;
wire [7:0] DataOut;



//DEBOUNCING ENTRIES
wire startDB;
wire executeDB;
wire recordDB;


	DEBOUNCE db1 (
    .btn(start), 
    .clock(clock), 
    .reset(reset), 
    .btnSalida(startDB)
    );
	 
	DEBOUNCE db2 (
    .btn(execute), 
    .clock(clock), 
    .reset(reset), 
    .btnSalida(executeDB)
    );

	DEBOUNCE db3 (
    .btn(record), 
    .clock(clock), 
    .reset(reset), 
    .btnSalida(recordDB)
    );	 

//FSM CONTROL
FSM_CONTROL fsm_control (
    .clock(clock), 
    .reset(reset), 
    .execute(executeDB), 
    .start(startDB), 
    .record(recordDB), 
    .finish(finish), 
    .swTones(sw_tones), 
    .write(write), 
    .read(read), 
    .listen(listen)
    );

//WRITE NOTES
WRITE_NOTE write_note (
    .clock(clock), 
    .write(write), 
    .writeDirection(writeDirection), 
    .reset(reset), 
    .WE(WE)
    );


//READABLE CLOCK
wire clockRead;
//reg clockReadtoModule;

CLOCK_DIVISOR clock_read (
    .clock(clock), 
    .reset(reset), 
    .clock_Salida(clockRead)
    );
						

//READ NOTES
READ_NOTE read_note (
    .clock(clockRead), 
    .reset(reset), 
    .read(read), 
	 .limit(limitDirection),
    .listen(listen), 
    .finish(finish), 
    .readDirection(readDirection)
    );
	 

//RAM MEMORY TO STORE NOTES 1-2-4-8-16-32-64-128
RAM rami (
    .clock(clock), 
    .WAddress(writeDirection), 
    .RAddress(readDirection), 
    .WE(WE), 
    .DataIn(sw_tones), 
    .DataOut(DataOut)
    );

//AUDIO
AUDIO audio (
    .clk(clock), 
    .JA(JA), 
    .reset(reset), 
    .sw_tones(DataOut)
);

//VIDEO
VIDEO video (
    .entry({3'b000,DataOut}), 
    .clock(clock), 
    .reset(reset), 
    .a(a), 
    .b(b), 
    .c(c), 
    .d(d), 
    .e(e), 
    .f(f), 
    .g(g), 
    .an(an)
);
assign LEDS_OUT = sw_tones;

endmodule
