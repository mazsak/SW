module processor_with_ROM(
		input [9:0] SW,
		input [1:0] KEY,
		output [9:0] LEDR);
		
	proc ex0(KEY[0], KEY[1], SW[0], SW[9], LEDR[9], LEDR[8:0]);
		
endmodule

module proc (MClock, PClock, Resetn, Run, Done, BusWires);
	input MClock, PClock, Resetn, Run;
	output Done;
	output [8:0] BusWires;
		
	parameter T0 = 2'b00, T1 = 2'b01, T2 = 2'b10, T3 = 2'b11;
	
	// deklaracja zmiennych
	wire [8:0] DIN;
	
	reg [8:0] BusWires;
   reg [0:7] Rin, Rout;
	reg [8:0] Sum;
	reg IRin, Done, DINout, Ain, Gin, Gout, AddSub;
	reg [2:0] Tstep_Q /* synthesis preserve */ , Tstep_D /* synthesis preserve */ ;
	
	wire [2:0] I;
	wire [0:7] Xreg, Yreg;
	wire [8:0] R0, R1, R2, R3, R4, R5, R6, R7;
	wire [8:0] A, G;
	wire [1:9] IR;
	wire [0:9] Sel; 
	
	// kolejna komorka pamieci
   reg [4:0] address;
   always@(negedge MClock)
		address = address + 1;
		
	//Przypisanie do DIN wartości z miejsca pamięci
   //address, clock, q
   inst_mem(address, MClock, DIN);
	
	assign I = IR[1:3];
	dec3to8 decX (IR[4:6], 1'b1, Xreg);
	dec3to8 decY (IR[7:9], 1'b1, Yreg);
	
	// zarządzaj tabelą stanów FSM
	always@(Tstep_Q, Run, Done)
	begin
		case(Tstep_Q)
			T0: // w tej chwili dane są ładowane do IR
				if (~Run) Tstep_D = T0;
				else Tstep_D = T1;
	 		T1:
				if (Done) Tstep_D = T0;
				else Tstep_D = T2;
			T2: 
 				Tstep_D = T3;
			T3: 
				Tstep_D = T0;
		endcase
	end
	
	// deklaracja operacji
	parameter mv = 3'b000, mvi = 3'b001, add = 3'b010, sub = 3'b011;
	
	// sterowanie wejściami FSM
	always @(Tstep_Q or I or Xreg or Yreg)
	begin
		// określenie wartości początkowych
		Rin = 8'b0; Rout = 8'b0; Done = 1'b0; IRin = 1'b0;
		DINout = 1'b0;
		Ain = 1'b0; Gin = 1'b0; Gout = 1'b0; AddSub = 1'b0;
		case (Tstep_Q)
			T0:
				 begin
					  IRin = 1'b1;
				 end
			T1:  
				 case (I)
					  mv:
					  begin
							Rin = Xreg;
							Done = 1'b1;
							Rout = Yreg;
					  end
					  mvi:
					  begin
							Done = 1'b1;                   
							DINout = 1'b1;
							Rin = Xreg;
					  end
					  add, sub:
					  begin
							Ain = 1'b1;
							Rout = Xreg;
					  end
				 endcase
			T2:  
				 case (I)
					  add:
					  begin
							Rout = Yreg;
							Gin = 1'b1;
					  end
					  sub:
					  begin
							AddSub = 1'b1;
							Rout = Yreg;
							Gin = 1'b1;
					  end
				 endcase
			T3:  
				 case (I)
					  add, sub:
					  begin
							Rin = Xreg;
							Gout = 1'b1;
							Done = 1'b1;
					  end
				 endcase
		endcase
	end 

	// zmiana stanow
	always @(posedge PClock, negedge Resetn)
		if (!Resetn)
			Tstep_Q <= T0;
		else
			Tstep_Q <= Tstep_D;
			
	// inicjalizacja rejestrow
	regn reg_0 (BusWires, Rin[0], PClock, R0);
	regn reg_1 (BusWires, Rin[1], PClock, R1);
	regn reg_2 (BusWires, Rin[2], PClock, R2);
	regn reg_3 (BusWires, Rin[3], PClock, R3);
	regn reg_4 (BusWires, Rin[4], PClock, R4);
	regn reg_5 (BusWires, Rin[5], PClock, R5);
	regn reg_6 (BusWires, Rin[6], PClock, R6);
	regn reg_7 (BusWires, Rin[7], PClock, R7);
	regn reg_A (BusWires, Ain, PClock, A);
	regn #(.n(9)) reg_IR (DIN, IRin, PClock, IR);

	//	modul ALU
	always @(AddSub or A or BusWires)
		begin
		if (!AddSub)
			Sum = A + BusWires;
	   else
			Sum = A - BusWires;
	end
	
	// deklaracja rejestru G przechowującego wynik z ALU
   regn reg_G (Sum, Gin, PClock, G);
	
	// multiplekser
	assign Sel = {Rout, Gout, DINout};
	always @(*)
	begin
		if (Sel == 10'b1000000000)
			BusWires = R0;
		else if (Sel == 10'b0100000000)
            BusWires = R1;
      else if (Sel == 10'b0010000000)
            BusWires = R2;
      else if (Sel == 10'b0001000000)
            BusWires = R3;
      else if (Sel == 10'b0000100000)
            BusWires = R4;
      else if (Sel == 10'b0000010000)
            BusWires = R5;
      else if (Sel == 10'b0000001000)
            BusWires = R6;
      else if (Sel == 10'b0000000100)
            BusWires = R7;
      else if (Sel == 10'b0000000010)
            BusWires = G;
   	else BusWires = DIN;
	end
	
endmodule

module dec3to8(W, En, Y);
	input [2:0] W;
	input En;
	output [0:7] Y;
	reg [0:7] Y;
	
	always @(W or En)
		begin
			if (En == 1)
				begin
					case (W)
						3'b000: Y = 8'b10000000;
						3'b001: Y = 8'b01000000;
						3'b010: Y = 8'b00100000;
						3'b011: Y = 8'b00010000;
						3'b100: Y = 8'b00001000;
						3'b101: Y = 8'b00000100;
						3'b110: Y = 8'b00000010;
						3'b111: Y = 8'b00000001;
					endcase
				end
			else
				Y = 8'b00000000;
		end
		
endmodule

module regn(R, Rin, Clock, Q);
	parameter n = 9;
	input[n-1:0] R;
	input Rin, Clock;
	output [n-1:0] Q;
	reg [n-1:0] Q;
	
	always @(posedge Clock)
		if (Rin)
			Q <= R;
			
endmodule
		