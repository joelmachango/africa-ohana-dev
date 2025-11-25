public class PrimitiveDatatypeExercises {

    // This method contains the exercise code
    public static void runExercises() {
        // --- 1. Salary (Double) --- (lighter)
        // Double mySalary = 101.56; 
        // System.debug('--- 1. Salary ---');
        // System.debug('My Salary: ' + mySalary);

        // --- 1. Salary (Decimal) ---
        Decimal mySalary = 101.56;
        System.debug('--- 1. Salary ---');
        System.debug('My Salary: ' + mySalary);

        // --- 2. Age (Integer) ---
        Integer myAge = 30; 
        System.debug('--- 2. Age ---');
        System.debug('My Age: ' + myAge);

        // --- 3. String Manipulation ---
        String sessionMessage = 'hello Hola Too My Session!';
        // sessionMessage = 'Hello to Code With Sally session.';
        // System.debug('--- 3. String Manipulation ---');
        // System.debug('Updated Session Message: ' + sessionMessage);

        sessionMessage = sessionMessage.toLowerCase().capitalize().removeEnd('!').replace('hola too my', 'to Code With Sally')+'.';
        System.debug('Updated Session Message2: ' + sessionMessage);

        // --- 4. Boolean and Comparison ---
        Integer num1 = 10;
        Integer num2 = 5;
        Boolean isGreater = (num1 > num2); 
        System.debug('--- 4. Boolean Comparison ---');
        System.debug('Is num1 greater than num2? ' + isGreater);

        // --- 5. Date Methods ---
        Date today = Date.today();
        Date dateInThreeMonths = today.addMonths(3);
        System.debug('--- 5. Date Methods ---');
        System.debug('Today\'s Date: ' + today);
        System.debug('Date in 3 Months: ' + dateInThreeMonths);
    }
}