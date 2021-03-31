------------------------
Lab 3: Looping in MIPS
CMPE 012 Summer 2018
Kanuma, Midori
mkanuma
-------------------------
The text of your prompt (“Please input a positive integer: ”) and output strings
(“Flux” and “Bunny”) are stored in the processor’s memory. After assembling your
program, what is the range of addresses in which these strings are stored?

These values are is stored in addresses from 0x10010000 to 0x100100B. Each word
of data is in reverse order because MIPS is a little-Endian ISA.

What were the learning objectives of this lab?

The learning objectives of this lab was for us to learn how to emulate for loops
using branch statements and jumps. Learning specificly how jumps and branches function
in terms of memory addresses were important for this lab, I feel.

Did you encounter any issues? Were there parts of this lab you found enjoyable?

I encountered an issue where my program would just end after the branch statement.
After thorough investigation, I found out that I have to include a jump to take
me back to the body of the loop. This was a concept that wasn't entirely clear to
me. I also had trouble with the condition for printing the space between the Flux
and Bunny since there wasn't a branch statement for multiple boolean expressions.

How would you redesign this lab to make it better?

I would brief the students on how branch statements work so they won't be caught off-
guard. Otherwise, it was a fun lab.