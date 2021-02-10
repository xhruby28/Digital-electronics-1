## 01-gates


####De Morgan's laws simulation

```vhdl
architecture dataflow of gates is
begin
    f_o  <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    --fnand_o <= ;
    --fnor_o <= a_i xor b_i;

end architecture dataflow;
```

![Simulation De Morgan's law](Images/.png)

[](https://www.edaplayground.com/x/7Xvg)