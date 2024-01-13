# Vending-Machine
This Verilog module implements the control logic for a simple vending machine. The vending machine has several states, including idle, accepting money, selecting an item, dispensing the item, and returning change. The module takes inputs such as clock, reset, selected item, and money inserted, and produces outputs to dispense items and provide change.

States

1).IDLE (0): Initial state where the vending machine is waiting for user interaction.

2).ACCEPT_MONEY (1): State where the machine accepts money from the user.

3).SELECT_ITEM (2): State where the user selects an item after a sufficient amount of money is inserted.

4).DISPENSE_ITEM (3): State where the machine dispenses the selected item.

5).RETURN_CHANGE (4): State where any remaining money is returned as change.

Inputs

1).i_clk: Clock input.

2).i_resetn: Active-low asynchronous reset.

3).i_select[1:0]: Input representing the user's selected item.

4).i_money_in[5:0]: Input representing the money inserted by the user.

Outputs

1).o_dispense: Output indicating whether to dispense the selected item.

2).o_change[5:0]: Output representing the change to be returned to the user.

State Transitions

1).IDLE to ACCEPT_MONEY: Transition occurs when money is inserted (i_money_in != 0).

2).ACCEPT_MONEY to SELECT_ITEM: Transition occurs when the inserted money is equal to or exceeds the price of the selected item (i_money_in >= 10).

3).SELECT_ITEM to DISPENSE_ITEM: Transition occurs when the user selects an item (i_select != 0).

4).DISPENSE_ITEM to RETURN_CHANGE: Transition occurs when the amount of money inserted is sufficient to cover the cost of the selected item (money_in >= 30 + selected_item * 10).

5).RETURN_CHANGE to IDLE: Transition occurs after returning change.

Operation

1).Initialization: The module is initialized to the IDLE state with zero money and no selected item.

2).User Interaction: Users insert money, select an item, and trigger actions by interacting with the vending machine.

3).State Transitions: The module transitions between states based on user actions and conditions (money insertion, item selection, etc.).

4).Outputs: The module produces outputs indicating whether to dispense the item and the amount of change to be returned.

5).Sequential Logic: Sequential logic is used to update internal registers based on state transitions.
