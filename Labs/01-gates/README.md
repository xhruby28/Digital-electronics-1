## 01-gates
[My GitHub repository](https://github.com/xhruby28/Digital-electronics-1)

#### De Morgan's laws simulation

```vhdl
architecture dataflow of gates is
begin
    f_o  <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    fnand_o <= not (not (not b_i and a_i) and not(not b_i and not c_i));
    fnor_o <= not (b_i or not a_i) or not (c_i or b_i);

end architecture dataflow;
```

![Simulation De Morgan's law](Images/.png)

[](https://www.edaplayground.com/x/7Xvg)
