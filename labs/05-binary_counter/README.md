## Preparation tasks 

1. Calculate how many periods of clock signal with ![equation](https://latex.codecogs.com/gif.latex?f_%7Bclk%7D%20%3D%2010%5C%2C%5Ctext%7BkHz%7D) contain time intervals 10&nbsp;ms, 250&nbsp;ms, 500&nbsp;ms, and 1&nbsp;s. Write values in decimal, binary, and hexadecimal forms.

    &nbsp;
    
    ![equation](https://latex.codecogs.com/gif.latex?T_{clk}&space;=&space;\frac{1}{f_{clk}}&space;=&space;\frac{1}{10000}&space;=&space;10^{-4}=100\mu&space;s)
  
    &nbsp;

    | **Time** | **Number of periods** | **Number of periods in binary** | **Number of periods in hexa** |
    | :-: | :-: | :-: | :-: |
    | 10&nbsp;ms | 100 | 0b1100100 | 0x64 |
    | 250&nbsp;ms | 2500 | 0b100111000100 | 0x9C4 |
    | 500&nbsp;ms | 5000 | 0b1001110001000 | 0x1388 |
    | 1&nbsp;sec | 10000 | 0b10011100010000 | 0x2710 |
    
2. See how to create a [synchronous operation](https://github.com/tomas-fryza/Digital-electronics-1/wiki/VHDL-cheat-sheet#processes) in the VHDL.

    ```vhdl
p_label : process (clk_i)
begin
    if rising_edge(clk_i) then      -- Rising clock edge
        if srst_i = '1' then        -- Synchronous reset (active high)
            <statements>
        else
            <statements>
        end if;
    end if;
end process p_label;
```
