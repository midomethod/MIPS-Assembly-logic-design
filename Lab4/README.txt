------------------------
Lab 4: ASCII Decimal to 2SC
CMPE 012 Fall 2018
Kanuma, Midori
mkanuma
-------------------------
What was your approach to converting each decimal number to two’s complement
form?

My approach involved multi-step process. First was to first check if the first
character is a hyphen. This way, I knew whether the numbers have to undergo a
two's complement operation afterwards. Then, in either cases, I kept checking the
bytes until I found the null terminator. I would also simultaneously increment a
counter so I knew how many digits there are, hyphen excluded. Then, I would read
the first digit, which is in 1's place. This meant that I simply had to load that,
mask the 2nd hexadecimal deigit e.g. 0x34 -> 0x04, then load that into $s1. For the
second number, we know it is in 10's place so we load byte, mask 2nd hex, multiply
by 10, and add it to $s1. I did the same for $s2(program argument B). After that,
the numbers were ready to be added!

What did you learn in this lab?

I learned how important it is to understand how the loads and the stores interacts
with memory. I found out that using memory is useful when you have to start a 
sequence from the rear end of the data, since that way we know the length as well.
I also learned that labels are super important because its utility includes loops,
skips, and subroutines(I ended up doing something like a subroutine in my lab but
it was solely based on my knowledge before the lab was assigned.

Did you encounter any issues? Were there parts of this lab you found enjoyable?

I encountered an issue where I was overwriting one of the variables without knowing,
and it took a fresh set of eyes to notice that I was doing that. After that, I was
able to complete the lab with no further hiccups along the way.

How would you redesign this lab to make it better?

I would make the range of inputs greater than [-64,63]
