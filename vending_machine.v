module vending_machine 
#(
    // Define states for the vending machine
    parameter IDLE = 0,
    parameter ACCEPT_MONEY = 1,
    parameter SELECT_ITEM = 2,
    parameter DISPENSE_ITEM = 3,
    parameter RETURN_CHANGE = 4
)
(
    input i_clk,
    input i_resetn,
    input [1:0] i_select,
    input [5:0] i_money_in,
    output reg o_dispense,
    output reg [5:0] o_change
);

  // Register to hold the current state
    reg [2:0] current_state;

  // Registers to hold the inserted money and selected item
    reg [5:0] money_in;
    reg [1:0] selected_item;

  // Combinational logic to determine the next state
    always @(current_state or i_money_in ) begin
        case (current_state)
        IDLE:
            if (i_money_in != 0) begin
                current_state <= ACCEPT_MONEY;
            end
        ACCEPT_MONEY:
            if (i_money_in >= 10) begin
                current_state <= SELECT_ITEM;
            end
        SELECT_ITEM:
            if (i_select != 0) begin
                current_state <= DISPENSE_ITEM;
            end
        DISPENSE_ITEM:
            if (money_in >= 30 + selected_item * 10) begin
                current_state <= RETURN_CHANGE;
            end
        RETURN_CHANGE:
            current_state <= IDLE;
        endcase
    end

    // Combinational logic to dispense item and calculate change
    always @(current_state or i_money_in) begin
        o_dispense = (current_state == DISPENSE_ITEM);
        o_change = money_in - 30 - selected_item * 10;
    end

    // Sequential logic to update the registers
    always @(posedge i_clk or negedge i_resetn) begin
        if (!i_resetn) begin
            current_state <= IDLE;
            money_in <= 0;
            selected_item <= 0;
        end 
        else begin
            case (current_state)
                ACCEPT_MONEY:
                    money_in <= i_money_in;
                SELECT_ITEM:
                    selected_item <= i_select;
                DISPENSE_ITEM:
                    money_in <= money_in - 30 - selected_item * 10;
            endcase
        end
    end

endmodule

