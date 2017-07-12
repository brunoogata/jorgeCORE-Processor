module Verilog1(clock,RESULTADO);
	// SETAR controle_MUX1 controle_BR controle_MUX2 controle_ALU controle_MEMD controle_MUX4
	
	wire [31:0] MUX4_PC;
	input clock;
	wire [31:0] END_ATUAL;
	wire [31:0] INSTRUCAO;
	wire [4:0] MUX1_BR;
	wire [31:0] MUX3_BR;
	wire [31:0] dadoRS;
	wire [31:0] dadoRT;
	wire [31:0] dadoRD;
	wire [31:0] EXTENDIDO;
	wire [31:0] MUX2_ALU;
	// wire [31:0] RESULTADO;
	wire [31:0] sinal_ALU_ZERO;
	wire [31:0] sinal_ALU_NEG;
	wire [31:0] MEMD_MUX3;
	wire [31:0] EXTENDIDO_DESLOCADO;
	wire [27:0] END_JUMP;
	
	output [31:0] RESULTADO;
	
	programCounter programCounter(MUX4_PC, 
											END_ATUAL, 
											clock);

	
	memoriaInstrucao memoriaInstrucao(END_ATUAL,
												 INSTRUCAO,
												 clock);
												 
	
	MUX_1 MUX_1(INSTRUCAO[20:16],
					INSTRUCAO[15:11],
					MUX1_BR,
					/*controle_MUX1*/1'b0);
					
	bancoRegistradores bancoRegistradores(INSTRUCAO[25:21],
													  INSTRUCAO[20:16],
													  MUX1_BR,
													  MUX3_BR,
													  dadoRS,
													  dadoRT,
													  dadoRD,
													  /*controle_BR*/1'b0,
													  clock);
													  
	extensor16_32 extensor16_32(INSTRUCAO[15:0],
										 EXTENDIDO);
										 
	deslocamento_2 deslocamento_2(EXTENDIDO,
											EXTENDIDO_DESLOCADO);
										 
	MUX_2 MUX_2(dadoRT,
					EXTENDIDO,
					MUX2_ALU,
					/*controle_MUX2*/1'b0);
	ALU ALU(dadoRS,
			  MUX2_ALU,
			  RESULTADO,
			  /*controle_ALU*/3'b000,
			  sinal_ALU_ZERO,
			  sinal_ALU_NEG,
			  clock);
	
	memoriaDados memoriaDados(RESULTADO,
									  dadoRT,
									  MEMD_MUX3,
									  /*controle_MEMD*/1'b0,
									  clock);
									  
	MUX_3 MUX_3(MEMD_MUX3,
					RESULTADO,
					MUX3_BR,
					/*controle_MUX3*/1'b0);
					
	extensor26_28 extensor26_28(INSTRUCAO[25:0],
										 END_JUMP);
					
	MUX_4 MUX_4(END_ATUAL,
					EXTENDIDO_DESLOCADO,
					END_JUMP,
					MUX4_PC,
					/*controle_MUX4*/2'b00,
					sinal_ALU_ZERO);
					
	
endmodule 


