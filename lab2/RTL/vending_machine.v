`include "vending_machine_def.v"

module vending_machine (

	clk,							// Clock signal
	reset_n,						// Reset signal (active-low)

	i_input_coin,				// coin is inserted.
	i_select_item,				// item is selected.
	i_trigger_return,			// change-return is triggered

	o_available_item,			// Sign of the item availability
	o_output_item,			// Sign of the item withdrawal
	o_return_coin,				// Sign of the coin return
	stopwatch,
	current_total,
	return_temp,
);

	// Ports Declaration
	// Do not modify the module interface
	input clk;
	input reset_n;

	input [`kNumCoins-1:0] i_input_coin;
	input [`kNumItems-1:0] i_select_item;
	input i_trigger_return;

	output reg [`kNumItems-1:0] o_available_item;
	output reg [`kNumItems-1:0] o_output_item;
	output reg [`kNumCoins-1:0] o_return_coin;

	output [3:0] stopwatch;
	output [`kTotalBits-1:0] current_total;
	output [`kTotalBits-1:0] return_temp;
	// Normally, every output is register,
	//   so that it can provide stable value to the outside.

//////////////////////////////////////////////////////////////////////	/

	//we have to return many coins
	reg [`kCoinBits-1:0] returning_coin_0;
	reg [`kCoinBits-1:0] returning_coin_1;
	reg [`kCoinBits-1:0] returning_coin_2;
	reg block_item_0;
	reg block_item_1;
	//check timeout
	reg [3:0] stopwatch;
	//when return triggered
	reg have_to_return;
	reg  [`kTotalBits-1:0] return_temp;
	reg [`kTotalBits-1:0] temp;
////////////////////////////////////////////////////////////////////////

	// Net constant values (prefix kk & CamelCase)
	// Please refer the wikepedia webpate to know the CamelCase practive of writing.
	// http://en.wikipedia.org/wiki/CamelCase
	// Do not modify the values.
	wire [31:0] kkItemPrice [`kNumItems-1:0];	// Price of each item
	wire [31:0] kkCoinValue [`kNumCoins-1:0];	// Value of each coin
	assign kkItemPrice[0] = 400;
	assign kkItemPrice[1] = 500;
	assign kkItemPrice[2] = 1000;
	assign kkItemPrice[3] = 2000;
	assign kkCoinValue[0] = 100;
	assign kkCoinValue[1] = 500;
	assign kkCoinValue[2] = 1000;


	// NOTE: integer will never be used other than special usages.
	// Only used for loop iteration.
	// You may add more integer variables for loop iteration.
	integer i, j, k,l,m,n;

	// Internal states. You may add your own net & reg variables.
	reg [`kTotalBits-1:0] current_total;
	reg [`kItemBits-1:0] num_items [`kNumItems-1:0];
	reg [`kCoinBits-1:0] num_coins [`kNumCoins-1:0];

	// Next internal states. You may add your own net and reg variables.
	reg [`kTotalBits-1:0] current_total_nxt;
	reg [`kItemBits-1:0] num_items_nxt [`kNumItems-1:0];
	reg [`kCoinBits-1:0] num_coins_nxt [`kNumCoins-1:0];

	// Variables. You may add more your own registers.
	reg [`kTotalBits-1:0] input_total, output_total, return_total_0,return_total_1,return_total_2;


	// Combinational logic for the next states
	always @(*) begin
		// TODO: current_total_nxt
		// You don't have to worry about concurrent activations in each input vector (or array).
		
		current_total_nxt=0;
		for (j = 0; j<3; j=j+1) begin
			num_coins_nxt[j]=0;
			num_items_nxt[j]=0;
		end
		num_items_nxt[3]=0;
		case (i_input_coin)
			3'b001:begin
				current_total_nxt=current_total_nxt+100;
				num_coins_nxt[0]=num_coins_nxt[0]+1;
			end
			3'b010:begin
				current_total_nxt=current_total_nxt+500;
				num_coins_nxt[1]=num_coins_nxt[1]+1;
			end
			3'b100:begin
				current_total_nxt=current_total_nxt+1000;
				num_coins_nxt[2]=num_coins_nxt[2]+1;
			end
		endcase

		
		if (i_select_item[0]) begin
			current_total_nxt=current_total_nxt-'d400;
			num_items_nxt[0]=num_items_nxt[0]+1;
		end
		if (i_select_item[1]) begin
			current_total_nxt=current_total_nxt-'d500;
			num_items_nxt[1]=num_items_nxt[1]+1;
		end
		if (i_select_item[2]) begin
			current_total_nxt=current_total_nxt-'d1000;
			num_items_nxt[2]=num_items_nxt[2]+1;
		end
		if (i_select_item[3]) begin
			current_total_nxt=current_total_nxt-'d2000;
			num_items_nxt[3]=num_items_nxt[3]+1;
		end
			
		// Calculate the next current_total state. current_total_nxt =

	end

	reg [`kTotalBits-1:0] current_return;
	// Combinational logic for the outputs
	always @(*) begin
	// TODO: o_available_item
	
		o_output_item[0]=num_items[0];
		o_output_item[1]=num_items[1];
		o_output_item[2]=num_items[2];
        o_output_item[3]=num_items[3];
		
		//TODO: o_output_item
		
	end

	// Sequential circuit to reset or update the states
	always @(posedge clk) begin
		if (!reset_n) begin
			// TODO: reset all states.
			for (i = 0; i<3; i=i+1) begin
				current_total=0;
				o_output_item[i]=0;
				num_coins_nxt[i]=0;
				num_coins[i]=0;
				o_return_coin[i]=0;
				num_items[i]=0;
			end
			num_items[3]=0;
			current_total_nxt=0;
			current_total=0;
			returning_coin_2=0;
			returning_coin_1=0;
			returning_coin_0=0;
			current_return=0;
		end
		else begin
			// TODO: update all states.
			current_total=current_total_nxt+current_total;
		    num_coins[0]=num_coins[0]+num_coins_nxt[0];
			num_coins[1]=num_coins[1]+num_coins_nxt[1];
			num_coins[2]=num_coins[2]+num_coins_nxt[2];
			num_items[0]=num_items[0]+num_items_nxt[0];
			num_items[1]=num_items[1]+num_items_nxt[1];
			num_items[2]=num_items[2]+num_items_nxt[2];
			num_items[3]=num_items[3]+num_items_nxt[3];
			
			
		o_available_item=(current_total>='d2000)?4'b1111:(
			(current_total>='d1000)?4'b0111:(
				(current_total>='d500)?4'b0011:(
					(current_total>='d400)?4'b0001:4'b0000
				)
			)
		);
		
		if (num_coins[0]>returning_coin_0&&current_total-current_return->100) begin
			returning_coin_0=returning_coin_0+1;
			o_return_coin[0]=1;
			current_return=current_return+100;
		end
		else if (num_coins[1]>returning_coin_1&current_total>500) begin
			returning_coin_1=returning_coin_1+1;
			o_return_coin[1]=1;
			current_return=current_return+500;
		end
		else if (num_coins[2]>returning_coin_2&current_total>1000) begin
			returning_coin_2=returning_coin_2+1;
			o_return_coin[2]=1;
			current_return=current_return+1000;
		end

			

		end		   //update all state end
	end	   //always end

endmodule
