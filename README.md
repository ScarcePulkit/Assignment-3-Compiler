## Assignment-3-Compiler
#Introduction
This Lex code is used to generate a DFA (Deterministic Finite Automaton) that processes a specific input file and extracts
(i) The number of transactions on the given date
(ii) The custId of the customer with maximum transaction value on the given date.

#Compilation and Execution
To compile and run the Lex code, follow these steps:

Make sure you have Lex (flex) installed on your system.
Save the Lex code in a file, for example, "main.l".
Compile the Lex code using the following command:
**lex main.l**
**gcc lex.yy.c -ll**
Create an input file containing the data entries you want to process. Save it as "data.txt".
Run the compiled executable:
./a.out 
After execution, the program will generate an output file named "output.txt" containing the calculated statistics.

#DFA Rules and Processing Logic
The Lex code defines a DFA that processes the "data.txt" file and extracts specific patterns representing data entries. The processed data is then used to calculate some statistics. The main components of the DFA and their functionality are explained below:

**1. yywrap() Function:**
This function is called when the end of the input file is reached. It returns 1 to signal the end of the input to the Lex scanner.
**2. States (%x):**
The DFA uses various states to handle different parts of the input. The states used are:
DOL: The initial state, where the DFA looks for identifiers starting with '$'.
SPACE1: The state after finding a valid identifier, where spaces and tabs are skipped until the start of a date (DD).
DATE: The state for processing the day (DD) part of the date.
SL: The state after finding the first slash ('/') in the date.
MONTH: The state for processing the month (MM) part of the date.
SPACE2: The state after finding a valid date, where spaces and tabs are skipped until the start of a value (V).
SC: The state for processing the value (V) part of the data entry.
VAL: The state after finding a valid value, where the DFA waits for a semicolon (';').
**3. DFA Logic:**
The DFA processes the input file as follows:
It identifies identifiers starting with '$' in the DOL state.
After identifying an identifier, it skips spaces and tabs and enters the DATE state to process the day (DD) part of the date.
Upon finding the first slash ('/') in the date, it enters the MONTH state to process the month (MM) part of the date.
After finding a valid date, it skips spaces and tabs and enters the VAL state to process the value (V) part of the data entry.
After finding a valid value, it waits for a semicolon (';') to end the data entry.
It calculates the statistics for each unique day and month combination and stores them in the dat array of structures.
**4. Output:**
After processing the entire input file, the DFA calculates the maximum value (V) and the corresponding identifier for each unique day and month combination. The statistics are stored in the dat array. The DFA then reads an input file named "input.txt" (assuming it exists) and looks for specific entries in the dat array based on the data from "data.txt". Finally, it writes the calculated statistics for the particular data entry to the "output.txt" file.

#Important Variables and Structures
curid: Stores the current identifier found in the input file.
d: Stores the processed day (DD) from the date.
m: Stores the processed month (MM) from the date.
temp: Temporary string buffer used to convert parsed day and month strings to integers.
val: Stores the parsed value (V) from the data entry.
err: An error flag used to indicate invalid input.
struct Date: A structure that holds data related to a particular day and month combination, such as the maximum value (V) and its corresponding identifier.

#Input and Output Files
Input File: The Lex code expects an input file named "data.txt" containing data entries in a specific format, as described in the DFA Logic section above. Each data entry starts with an identifier starting with '$', followed by a date in the format "DD/MM", and a value (integer) separated by semicolons.

Output File: After processing the input file, the Lex code generates an output file named "output.txt". This file contains specific entries from the processed data along with their calculated statistics. The format of each line in "output.txt" is: "$<k>$<identifier>#", where <k> is the number of occurrences for that specific day and month combination, and <identifier> is the identifier associated with the maximum value (V) for that combination.

#Conclusion
The provided Lex code generates a DFA that processes a given input file containing data entries. It extracts specific patterns representing days, months, and values from the entries and calculates statistics based on this data. The statistics are then written to an output file. Users can customize and enhance the code as needed to fit their specific use cases and requirements.
