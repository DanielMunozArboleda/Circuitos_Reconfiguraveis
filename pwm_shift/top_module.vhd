----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2018 17:28:46
-- Design Name: 
-- Module Name: pwm_shiftreg - Behavioral
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

entity top_module is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR(3 downto 0);
           led : out STD_LOGIC_VECTOR(4 downto 0));
end top_module;

architecture Behavioral of top_module is
component pwm is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           duty : in STD_LOGIC_VECTOR(3 downto 0);
           saida : out STD_LOGIC);
end component;
component rModule_leds is
	Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           en : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal s_pwm : std_logic := '0';
signal en : std_logic := '0';
signal s_led : std_logic_vector(3 downto 0) := (others=>'0');
signal count : std_logic_vector(24 downto 0) := (others=>'0');

begin


pwm_inst: pwm port map(
	clk => clk,
    reset => reset,
    duty => sw,
    saida => s_pwm);

sll_inst : rModule_leds port map(
	clk => clk,
    reset => reset,
    en => en,
    led => s_led);

process(clk,reset)
begin
    if reset='1' then
        count <= (others=>'0');
    elsif rising_edge(clk) then
		if count = "1111111111111111111111111" then
			en <= '1';
			count <= (others=>'0');
        else
            en <= '0';
			count <= count + '1';
        end if;
    end if;
end process;

led <= s_pwm & s_led;

end Behavioral;
