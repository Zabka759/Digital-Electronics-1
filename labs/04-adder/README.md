# Lab 4: Binary adder

## Preparation tasks 

1. A half adder has two inputs A and B and two outputs Carry and Sum. Comlpete the half adder truth table. Draw a logic diagram of both output functions.

    | **B** | **A** | **Sum** | **Carry** |
    | :-: | :-: | :-: | :-: |
    | 0 | 0 | 0 | 0 |
    | 0 | 1 | 1 | 0 |
    | 1 | 0 | 1 | 0 |
    | 1 | 1 | 0 | 1 |
    
![Half_adder](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/04-adder/halfadder.png)

2. A full adder has three inputs and two outputs. The two inputs are A, B, and Carry input. The outputs are Carry output and Sum. Comlpete the full adder truth table and draw a logic diagram of both output functions.

    | **Cin** | **B** | **A** | **Cout** | **Sum** |
    | :-: | :-: | :-: | :-: | :-: |
    | 0 | 0 | 0 | 0 | 0 |
    | 0 | 0 | 1 | 0 | 1 |
    | 0 | 1 | 0 | 0 | 1 |
    | 0 | 1 | 1 | 1 | 0 |
    | 1 | 0 | 0 | 0 | 1 |
    | 1 | 0 | 1 | 1 | 0 |
    | 1 | 1 | 0 | 1 | 0 |
    | 1 | 1 | 1 | 1 | 1 |
![Full_adder](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/04-adder/fulladder.png)
3. Find the relationship between half adder and full adder logic diagrams.
The relationship is that the full adder is composed from two half adders as it is shown in picture below:

![binaryadder](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/04-adder/tempsnip.png)

4. See schematic of the [CPLD expansion board](../../Docs/cpld_expansion.pdf) and find out the connection of LEDs, push buttons, and slide switches.

![LEDs](https://github.com/Zabka759/Digital-Electronics-1/blob/master/labs/04-adder/LEDs_SW.png)
Every button is connected to a switch with same number
