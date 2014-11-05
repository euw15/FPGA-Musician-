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
	choose,
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
input wire choose;
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
wire [5:0] writeDirection_track1;
wire [5:0] writeDirection_track2;
wire [5:0] readDirection;
wire [5:0] limitDirection;
wire [5:0] limitDirection_track1;
wire [5:0] limitDirection_track2;
wire [6:0] limit_mix;
wire WE_1;
wire WE_2;
wire finish;
wire [7:0] DataDisplay;
wire CS1;
wire CS2; 
wire track1_ON;
wire track2_ON;
wire mixtrack_ON;
wire clean;
wire [7:0] DataOut_track1;
wire [7:0] DataOut_track2;
//DEBOUNCING ENTRIES
wire startDB;
wire executeDB;
wire recordDB;
wire chooseDB;

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

	DEBOUNCE db4 (
    .btn(choose), 
    .clock(clock), 
    .reset(reset), 
    .btnSalida(chooseDB)
    );

//FSM CONTROL
FSM_CONTROL fsm_control (
    .clock(clock), 
    .reset(reset), 
    .execute(executeDB), 
    .start(startDB), 
    .record(recordDB), 
    .finish(finish),
	 .erase(chooseDB),
    .swTones(sw_tones), 
    .write(write), 
    .read(read), 
    .listen(listen),
	 .track1(track1_ON),
	 .track2(track2_ON),
	 .mixtrack(mixtrack_ON),
	 .clean(clean)
    );
/* Si se activa alguna memoria, se debe setear el valor de la escritura, para que 
	empiece a escribir desde la posicion 0 */
wire clearWriteDir;
wire resetWrite;
assign resetWrite = (CS_activated)? 1'b1: reset;
wire [5:0] writeDirTemporal_track1;
wire [5:0] writeDirTemporal_track2;

//WRITE NOTES TRACK 1
WRITE_NOTE write_noteTrack1 (
    .clock(clock), 
    .write(write), 
	 .mem_enable(CS1),
    .writeDirection(writeDirection_track1), 
	 .writeDirectionTemporal(writeDirTemporal_track1),
	 .clearWriteDirection(clean),
    .reset(resetWrite), 
    .WE(WE_1)
    );
//WRITE NOTES TRACK 2
WRITE_NOTE write_noteTrack2 (
    .clock(clock), 
    .write(write), 
	 .mem_enable(CS2),
    .writeDirection(writeDirection_track2), 
	 .writeDirectionTemporal(writeDirTemporal_track2),
	 .clearWriteDirection(clean),
    .reset(resetWrite), 
    .WE(WE_2)
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
wire mix_audio;
assign mix_audio= CS_track1 & CS_track2;
assign limit_mix = limitDirection_track1 + limitDirection_track2;
READ_NOTE read_note (
    .clock(clockRead), 
    .reset(reset), 
    .read(read), 
	 .limit(limitDirection),
    .listen(listen), 
    .finish(finish), 
    .readDirection(readDirection),
	 .mix_audio(mix_audio),
	 .limit_mix(limit_mix)
    );
reg CS_track1;
reg CS_track2;
reg CS_activated;	 

assign CS1 = CS_track1;
assign CS2 = CS_track2;

always@(posedge clock)
	begin
		if(track2_ON)//Controla la pieza 2
			begin
				CS_track1 <= 1'b0;
				CS_track2 <= 1'b1;
				CS_activated <= 1'b1;
			
			end
		else if(track1_ON)// Controla la pieza 1
			begin
				CS_track1 <= 1'b1;
				CS_track2 <= 1'b0;
				CS_activated <= 1'b1;
		

			end
		else if(mixtrack_ON)// Controla la mezcla de las dos piezas
			begin
				CS_track1 <= 1'b1;
				CS_track2 <= 1'b1;
				CS_activated <= 1'b1;
		

			end
		else
			CS_activated <= 1'b0;

		
	end
 

assign DataDisplay = (CS_track1 & CS_track2) ? (DataOut_track1 + DataOut_track2) : (CS_track1)? DataOut_track1 : DataOut_track2;

//RAM MEMORY TO STORE NOTES 1-2-4-8-16-32-64-128
memory_track2 track1(
    .clock(clock), 
    .WAddress(writeDirection_track1), 
    .RAddress(readDirection), 
    .WE(WE_1), 
    .DataIn(sw_tones), 
    .DataOut(DataOut_track1),
	 .CS(CS1)
    );
	 
memory_track2 track2(
    .clock(clock), 
    .WAddress(writeDirection_track2), 
    .RAddress(readDirection), 
    .WE(WE_2), 
    .DataIn(sw_tones), 
    .DataOut(DataOut_track2),
	 .CS(CS2)
    );






/* Guardar el limite de lectura de la memoria de la pieza 1 o pieza 2 */
assign limitDirection = (CS1)? limitDirection_track1: limitDirection_track2;


//Establece los limites de cada cancion

LIMITE_CANCION cancion_uno (
	 .clock(clock),
    .CS(CS1), 
    .clean_limite(clean), 
    .dir_temporal(writeDirTemporal_track1), 
    .limitDirection(limitDirection_track1)
    );
LIMITE_CANCION cancion_dos (
	 .clock(clock),
    .CS(CS2), 
    .clean_limite(clean), 
    .dir_temporal(writeDirTemporal_track2), 
    .limitDirection(limitDirection_track2)
    );


//AUDIO
AUDIO audio (
    .clk(clock), 
    .JA(JA), 
    .reset(reset), 
    .tonos_cancion1(DataOut_track1),
	 .tonos_cancion2(DataOut_track2),
	 .read(read),
	 .CS1(CS1),
	 .CS2(CS2)
);

//VIDEO
VIDEO video (
    .entry({3'b000,DataDisplay}), 
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
