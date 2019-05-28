----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2019 09:40:33
-- Design Name: 
-- Module Name: RNA443 - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.fpupack.all;
use work.entities.all;

entity RNA443 is
    Port ( clk 	: in STD_LOGIC;
           reset 	: in STD_LOGIC;
           start 	: in STD_LOGIC;
           x 		: in t_input;
           saida 	: out t_output;
           ready 	: out STD_LOGIC);
end RNA443;

architecture Behavioral of RNA443 is

signal bias_h : t_input := (others => (others => '0'));
signal bias_o : t_output := (others => (others => '0'));

signal hneuron_out : t_input := (others => (others => '0'));
signal xo : t_input := (others => (others => '0'));
signal rdy_hneuron : t_rdyhneuron := (others => '0');
signal rdy_oneuron : t_rdyoneuron := (others => '0');

constant wih : t_wih := 
(("001111110000000000000000000","001111110000000000000000000","001111110000000000000000000","001111110000000000000000000"),
("001111110000000000000000000","001111110000000000000000000","001111110000000000000000000","001111110000000000000000000"),
("001111110000000000000000000","001111110000000000000000000","001111110000000000000000000","001111110000000000000000000"),
("001111110000000000000000000","001111110000000000000000000","001111110000000000000000000","001111110000000000000000000"));

constant who : t_who := 
(("001111101000000000000000000","001111101000000000000000000","001111101000000000000000000","001111101000000000000000000"),
("001111101000000000000000000","001111101000000000000000000","001111101000000000000000000","001111101000000000000000000"),
("001111101000000000000000000","001111101000000000000000000","001111101000000000000000000","001111101000000000000000000"));

begin

	hneuron_gen: for i in t_input'range generate
 		hneuron: neuronio port map(
 			reset 	 => reset,
 			clk	 	 => clk, 
 			start  	 => start,  
 			x	 	 	 => x,
 			w	 	 	 => wih(i),
 			bias	 	 => bias_h(i),
 			saida     => hneuron_out(i),
 			ready     => rdy_hneuron(i));
	end generate hneuron_gen;
	
	oneuron_gen: for i in t_output'range generate
 		oneuron: neuronio port map(
 			reset 	 => reset,
 			clk	 	 => clk,   
			start 	 => rdy_hneuron(0),
 			x	 	 	 => hneuron_out,
 			w	 	 	 => who(i),
 			bias	 	 => bias_o(i),
 			saida     => saida(i),
 			ready     => rdy_oneuron(i));
	end generate oneuron_gen;
 	
	process(clk,reset)
	begin
		if reset='1' then
			ready <= '0';
		elsif rising_edge(clk) then
			if rdy_oneuron(0) = '1' then
				ready <= '1';
			elsif start = '1' then
				ready <= '0';
			end if;
		end if;
	end process;
 	
end Behavioral;
