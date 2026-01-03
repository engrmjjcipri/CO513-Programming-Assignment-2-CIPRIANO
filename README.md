# CO513-Programming-Assignment-2-CIPRIANO

A short ARMv7 assembly program for the DE1-SoC (CPUlator) that implements a two-digit counter (00–59) displayed on the HEX1:HEX0 7-segment displays. The counter supports count up or count down operation, controlled by a pushbutton (KEY) and switch input, and includes debouncing to ensure reliable and stable button detection.


Part 1: Debouncing 

1. What mechanical switch bounce is and why it occurs
   Mechanical switch bounce is the rapid and unintended sequence of on–off electrical transitions that occurs when a physical pushbutton is pressed or released. It happens because the metal contacts inside the switch do not make a clean connection instantly; instead, they briefly vibrate and collide for about 1–10 milliseconds before settling, producing multiple electrical transitions rather than a single, stable signal. This becomes a problem because the CPU operates much faster than the mechanical switch, so it may interpret these rapid transitions as multiple button presses, causing effects such as counters incrementing multiple times, unpredictable button behavior, and failed or unstable toggle operations.

   
