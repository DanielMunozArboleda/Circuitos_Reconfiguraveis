----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2018 15:47:28
-- Design Name: 
-- Module Name: pwm - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity pwm is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           duty : in STD_LOGIC_VECTOR (3 downto 0);
           saida : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is

signal aux : std_logic :='0';
signal count : std_logic_vector(20 downto 0) := (others=>'0');
signal preset : std_logic_vector(20 downto 0) := (others=>'0');
constant limit : std_logic_vector(20 downto 0) := "111101000010010000000"; -- 2000000

begin

with duty select
    preset <= "111001001110000111000" when "1111", -- 1875000 
              "110101011001111110000" when "1110",  
              "110001100101110101000" when "1101",  
              "101101110001101100000" when "1100",  
              "101001111101100011000" when "1011",  
              "100110001001011010000" when "1010",  
              "100010010101010001000" when "1001",  
              "011110100001001000000" when "1000", -- 1000000 
              "011010101100111111000" when "0111",  
              "010110111000110110000" when "0110",  
              "010011000100101101000" when "0101",  
              "001111010000100100000" when "0100", -- 500000 
              "001011011100011011000" when "0011",  
              "000111101000010010000" when "0010", -- 250000
              "000011110100001001000" when "0001", -- 125000
              "000000000000000000000" when "0000"; 
              
process(clk,reset)
begin
    if reset='1' then
        aux <= '0';
    elsif rising_edge(clk) then
        if count <= preset then
            aux <= '1';
        else
            aux <= '0';
        end if;
    end if;
end process;
saida <= aux;
process(clk,reset)
begin
    if reset='1' then
        count <= (others=>'0');
    elsif rising_edge(clk) then
        if count = limit then
            count <= (others=>'0');
        else
            count <= count + '1';
        end if;
    end if;
end process;

end Behavioral;
