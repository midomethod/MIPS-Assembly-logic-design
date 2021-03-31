------------------------
LAB 2: The Price is Random
CMPE 012 Summer 2018
Kanuma, Midori
mkanuma
-------------------------
What were the learning objectives of this lab?

   The learning objectives of this lab was to learn how to implement
adders, comparitors, multiplexers, and registers in a useful way.
   To create a comparitor, I had to make a truth table and use the SOP
method to come up with the gate representation of the comparitor.
   For the extra credit, I had to create a new register to keep track
of the actual random number while using multiplexers to choose between
showing the real random number and the fake random number in the register.

Did you encounter any issues? Were there parts of this lab you found enjoyable?

   I encountered an issue where my score would go 3,2,1,0,-F,-E,-d,-C...
This issue was very hard to troubleshoot because it took me so long to find out
that I was using the value on the score board to increment the score instead of
the values stored in the register.
   I encountered the same issue when implementing the random number register.
I was comparing the user input againt the displayed random number instead of 
the random number stored in the register.
   Otherwise, this lab was a really fun and gainful learning experience for me :)

How would you redesign this lab to make it better?

   I would add the option to implement an ASCII display to show "YOU WIN!!!" when
score exceeds 7, and displays "YOU LOSE..." when score falls beneath -8.
   I could see that extra credit being a real hassle to implement since it's so
rough.