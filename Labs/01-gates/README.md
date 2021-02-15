# 01-gates
[**My GitHub repository**](https://github.com/xhruby28/Digital-electronics-1)

## De Morgan's laws simulation

 | **c** | **b** |**a** | **f(c,b,a)** |
 | :-: | :-: | :-: | :-: |
 | 0 | 0 | 0 | 1 |
 | 0 | 0 | 1 | 1 |
 | 0 | 1 | 0 | 0 |
 | 0 | 1 | 1 | 0 |
 | 1 | 0 | 0 | 0 |
 | 1 | 0 | 1 | 1 |
 | 1 | 1 | 0 | 0 |
 | 1 | 1 | 1 | 0 |
#### VHDL Code

```vhdl
library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations

------------------------------------------------------------------------
-- Entity declaration for basic gates
------------------------------------------------------------------------
entity gates is
    port(
        a_i    : in  std_logic;          -- Data input
        b_i    : in  std_logic;          -- Data input
        c_i    : in  std_logic;		 -- Data input
        
	f_o     : out std_logic;         -- OR output function
        fnand_o : out std_logic;         -- NAND output function
        fnor_o  : out std_logic          -- NOR output function
    );
end entity gates;

------------------------------------------------------------------------
-- Architecture body for basic gates
------------------------------------------------------------------------
architecture dataflow of gates is
begin
    f_o  <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    fnand_o <= not (not (not b_i and a_i) and not(not b_i and not c_i));
    fnor_o <= not (b_i or not a_i) or not (c_i or b_i);
end architecture dataflow;
```

#### Simulation screenshot
![Simulation De Morgan's law](Images/DeMorgansLaws.png)

#### EDA Playground example 
[EDA Playground source code](https://www.edaplayground.com/x/7Xvg)
