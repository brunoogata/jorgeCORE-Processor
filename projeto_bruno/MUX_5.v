module MUX_5 (entrada_ALU, entrada_extendido, saida, controle /*LW ou SW*/);

	// input
	input [31:0] entrada_ALU;
	input [31:0] entrada_extendido;
	input controle;
	
	// output 
	output reg [31:0] saida;
	
	always @ (*) begin
		
		if(controle == 0) begin
			
			saida = entrada_ALU;
		end
		
		if(controle == 1) begin
			
			saida = entrada_extendido;
		end
	end
endmodule 