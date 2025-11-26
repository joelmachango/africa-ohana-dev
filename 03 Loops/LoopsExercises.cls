/**
 * LoopsExercises
 * while loops, for loops, and loop control statements (break/continue).
 */
public class LoopsExercises {

    public static void runAllExercises() {
        // -----------------------------------------------------------------
        // 1. While Loop: Print numbers from 1 to 10
        // -----------------------------------------------------------------
        
        System.debug('\n--- 1. While Loop (1 to 10) ---');
        Integer counter = 1;
        while (counter <= 10) {
            System.debug('Number: ' + counter);
            // Increment the counter to ensure the loop eventually exits
            counter++; 
        }


        // -----------------------------------------------------------------
        // 2. Traditional For Loop with Break: Iterate 1 to 20, break at 15
        // -----------------------------------------------------------------
        
        System.debug('\n--- 2. For Loop with Break (1 to 20, break at 15) ---');
        // Traditional for loop structure: (Initialization; Condition; Increment)
        for (Integer i = 1; i <= 20; i++) {
            System.debug('Current Number: ' + i);
            
            // Exit the loop when the number equals 15
            if (i == 15) {
                System.debug('BREAK statement executed: Exiting loop at i = 15.');
                break; 
            }
        }


        // -----------------------------------------------------------------
        // 3. For-Each Loop with Continue: Skip names starting with 'A'
        // -----------------------------------------------------------------
        
        System.debug('\n--- 3. For-Each Loop with Continue (Skip names starting with "A") ---');
        List<String> names = new List<String>{'Sally', 'Adam', 'Betty', 'Joel', 'Alice', 'Charles', 'Andrew', 'David'};
        
        for (String name : names) {
            // Check if the name starts with 'A' (case-insensitive check using startsWithIgnoreCase)
            if (name.startsWithIgnoreCase('A')) {
                System.debug('Skipping name starting with A: ' + name);
                continue; // Skip the rest of the loop body for this iteration
            }
            
            // This line is only reached if the name does NOT start with 'A'
            System.debug('Processing Name: ' + name);
        }


        // -----------------------------------------------------------------
        // 4. Nested Loops: Generate a 10 x 100 Multiplication Table
        // -----------------------------------------------------------------
        
        System.debug('\n--- 4. Nested Loops (10x100 Multiplication Table) ---');
        
        // Outer loop handles the first factor (rows, 1 through 10)
        for (Integer i = 1; i <= 10; i++) {
            String rowOutput = '';
            
            // Inner loop now goes up to 100 for the second factor
            for (Integer j = 1; j <= 100; j++) {
                Integer result = i * j;
                String paddedResult;

                // Logic to ensure consistent 4-digit width padding for readability
                if (result < 10) {
                    paddedResult = '   ' + result;
                } else if (result < 100) {
                    paddedResult = '  ' + result;
                } else if (result < 1000) {
                    paddedResult = ' ' + result;
                } else {
                    paddedResult = '' + result;
                }
                
                rowOutput += paddedResult; 
            }
            // Print the full row after the inner loop completes
            // Note: The resulting debug line will be very long (approx 400 characters)
            System.debug('Row ' + i + ': ' + rowOutput);
        }
    }
}