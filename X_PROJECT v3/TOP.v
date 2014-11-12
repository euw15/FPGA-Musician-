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
	LEDS_OUT,
	RA,
	GA,
	BA,
	VGA_HS,
	VGA_VS
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
output wire [2:0] RA;
output wire [2:0] GA;
output wire [1:0] BA;
output wire VGA_HS;
output wire VGA_VS;

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
wire [6:0] direccionCancion1;
wire clockCambioPosY;
wire [9:0] posicionYNotaCancion1;
wire [9:0] posicionYNotaCancion2;
wire [7:0] xS;
wire [6:0] yS;
wire objetoNotasOn1;
wire [2:0] colorObjetoNotas1;
wire movimientoDerecha;
wire movimientoIzquierda;

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

//7 Segmentos
VIDEO video (
    .entry({9'b0,movimientoIzquierda}), 
	 //.entry({1'b0,posicionYNotaCancion2}),
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

//*****************Memorias de datos para video*********************/

//Notas de cada cancion
wire [7:0] notaCancion1;
wire [7:0] notaCancion2;

// PARA MOSTRAR NOTAS DE LA PRIMERA CANCION 

FSMMovimientoNotas FSMMovimientoNotas (
    .clock(clock), 
    .reset(reset), 
    .notaActual(limitDirection_track1), 
    .movimientoIzquierda(movimientoIzquierda), 
    .movimientoDerecha(movimientoDerecha)
    );


/*Memoria para cancion 1 mostrar en video*/
memory_track2 trackVideo1(
    .clock(clock), 
    .WAddress(writeDirection_track1), 
    .RAddress(limitDirection_track1), 
    .WE(WE_1), 
    .DataIn(sw_tones), 
    .DataOut(notaCancion1),
	 .CS(CS1)
    );

/*Crea la posicion para mostrar en pantalla dependiendo de la nota*/
DecodificadorNotasVideo decodificadorNotasVideo (
    .clock(clock), 
    .reset(reset), 
    .notaCancion1(notaCancion1),
	 .leyendo(1),
    .posicionYNotaCancion1(posicionYNotaCancion1)
    );

//OBJETO NOTAS CANCION 1


ObjetoNotas objetoNotas (
    .clk(clock), 
    .x(xS), 
    .y(yS), 
   // .reset(reset), 
    .color(colorObjetoNotas1), 
	 .numeroNota(limitDirection_track1),
	 .cuente(1),
	 .movimientoDerecha(movimientoDerecha),
	 .movimientoIzquierda(movimientoIzquierda),
	 .posicionYNotaCancion1(posicionYNotaCancion1),
    .notaActiva(objetoNotasOn1)
    );

// PARA MOSTRAR NOTAS DE LA SEGUNDA CANCION 

/*Memoria para cancion 1 mostrar en video*/
memory_track2 trackVideo2(
    .clock(clock), 
    .WAddress(writeDirection_track2), 
    .RAddress(limitDirection_track2), 
    .WE(WE_2), 
    .DataIn(sw_tones), 
    .DataOut(notaCancion2),
	 .CS(CS2)
    );

/*Crea la posicion para mostrar en pantalla dependiendo de la nota*/
DecodificadorNotasVideo decodificadorNotasVideoCancion2 (
    .clock(clock), 
    .reset(reset), 
    .notaCancion1(notaCancion2),
	 .leyendo(1),
    .posicionYNotaCancion1(posicionYNotaCancion2)
    );

//OBJETO NOTAS CANCION 2
wire objetoNotasOn2;
wire [2:0] colorObjetoNotas2;
ObjetoNotas objetoNotasCancion2 (
    .clk(clock), 
    .x(xS), 
    .y(yS), 
    //.reset(reset), 
    .color(colorObjetoNotas2), 
	 .numeroNota(limitDirection_track2),
	 .cuente(1),
	 .posicionYNotaCancion1(posicionYNotaCancion2),
    .notaActiva(objetoNotasOn2)
    );


//CLOCK DE 50 MHZ
DivisorReloj50MHz clock50MHZZ (
    .reloj(clock), 
    .clock_50mhz(clock50Mhz), 
    .reset(reset)
 );

	 
//Clock de 1s
DivisorReloj1s divisorReloj1s (
    .clock(clock50Mhz), 
    .reset(reset), 
    .clock_1S(clock_1S)
);

//Clock para la maquina de estados de la vga 
wire clockMaquina;
Clock_Divisor_VGA clockMaquinas(
    .clock(clock50Mhz), 
    .reset (reset), 
    .clock_1S(clockMaquina)
);

//MODULO BARRIDO EN X,Y para el video

ScanXY scan (
    .clk(clock50Mhz), 
    .reset(reset), 
    .x(xS), 
    .y(yS)
);

//CONTROL ESCRITURA Y LECTURA EN RAM
wire writeEn;
FSMVGA FSMVGA (
    .clock(clockMaquina), 
    .reset(reset), 
	 .writeEnable(writeEn)
);

//CONTROL VGA Y MEMORIA RAM
wire [2:0] color;
wire VGA_R;
wire VGA_G;
wire VGA_B;
VgaAdapter vga (
    .reset(reset), 
    .CLOCK_50(clock50Mhz), 
    .color(color), 
    .x(xS), 
    .y(yS), 
    .writeEn(writeEn), 
    .VGA_R(VGA_R), 
    .VGA_G(VGA_G), 
    .VGA_B(VGA_B), 
    .VGA_HS(VGA_HS), 
    .VGA_VS(VGA_VS), 
    .VGA_SYNC()
);

//COLORES DE SALIDA
assign RA = {{2{VGA_R}},VGA_R}; 
assign GA = {{2{VGA_G}},VGA_G};
assign BA = {{1{VGA_B}},VGA_B};

//OBJETO PENTAGRAMA
wire PentagramaOn;
wire [2:0] colorPentagrama;
Pentagrama pentagrama (
    .clk(clock50Mhz), 
    .x(xS), 
    .y(yS), 
    .reset(reset), 
    .color(colorPentagrama), 
    .lineaActiva(PentagramaOn)
    );

wire [2:0] colorBorde;
wire bordeActivo;

//MODULO DE SELECCION OBJETO A DIBUJAR
MuxObjetos muxObjetos (
    .pentagramaOn(PentagramaOn), 
    .colorPentagrama(colorPentagrama),
	 .objetoNotasOn(objetoNotasOn1),
	 .colorNotas(colorObjetoNotas1),
	 .objetoNotasOn2(objetoNotasOn2),
	 .colorNotas2(colorObjetoNotas2),
	 .colorBorde(colorBorde),
	 .bordeActivo(bordeActivo),
    .color(color)
);



ObjetoBorde ObjetoBorde (
    .clk(clock), 
    .x(xS), 
    .y(yS), 
    .reset(reset), 
    .colorBorde(colorBorde), 
    .bordeActivo(bordeActivo)
    );
	
endmodule
 