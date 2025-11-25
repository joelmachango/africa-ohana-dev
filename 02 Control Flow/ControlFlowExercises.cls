/**
 * ControlFlowExercises
 * conditional logic (if/else), the ternary operator, and switch statements.
 */
public class ControlFlowExercises {

    public static void runAllExercises() {
        System.debug('======================================');
        System.debug('STARTING APEX CONTROL FLOW EXERCISES');
        System.debug('======================================');

        // -----------------------------------------------------------------
        // 1. Check Age (If Statement)
        // -----------------------------------------------------------------
        
        Integer personAge = 25; // Change this value to test different outcomes
        
        System.debug('\n--- 1. Age Check ---');
        System.debug('Current Age: ' + personAge);
        
        // Check if a person's age is 18 or older
        if (personAge >= 18) {
            System.debug('Result: You are an adult.');
        } else {
            System.debug('Result: You are NOT an adult.');
        }


        // -----------------------------------------------------------------
        // 2. Temperature Check (If-Else Statement)
        // -----------------------------------------------------------------
        
        Decimal temperature = 32.5; // Temperature in degrees Celsius
        
        System.debug('\n--- 2. Temperature Check ---');
        System.debug('Current Temperature: ' + temperature);
        
        // Determine if it's hot outside (temperature > 30)
        if (temperature > 30) {
            System.debug('Result: It\'s hot outside.');
        } else {
            System.debug('Result: It\'s not too hot.');
        }


        // -----------------------------------------------------------------
        // 3. Score Evaluation (Ternary Operator)
        // -----------------------------------------------------------------
        
        Integer score = 75; // Change this value to test Pass or Fail
        String result;
        
        System.debug('\n--- 3. Score Evaluation (Ternary) ---');
        System.debug('Current Score: ' + score);

        // Ternary operator: (Condition) ? Value_if_True : Value_if_False;
        // If score >= 60, result is "Pass"; otherwise, "Fail".
        result = (score >= 60) ? 'Pass' : 'Fail';
        
        System.debug('Result: ' + result);
        
        
        // -----------------------------------------------------------------
        // 4. Day of the Week (If-Else If Ladder)
        // -----------------------------------------------------------------
        
        Integer day = 3; // 1=Sunday, 2=Monday, 3=Tuesday...
        String dayName;
        
        System.debug('\n--- 4. Day of the Week (If-Else If) ---');
        System.debug('Day Number: ' + day);
        
        // Use an if-else if ladder to determine the day name
        if (day == 1) {
            dayName = 'Sunday';
        } else if (day == 2) {
            dayName = 'Monday';
        } else if (day == 3) {
            dayName = 'Tuesday';
        } else if (day == 4) {
            dayName = 'Wednesday';
        } else if (day == 5) {
            dayName = 'Thursday';
        } else if (day == 6) {
            dayName = 'Friday';
        } else if (day == 7) {
            dayName = 'Saturday';
        } else {
            dayName = 'Invalid Day Number';
        }
        
        System.debug('Day Name: ' + dayName);


        // -----------------------------------------------------------------
        // 5. Fruit Color (Switch Statement)
        // -----------------------------------------------------------------
        
        String fruit = 'Banana'; // Change to 'Apple', 'Orange', or 'Grape' to test
        String color;
        
        System.debug('\n--- 5. Fruit Color (Switch) ---');
        System.debug('Fruit: ' + fruit);
        
        // Use a switch statement (Apex 57.0 API version and later)
        // Note: Apex switch uses 'when' instead of 'case'
        switch on fruit {
            when 'Apple' {
                color = 'Red';
            }
            when 'Banana' {
                color = 'Yellow';
            }
            when 'Orange' {
                color = 'Orange';
            }
            when else { // Handles any case not explicitly listed above
                color = 'Unknown';
            }
        }
        
        System.debug('Color: ' + color);
        
        System.debug('======================================');
        System.debug('EXERCISES COMPLETE');
        System.debug('======================================');
    }
}