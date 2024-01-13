module vending_machine_tb;

    reg i_clk, i_resetn, i_select;
    reg [5:0] i_money_in;
    wire o_dispense, o_change;
    reg error_message; // Flag for error messages

  // Instantiate the vending machine
    vending_machine uut (
        .i_clk(i_clk),
        .i_resetn(i_resetn),
        .i_select(i_select),
        .i_money_in(i_money_in),
        .o_dispense(o_dispense),
        .o_change(o_change)
    );

  // Clock generation
    initial begin
        i_clk = 0;
        forever #10 i_clk = ~i_clk;
    end

  // Task for resetting the machine and initializing variables
    task reset_machine;
        begin
            i_resetn = 1'b0;
            #5 i_resetn = 1'b1;
            error_message = 1'b0;
        end
    endtask

  // Task for testing insert money scenario
    task test_insert_money(input reg [5:0] amount);
        begin
            reset_machine();
            i_money_in = amount;
            #20; // Wait for money processing
            if (amount < 10 && error_message) begin
            end
        end
    endtask

    // Task for testing item selection scenario
    task test_select_item(input reg [1:0] selection);
        begin
            i_select = selection;
            #20; // Wait for selection processing
            // Check dispense signal and error message based on selection validity and funds
            if (!error_message && o_dispense) begin
                //Verify dispensing logic and item dispensed (if applicable)
            end
            if (error_message && !o_dispense) begin
                //Verify error message logic for invalid selection or insufficient funds
            end
        end
    endtask

  // Task for testing complete transaction (insert money, select item, dispense/error)
    task test_transaction(input reg [5:0] amount, input reg [1:0] selection);
        begin
            test_insert_money(amount);
            test_select_item(selection);
        end
    endtask

  // Main test sequence
    initial begin
        // Test Case 1: Insert sufficient money and select valid item (dispensed)
        test_transaction(50, 2);
    
        // Test Case 2: Insufficient funds (error message)
        test_transaction(10, 2);
    
        // Test Case 3: Exact amount (no change dispensed)
        test_transaction(50, 3);
    
        // Test Case 4: Overpayment (correct change dispensed)
        test_transaction(100, 1);
    
        test_transaction(150,2);

        $finish;

    end

endmodule
