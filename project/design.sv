/* TLC - DESIGN
	AUSTIN H. DIAL
	MAY 08/2020

	Design of the traffic light controller. The states are
	  defined in

*/
module tlc
	(
		input logic sen1, sen2, clk, reset,
		output logic red1, red2, yellow1, yellow2, green1, green2
	);

	typedef enum {state0, state1, state2, state3, state4, state5, state6, state7} state_t;

	// Define state enumeration variables
	state_t state, next_state;

	always_ff @(posedge clk, posedge reset)
		begin
			if(reset)
				state = state0;
			else
				state = next_state;
		end

	always_comb
		begin
			// Set initial states
			green1 = 0;
			green2 = 0;
			yellow1 = 0;
			yellow2 = 0;
			red1 = 0;
			red2 = 0;

          // Determine behavior based on current state
          //   (state machine)
			case(state)

				state0:
					begin
                      	// Set lights
						green1 = 1;
						red2 = 1;

                      	// Dynamically determine next state behavior
						if(sen1 == sen2)
							next_state = state1;
						else if(sen1 == 0 && sen2 == 1)
							next_state = state2;
						else
							next_state = state0;
					end


				state1:
					begin
                      	// Set lights
						green1 = 1;
						red2 = 1;

                      	// Default state evolution
						next_state = state2;
					end


				state2:
					begin
                      	// Set lights
						green1 = 1;
						red2 = 1;

                      	// Default state evolution
						next_state = state3;
					end


				state3:
					begin
                      	// Set lights
						yellow1 = 1;
						red2 = 1;

                      	// Default state evolution
						next_state = state4;
					end


				state4:
					begin
                      	// Set lights
						green2 = 1;
						red1 = 1;

                      	// Dynamically determine next state behavior
						if(sen1 == 0 && sen2 == 0)
							next_state = state5;
						else if(sen1 == 1 && sen2 == 0)
							next_state = state6;
						else
							next_state = state4;
					end


				state5:
					begin
                      	// Set lights
						green2 = 1;
						red1 = 1;

                      	// Default state evolution
						next_state = state6;
					end


				state6:
					begin
                      	// Set lights
						green2 = 1;
						red1 = 1;

                      	// Default state evolution
						next_state = state7;
					end


				state7:
					begin
                      	// Set lights
						yellow2 = 1;
						red1 = 1;

                      	// Default state evolution
						next_state = state0;
					end
			endcase
		end
endmodule