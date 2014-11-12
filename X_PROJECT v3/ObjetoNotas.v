`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:24:11 11/05/2014 
// Design Name: 
// Module Name:    ObjetoNotas 
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
module ObjetoNotas(
	input clk, 
	input wire  [7:0]  x,
	input wire  [6:0]  y,
	input wire        reset, 
	input wire  [5:0] numeroNota,
	input wire  [9:0] posicionYNotaCancion1,
	input wire        cuente,
	input wire 			movimientoIzquierda,
	input wire 			movimientoDerecha,
	output reg  [2:0] color,
	output wire       notaActiva
    );

//Nota 1
reg [9:0] nota1XInicio = 0;
reg [9:0] nota1YInicio = 0;
reg [9:0] nota1XFin 	  = 0;
reg [9:0] nota1YFin    = 0;

//Nota 2
reg [9:0] nota2XInicio = 0;
reg [9:0] nota2YInicio = 0;
reg [9:0] nota2XFin 	  = 0;
reg [9:0] nota2YFin    = 0;

//Nota 3
reg [9:0] nota3XInicio = 0;
reg [9:0] nota3YInicio = 0;
reg [9:0] nota3XFin 	  = 0;
reg [9:0] nota3YFin    = 0;

//Nota 4
reg [9:0] nota4XInicio = 0;
reg [9:0] nota4YInicio = 0;
reg [9:0] nota4XFin 	  = 0;
reg [9:0] nota4YFin    = 0;

//Nota 5
reg [9:0] nota5XInicio = 0;
reg [9:0] nota5YInicio = 0;
reg [9:0] nota5XFin 	  = 0;
reg [9:0] nota5YFin    = 0;

//Nota 6
reg [9:0] nota6XInicio = 0;
reg [9:0] nota6YInicio = 0;
reg [9:0] nota6XFin 	  = 0;
reg [9:0] nota6YFin    = 0;

//Nota 7
reg [9:0] nota7XInicio = 0;
reg [9:0] nota7YInicio = 0;
reg [9:0] nota7XFin 	  = 0;
reg [9:0] nota7YFin    = 0;

//Nota 8
reg [9:0] nota8XInicio = 0;
reg [9:0] nota8YInicio = 0;
reg [9:0] nota8XFin 	  = 0;
reg [9:0] nota8YFin    = 0;

//Nota 9
reg [9:0] nota9XInicio = 0;
reg [9:0] nota9YInicio = 0;
reg [9:0] nota9XFin 	  = 0;
reg [9:0] nota9YFin    = 0;

//Nota 10
reg [9:0] nota10XInicio = 0;
reg [9:0] nota10YInicio = 0;
reg [9:0] nota10XFin 	= 0;
reg [9:0] nota10YFin    = 0;

//Nota 11
reg [9:0] nota11XInicio = 0;
reg [9:0] nota11YInicio = 0;
reg [9:0] nota11XFin 	= 0;
reg [9:0] nota11YFin    = 0;

//Nota 12
reg [9:0] nota12XInicio = 0;
reg [9:0] nota12YInicio = 0;
reg [9:0] nota12XFin 	= 0;
reg [9:0] nota12YFin    = 0;

//Nota 13
reg [9:0] nota13XInicio = 0;
reg [9:0] nota13YInicio = 0;
reg [9:0] nota13XFin 	= 0;
reg [9:0] nota13YFin    = 0;

//Nota 14
reg [9:0] nota14XInicio = 0;
reg [9:0] nota14YInicio = 0;
reg [9:0] nota14XFin 	= 0;
reg [9:0] nota14YFin    = 0;

//Nota 15
reg [9:0] nota15XInicio = 0;
reg [9:0] nota15YInicio = 0;
reg [9:0] nota15XFin 	= 0;
reg [9:0] nota15YFin    = 0;

//Nota 16
reg [9:0] nota16XInicio = 0;
reg [9:0] nota16YInicio = 0;
reg [9:0] nota16XFin 	= 0;
reg [9:0] nota16YFin    = 0;

//Nota 17
reg [9:0] nota17XInicio = 0;
reg [9:0] nota17YInicio = 0;
reg [9:0] nota17XFin 	= 0;
reg [9:0] nota17YFin    = 0;

//Nota 18
reg [9:0] nota18XInicio = 0;
reg [9:0] nota18YInicio = 0;
reg [9:0] nota18XFin 	= 0;
reg [9:0] nota18YFin    = 0;

//Nota 19
reg [9:0] nota19XInicio = 0;
reg [9:0] nota19YInicio = 0;
reg [9:0] nota19XFin 	= 0;
reg [9:0] nota19YFin    = 0;

//Nota 20
reg [9:0] nota20XInicio = 0;
reg [9:0] nota20YInicio = 0;
reg [9:0] nota20XFin 	= 0;
reg [9:0] nota20YFin    = 0;

//Nota 21
reg [9:0] nota21XInicio = 0;
reg [9:0] nota21YInicio = 0;
reg [9:0] nota21XFin 	= 0;
reg [9:0] nota21YFin    = 0;

//Nota 22
reg [9:0] nota22XInicio = 0;
reg [9:0] nota22YInicio = 0;
reg [9:0] nota22XFin 	= 0;
reg [9:0] nota22YFin    = 0;

//Nota 23
reg [9:0] nota23XInicio = 0;
reg [9:0] nota23YInicio = 0;
reg [9:0] nota23XFin 	= 0;
reg [9:0] nota23YFin    = 0;

//Nota 24
reg [9:0] nota24XInicio = 0;
reg [9:0] nota24YInicio = 0;
reg [9:0] nota24XFin 	= 0;
reg [9:0] nota24YFin    = 0;

//Nota 25
reg [9:0] nota25XInicio = 0;
reg [9:0] nota25YInicio = 0;
reg [9:0] nota25XFin 	= 0;
reg [9:0] nota25YFin    = 0;

//Nota 26
reg [9:0] nota26XInicio = 0;
reg [9:0] nota26YInicio = 0;
reg [9:0] nota26XFin 	= 0;
reg [9:0] nota26YFin    = 0;

//Nota 27
reg [9:0] nota27XInicio = 0;
reg [9:0] nota27YInicio = 0;
reg [9:0] nota27XFin 	= 0;
reg [9:0] nota27YFin    = 0;


assign nota1On = ((x >= nota1XInicio && x <= nota1XFin) &&(y >= nota1YInicio && y<= nota1YFin))? 1'b1:1'b0;
assign nota2On = ((x >= nota2XInicio && x <= nota2XFin) &&(y >= nota2YInicio && y<= nota2YFin))? 1'b1:1'b0;
assign nota3On = ((x >= nota3XInicio && x <= nota3XFin) &&(y >= nota3YInicio && y<= nota3YFin))? 1'b1:1'b0;
assign nota4On = ((x >= nota4XInicio && x <= nota4XFin) &&(y >= nota4YInicio && y<= nota4YFin))? 1'b1:1'b0;
assign nota5On = ((x >= nota5XInicio && x <= nota5XFin) &&(y >= nota5YInicio && y<= nota5YFin))? 1'b1:1'b0;
assign nota6On = ((x >= nota6XInicio && x <= nota6XFin) &&(y >= nota6YInicio && y<= nota6YFin))? 1'b1:1'b0;
assign nota7On = ((x >= nota7XInicio && x <= nota7XFin) &&(y >= nota7YInicio && y<= nota7YFin))? 1'b1:1'b0;
assign nota8On = ((x >= nota8XInicio && x <= nota8XFin) &&(y >= nota8YInicio && y<= nota8YFin))? 1'b1:1'b0;
assign nota9On = ((x >= nota9XInicio && x <= nota9XFin) &&(y >= nota9YInicio && y<= nota9YFin))? 1'b1:1'b0;
assign nota10On = ((x >= nota10XInicio && x <= nota10XFin) &&(y >= nota10YInicio && y<= nota10YFin))? 1'b1:1'b0;
assign nota11On = ((x >= nota11XInicio && x <= nota11XFin) &&(y >= nota11YInicio && y<= nota11YFin))? 1'b1:1'b0;
assign nota12On = ((x >= nota12XInicio && x <= nota12XFin) &&(y >= nota12YInicio && y<= nota12YFin))? 1'b1:1'b0;
assign nota13On = ((x >= nota13XInicio && x <= nota13XFin) &&(y >= nota13YInicio && y<= nota13YFin))? 1'b1:1'b0;
assign nota14On = ((x >= nota14XInicio && x <= nota14XFin) &&(y >= nota14YInicio && y<= nota14YFin))? 1'b1:1'b0;
assign nota15On = ((x >= nota15XInicio && x <= nota15XFin) &&(y >= nota15YInicio && y<= nota15YFin))? 1'b1:1'b0;
assign nota16On = ((x >= nota16XInicio && x <= nota16XFin) &&(y >= nota16YInicio && y<= nota16YFin))? 1'b1:1'b0;
assign nota17On = ((x >= nota17XInicio && x <= nota17XFin) &&(y >= nota17YInicio && y<= nota17YFin))? 1'b1:1'b0;
assign nota18On = ((x >= nota18XInicio && x <= nota18XFin) &&(y >= nota18YInicio && y<= nota18YFin))? 1'b1:1'b0;
assign nota19On = ((x >= nota19XInicio && x <= nota19XFin) &&(y >= nota19YInicio && y<= nota19YFin))? 1'b1:1'b0;
assign nota20On = ((x >= nota20XInicio && x <= nota20XFin) &&(y >= nota20YInicio && y<= nota20YFin))? 1'b1:1'b0;
assign nota21On = ((x >= nota21XInicio && x <= nota21XFin) &&(y >= nota21YInicio && y<= nota21YFin))? 1'b1:1'b0;
assign nota22On = ((x >= nota22XInicio && x <= nota22XFin) &&(y >= nota22YInicio && y<= nota22YFin))? 1'b1:1'b0;
assign nota23On = ((x >= nota23XInicio && x <= nota23XFin) &&(y >= nota23YInicio && y<= nota23YFin))? 1'b1:1'b0;

assign notaActiva = nota1On | nota2On  | nota3On  | nota4On  | nota5On  | nota6On  | nota7On  | nota8On  |
						  nota9On | nota10On | nota11On | nota12On | nota13On | nota14On | nota15On | nota16On |
						  nota17On | nota18On | nota19On | nota20On | nota21On | nota22On | nota23On; 

//SE ENCARGA DE DIBUJAR LAS NOTAS
always @(notaActiva or x or y)
      begin
			if (notaActiva) color = 3'b011;
			else color= 3'b000;
		end


always @(clk)
	begin
		if(reset)
			begin
		    	nota1XInicio <= 0;
				nota1XFin    <= 0;
				nota2XInicio <= 0;
				nota2XFin    <= 0;
				nota3XInicio <= 0;
				nota3XFin    <= 0;
				nota4XInicio <= 0;
				nota4XFin    <= 0;
				nota5XInicio <= 0;
				nota5XFin    <= 0;
				nota6XInicio <= 0;
				nota6XFin    <= 0;
				nota7XInicio <= 0;
				nota7XFin    <= 0;
				nota8XInicio <= 0;
				nota8XFin    <= 0;
				nota9XInicio <= 0;
				nota9XFin    <= 0;
				nota10XInicio <= 0;
				nota11XFin    <= 0;
				nota12XInicio <= 0;
				nota12XFin    <= 0;
				nota13XInicio <= 0;
				nota13XFin    <= 0;
				nota14XInicio <= 0;
				nota14XFin    <= 0;
				nota15XInicio <= 0;
				nota15XFin    <= 0;
				nota16XInicio <= 0;
				nota16XFin    <= 0;
				nota17XInicio <= 0;
				nota17XFin    <= 0;
				nota18XInicio <= 0;
				nota18XFin    <= 0;
				nota19XInicio <= 0;
				nota19XFin    <= 0;
				nota20XInicio <= 0;
				nota20XFin    <= 0;
				nota21XInicio <= 0;
				nota21XFin    <= 0;
				nota22XInicio <= 0;
				nota22XFin    <= 0;
				nota23XInicio <= 0;
				nota23XFin    <= 0;
				nota1YInicio <= 0;
				nota1YFin    <= 0;
				nota2YInicio <= 0;
				nota2YFin    <= 0;
				nota3YInicio <= 0;
				nota3YFin    <= 0;
				nota4YInicio <= 0;
				nota4YFin    <= 0;
				nota5YInicio <= 0;
				nota5YFin    <= 0;
				nota6YInicio <= 0;
				nota6YFin    <= 0;
				nota7YInicio <= 0;
				nota7YFin    <= 0;
				nota8YInicio <= 0;
				nota8YFin    <= 0;
				nota9YInicio <= 0;
				nota9YFin    <= 0;
				nota10YInicio <= 0;
				nota10YFin    <= 0;
				nota11YInicio <= 0;
				nota11YFin    <= 0;
				nota12YInicio <= 0;
				nota12YFin    <= 0;
				nota13YInicio <= 0;
				nota13YFin    <= 0;
				nota14YInicio <= 0;
				nota14YFin    <= 0;
				nota15YInicio <= 0;
				nota15YFin    <= 0;
				nota16YInicio <= 0;
				nota16YFin    <= 0;
				nota17YInicio <= 0;
				nota17YFin    <= 0;
				nota18YInicio <= 0;
				nota18YFin    <= 0;
				nota19YInicio <= 0;
				nota19YFin    <= 0;
				nota20YInicio <= 0;
				nota20YFin    <= 0;
				nota21YInicio <= 0;
				nota21YFin    <= 0;
				nota22YInicio <= 0;
				nota22YFin    <= 0;
				nota23YInicio <= 0;
				nota23YFin    <= 0;
			end
		else if(cuente)
			begin
				if(numeroNota==1)
					begin
						nota1XInicio <= 10;
						nota1XFin    <= 12;
						nota1YInicio <= posicionYNotaCancion1;
						nota1YFin <= nota1YInicio+2;
						
					end
				else if(numeroNota==2)
					begin
						nota2XInicio <= 20;
						nota2XFin    <= 22;
						nota2YInicio <= posicionYNotaCancion1;
						nota2YFin <= nota2YInicio+2;
					end
				else if(numeroNota==3)
					begin
						nota3XInicio <= 30;
						nota3XFin    <= 32;
						nota3YInicio <= posicionYNotaCancion1;
						nota3YFin <= nota3YInicio+2;
					end
				else if(numeroNota==4)
					begin
						nota4XInicio <= 40;
						nota4XFin    <= 42;
						nota4YInicio <= posicionYNotaCancion1;
						nota4YFin <= nota4YInicio+2;
					end
				else if(numeroNota==5)
					begin
						nota5XInicio <= 50;
						nota5XFin    <= 52;
						nota5YInicio <= posicionYNotaCancion1;
						nota5YFin <= nota5YInicio+2;
					end
				else if(numeroNota==6)
					begin
						nota6XInicio <= 60;
						nota6XFin    <= 62;
						nota6YInicio <= posicionYNotaCancion1;
						nota6YFin <= nota6YInicio+2;
					end
				else if(numeroNota==7)
					begin
						nota7XInicio <= 70;
						nota7XFin    <= 72;
						nota7YInicio <= posicionYNotaCancion1;
						nota7YFin <= nota7YInicio+2;
					end
				else if(numeroNota==8)
					begin
						nota8XInicio <= 80;
						nota8XFin    <= 82;
						nota8YInicio <= posicionYNotaCancion1;
						nota8YFin <= nota8YInicio+2;
					end
				else if(numeroNota==9)
					begin
						nota9XInicio <= 90;
						nota9XFin    <= 92;
						nota9YInicio <= posicionYNotaCancion1;
						nota9YFin <= nota9YInicio+2;
					end
				else if(numeroNota==10)
					begin
						nota10XInicio <= 100;
						nota10XFin    <= 102;
						nota10YInicio <= posicionYNotaCancion1;
						nota10YFin <= nota10YInicio+2;
					end
				else if(numeroNota==11)
					begin
						nota11XInicio <= 110;
						nota11XFin    <= 112;
						nota11YInicio <= posicionYNotaCancion1;
						nota11YFin <= nota11YInicio+2;
					end
				else if(numeroNota==12)
					begin
						nota12XInicio <= 120;
						nota12XFin    <= 122;
						nota12YInicio <= posicionYNotaCancion1;
						nota12YFin <= nota12YInicio+2;
					end
				else if(numeroNota==13)
					begin
						nota13XInicio <= 130;
						nota13XFin    <= 132;
						nota13YInicio <= posicionYNotaCancion1;
						nota13YFin <= nota13YInicio+2;
					end
				else if(numeroNota==14)
					begin
						nota14XInicio <= 140;
						nota14XFin    <= 142;
						nota14YInicio <= posicionYNotaCancion1;
						nota14YFin <= nota14YInicio+2;
					end
				else if(numeroNota==15)
					begin
						nota15XInicio <= 150;
						nota15XFin    <= 152;
						nota15YInicio <= posicionYNotaCancion1;
						nota15YFin <= nota15YInicio+2;
					end
				else if(numeroNota==16)
					begin
						nota16XInicio <= 150;
						nota16XFin    <= 152;
						nota16YInicio <= posicionYNotaCancion1;
						nota16YFin <= nota16YInicio+2;
					end
				else if(numeroNota==17)
					begin
						nota17XInicio <= 150;
						nota17XFin    <= 152;
						nota17YInicio <= posicionYNotaCancion1;
						nota17YFin <= nota17YInicio+2;
					end
				else if(numeroNota==18)
					begin
						nota18XInicio <= 150;
						nota18XFin    <= 152;
						nota18YInicio <= posicionYNotaCancion1;
						nota18YFin <= nota18YInicio+2;
					end
				else if(numeroNota==19)
					begin
						nota19XInicio <= 150;
						nota19XFin    <= 152;
						nota19YInicio <= posicionYNotaCancion1;
						nota19YFin <= nota19YInicio+2;
					end
				else if(numeroNota==20)
					begin
						nota20XInicio <= 150;
						nota20XFin    <= 152;
						nota20YInicio <= posicionYNotaCancion1;
						nota20YFin <= nota20YInicio+2;
					end
				else if(numeroNota==21)
					begin
						nota21XInicio <= 150;
						nota21XFin    <= 152;
						nota21YInicio <= posicionYNotaCancion1;
						nota21YFin <= nota21YInicio+2;
					end
				else if(numeroNota==22)
					begin
						nota22XInicio <= 150;
						nota22XFin    <= 152;
						nota22YInicio <= posicionYNotaCancion1;
						nota22YFin <= nota22YInicio+2;
					end
				else if(numeroNota==23)
					begin
						nota23XInicio <= 150;
						nota23XFin    <= 152;
						nota23YInicio <= posicionYNotaCancion1;
						nota23YFin <= nota23YInicio+2;
					end				
			end
		else if(movimientoIzquierda)
			begin
				nota1XInicio <= nota1XInicio-10;
				nota1XFin    <= nota1XFin-10;
				nota2XInicio <= nota2XInicio-10;
				nota2XFin    <= nota2XFin-10;
				nota3XInicio <= nota3XInicio-10;
				nota3XFin    <= nota3XFin-10;
				nota4XInicio <= nota4XInicio-10;
				nota4XFin    <= nota4XFin-10;
				nota5XInicio <= nota5XInicio-10;
				nota5XFin    <= nota5XFin-10;
				nota6XInicio <= nota6XInicio-10;
				nota6XFin    <= nota6XFin-10;
				nota7XInicio <= nota7XInicio-10;
				nota7XFin    <= nota7XFin-10;
				nota8XInicio <= nota8XInicio-10;
				nota8XFin    <= nota8XFin-10;
				nota9XInicio <= nota9XInicio-10;
				nota9XFin    <= nota9XFin-10;
				nota10XInicio <= nota10XInicio-10;
				nota10XFin    <= nota10XFin-10;
				nota11XInicio <= nota11XInicio-10;
				nota11XFin    <= nota11XFin-10;
				nota12XInicio <= nota12XInicio-10;
				nota12XFin    <= nota12XFin-10;
				nota13XInicio <= nota13XInicio-10;
				nota13XFin    <= nota13XFin-10;
				nota14XInicio <= nota14XInicio-10;
				nota14XFin    <= nota14XFin-10;
				nota15XInicio <= nota15XInicio-10;
				nota15XFin    <= nota15XFin-10;
				nota16XInicio <= nota16XInicio-10;
				nota16XFin    <= nota16XFin-10;
				nota17XInicio <= nota17XInicio-10;
				nota17XFin    <= nota17XFin-10;
				nota18XInicio <= nota18XInicio-10;
				nota18XFin    <= nota18XFin-10;
				nota19XInicio <= nota19XInicio-10;
				nota19XFin    <= nota19XFin-10;
				nota20XInicio <= nota20XInicio-10;
				nota20XFin    <= nota20XFin-10;
				nota21XInicio <= nota21XInicio-10;
				nota21XFin    <= nota21XFin-10;
				nota22XInicio <= nota22XInicio-10;
				nota22XFin    <= nota22XFin-10;
				nota23XInicio <= nota23XInicio-10;
				nota23XFin    <= nota23XFin-10;
			end
		else if(movimientoDerecha)
			begin
				nota1XInicio <= nota1XInicio+10;
				nota1XFin    <= nota1XFin+10;
				nota2XInicio <= nota2XInicio+10;
				nota2XFin    <= nota2XFin+10;
				nota3XInicio <= nota3XInicio+10;
				nota3XFin    <= nota3XFin+10;
				nota4XInicio <= nota4XInicio+10;
				nota4XFin    <= nota4XFin+10;
				nota5XInicio <= nota5XInicio+10;
				nota5XFin    <= nota5XFin+10;
				nota6XInicio <= nota6XInicio+10;
				nota6XFin    <= nota6XFin+10;
				nota7XInicio <= nota7XInicio+10;
				nota7XFin    <= nota7XFin+10;
				nota8XInicio <= nota8XInicio+10;
				nota8XFin    <= nota8XFin+10;
				nota9XInicio <= nota9XInicio+10;
				nota9XFin    <= nota9XFin+10;
				nota10XInicio <= nota10XInicio+10;
				nota10XFin    <= nota10XFin+10;
				nota11XInicio <= nota11XInicio+10;
				nota11XFin    <= nota11XFin+10;
				nota12XInicio <= nota12XInicio+10;
				nota12XFin    <= nota12XFin+10;
				nota13XInicio <= nota13XInicio+10;
				nota13XFin    <= nota13XFin+10;
				nota14XInicio <= nota14XInicio+10;
				nota14XFin    <= nota14XFin+10;
				nota15XInicio <= nota15XInicio+10;
				nota15XFin    <= nota15XFin+10;
				nota16XInicio <= nota16XInicio+10;
				nota16XFin    <= nota16XFin+10;
				nota17XInicio <= nota17XInicio+10;
				nota17XFin    <= nota17XFin+10;
				nota18XInicio <= nota18XInicio+10;
				nota18XFin    <= nota18XFin+10;
				nota19XInicio <= nota19XInicio+10;
				nota19XFin    <= nota19XFin+10;
				nota20XInicio <= nota20XInicio+10;
				nota20XFin    <= nota20XFin+10;
				nota21XInicio <= nota21XInicio+10;
				nota21XFin    <= nota21XFin+10;
				nota22XInicio <= nota22XInicio+10;
				nota22XFin    <= nota22XFin+10;
				nota23XInicio <= nota23XInicio+10;
				nota23XFin    <= nota23XFin+10;
			end
		else if (reset)
			begin
				nota1XInicio <= 10;
				nota1XFin    <= 12;
				nota2XInicio <= 20;
				nota2XFin    <= 22;
				nota3XInicio <= 30;
				nota3XFin    <= 32;
				nota4XInicio <= 40;
				nota4XFin    <= 42;
				nota5XInicio <= 50;
				nota5XFin    <= 52;
				nota6XInicio <= 60;
				nota6XFin    <= 62;
				nota7XInicio <= 70;
				nota7XFin    <= 72;
				nota8XInicio <= 80;
				nota8XFin    <= 82;
				nota9XInicio <= 90;
				nota9XFin    <= 92;
				nota10XInicio <= 100;
				nota10XFin    <= 102;
				nota11XInicio <= 110;
				nota11XFin    <= 112;
				nota12XInicio <= 120;
				nota12XFin    <= 122;
				nota13XInicio <= 130;
				nota13XFin    <= 132;
				nota14XInicio <= 140;
				nota14XFin    <= 142;
				nota15XInicio <= 150;
				nota15XFin    <= 152;
				nota16XInicio <= 160;
				nota16XFin    <= 162;
				nota17XInicio <= 170;
				nota17XFin    <= 172;
				nota18XInicio <= 180;
				nota18XFin    <= 182;
				nota19XInicio <= 190;
				nota19XFin    <= 192;
				nota20XInicio <= 200;
				nota20XFin    <= 202;
				nota21XInicio <= 210;
				nota21XFin    <= 212;
				nota22XInicio <= 220;
				nota22XFin    <= 222;
				nota23XInicio <= 230;
				nota23XFin    <= 232;
			end
	end

always @(clk)
	begin
		
	end
	
	
endmodule
