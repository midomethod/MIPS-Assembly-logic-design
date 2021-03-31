------------------------
Lab 5: Subroutines
CMPE 012 Fall 2018
Kanuma, Midori
mkanuma
-------------------------
What was your design approach?

My design approach was to make the compare_chars subroutine first,
check it, then move on to the next subroutine. This approach worked
really well because I was able to know for sure that certain parts
of the code was working properly. I initially planned on doing the
extra credit, but opted not to do it due to time constraints. if I
were to do it, I would have made it so that when the character is
neither space, upper case alphabet or lower case alphabet, move to
the next address and don't run the compare_chars.

What did you learn in this lab?

I learned in this lab that it is essential to stay mindful of the
registers you are using and making sure that you don't overwrite
the registers that contain information that is pertinent to the
rest of the project. Between subroutines, it proved very important
to know how to push and pop the return address so that the $pc
doesn't get stuck in one of the subroutines.

Did you encounter any issues? Were there parts of this lab you found enjoyable?

I found testing out the code for functionality very enjoyable, since
I had to play through the whole game to see if my code would actually
output the message for game won when the user has finally correctly
entered everything. The parts of the lab that proved difficult was
definitely the debugging process. Since the beginning of the lab goes
through a few loops on its own, it was crucial for me to set a few
break points so I could check step by step after that point without
having to watch the $pc loop several times.

How would you redesign this lab to make it better?

I think this lab was very cool because all we had to do was make the
subroutines with the specified arguments and return values work the
way the lab intended. There was little space for creativity, which made
the coding of this lab very streamlined.