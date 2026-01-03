# CO513-Programming-Assignment-2-CIPRIANO

A short ARMv7 assembly program for the DE1-SoC (CPUlator) that implements a two-digit counter (00–59) displayed on the HEX1:HEX0 7-segment displays. The counter supports count up or count down operation, controlled by a pushbutton (KEY) and switch input, and includes debouncing to ensure reliable and stable button detection.


## Part 1: Debouncing 

### 1. What mechanical switch bounce is and why it occurs.
   
   Mechanical switch bounce is the rapid and unintended sequence of on–off electrical transitions that occurs when a physical pushbutton is pressed or released. It happens because the metal contacts inside the switch do not make a clean connection instantly; instead, they briefly vibrate and collide for about 1–10 milliseconds before settling, producing multiple electrical transitions rather than a single, stable signal. This becomes a problem because the CPU operates much faster than the mechanical switch, so it may interpret these rapid transitions as multiple button presses, causing effects such as counters incrementing multiple times, unpredictable button behavior, and failed or unstable toggle operations.

### 2. What active - LOW means for the DE1 - SoC KEY inputs.
   
   On the DE1-SoC board, the pushbuttons KEY[3:0] are active-LOW, which means that when a button is not pressed it reads a logic 1 (HIGH), and when it is pressed it reads a logic 0 (LOW). This design uses pull-up resistors, which helps improve noise immunity and is common in FPGA and embedded systems. As a result, software must detect a button press by checking for a LOW (0) value rather than a HIGH value, since a press is indicated by 0 and not by 1.

 ### 3. How software debouncing works — including time delays, confirm - after - delay checks, and optional “wait for release.”
 
Software debouncing works by using simple timing and state-checking techniques in software to filter out the unwanted signal noise caused by mechanical switch bounce.

- Software debouncing prevents false or multiple triggers caused by rapid signal fluctuations when a mechanical button is pressed.

- Mechanical bounce occurs for a few milliseconds as the contacts vibrate, producing multiple transitions.

- Time-delay debouncing waits a short fixed delay (≈5–20 ms) after a detected press and ignores changes during that time.

- Confirm-after-delay debouncing waits briefly and checks the button again, accepting the press only if it is still stable.

- Wait-for-release (optional) ensures a new press is not registered until the button is released.


## Part 2: Summary and Implementation

### Why debouncing is needed?

Debouncing is essential in embedded systems because mechanical buttons do not produce clean, single transitions when pressed or released. Instead, they generate rapid, unintended on/off signals known as bounce. Without debouncing, the processor may interpret one physical button press as multiple inputs, leading to incorrect behavior such as double counts, unintended mode changes, or unstable system operation. Debouncing ensures that each button press is recognized as one valid, reliable event, resulting in predictable and stable system behavior.

### Method Implemented.

This program uses basic edge-detection (state-change) debouncing, not a timed debounce.

The code tracks the previous state of KEY0 in register R7. A button press is recognized only when KEY0 changes from released (1) to pressed (0). This prevents repeated toggling while the button is held down.

In short, the program implements edge-detection debouncing, which is sufficient for basic control in CPUlator but less robust than confirm-after-delay debouncing used in real hardware.

## Part 3: YouTube video link:



   
