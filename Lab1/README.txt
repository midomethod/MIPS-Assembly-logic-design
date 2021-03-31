------------------------
LAB 1: Intro to Logic Simulation
CMPE 012 Fall 2018

Kanuma, Midori
mkanuma
-------------------------

What did you learn in this lab?

   In this lab, I learned that I could represent any boolean
expression/truth table using AND gates, OR gates, and inverters.
I also confirmed that through the use of De Morgan's law,
I could represent any logic circuit using only NAND gates or
only NOR gates. I also came to the realization that the reason
NAND/NOR gates are universal while AND/OR aren't is because I
can't represent an inverter using only AND gates or only OR gates.

   Finally, I learned that the use of senders and receivers
helps de-clutter your circuits where wires may cross due to
pulling outputs from the same node. With liberal use of receivers,
I was able to implement the codes in part C with very streamlined
design, which I am proud of.

What worked well? Did you encounter any issues?

   Using as many receivers as possible whenever I saw the opportunity
seemed to be the key in making this task easy on me. However, I
encounted errors when I tried to simulate the circuit where a receiver
had no corresponding senders. This was easily solved when I created
dummy senders to force the simulation to run without errors.

How would you redesign this lab to make it better?

   I personally found the instruction for part A to be very
unclear. I interpreted part A to be a circuit where it takes
a binary input and outputs a decimal number on the 7-segment
display. Even then, I was confused because we weren't told if
the dot on the bottom-right should be on or off.

   Otherwise, this lab was very fun!