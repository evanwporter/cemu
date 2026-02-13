### Data Operation (Stalled by Reg Shift)

| Cycle | 1   | 2   | 3   | 4   | 5   | 5   | 6   |
| ----- | --- | --- | --- | --- | --- | --- | --- |
| I1    | F   | D   | I   | S   |     |     |     |
| I2    |     | F   | -   | D   | S   |     |     |
| I3    |     |     |     | F   | D   | S   |     |
| I4    |     |     |     |     | F   | D   | S   |

### Control Signals

In a basic data operation involving the ALU, everything was
already calculated in the previous cycle (the RHS). The only thing
that changed was the LHS which was latched onto.

Control signals dictate what happens the next cycle (although the calculations
are done in the current cycle).

In accordance to the the startup looks like so:

Cycle 1: Reset everything to zero

Externally set registers

Cycle 2: Reset part 2; schedule flush to start next cycle

Cycle 3: Reset part 3;
