----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2019 09:02:18
-- Design Name: 
-- Module Name: neuronio - Behavioral
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

use work.fpupack.all;
use work.entities.all;

entity neuronio is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           start : in STD_LOGIC;
           x 	  : in t_input;
           w 	  : in t_input;
           bias  : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           saida : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           ready : out STD_LOGIC);
end neuronio;

architecture Behavioral of neuronio is

signal outmul : t_input := (others => (others=>'0'));
signal rdymul : std_logic_vector(num_inputs-1 downto 0) := (others=>'0');

signal outadd_0 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');
signal outadd_1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');
signal outadd_2 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');
signal outadd_3 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');

signal rdyadd_0 : std_logic := '0';
signal rdyadd_1 : std_logic := '0';
signal rdyadd_2 : std_logic := '0';
signal rdyadd_3 : std_logic := '0';


begin
   
	mult_gen: for i in outmul'range generate
		mul: multiplierfsm_v2 port map(
			reset 	 => reset,
			clk	 	 => clk,   
			op_a	 	 => x(i),
			op_b	 	 => w(i),
			start_i	 => start,
			mul_out   => outmul(i),
			ready_mul => rdymul(i));
	end generate mult_gen;

	add0: addsubfsm_v6 port map(
		reset 	 => reset,
		clk	 	 => clk,   
		op	 	    => '0',   
		op_a	 	 => outmul(0),
		op_b	 	 => outmul(1),
		start_i	 => rdymul(0),
		addsub_out   => outadd_0,
		ready_as	 => rdyadd_0);

	add1: addsubfsm_v6 port map(
		reset 	 => reset,
		clk	 	 => clk,   
		op	 	    => '0',   
		op_a	 	 => outmul(2),
		op_b	 	 => outmul(3),
		start_i	 => rdymul(0),
		addsub_out   => outadd_1,
		ready_as	 => rdyadd_1);

	add2: addsubfsm_v6 port map(
		reset 	 => reset,
		clk	 	 => clk,   
		op	 	    => '0',   
		op_a	 	 => outadd_0,
		op_b	 	 => outadd_1,
		start_i	 => rdyadd_0,
		addsub_out   => outadd_2,
		ready_as	 => rdyadd_2);

	add3: addsubfsm_v6 port map(
		reset 	 => reset,
		clk	 	 => clk,   
		op	 	    => '0',   
		op_a	 	 => outadd_2,
		op_b	 	 => bias,
		start_i	 => rdyadd_2,
		addsub_out   => outadd_3,
		ready_as	 => rdyadd_3);
	
	-- processo para realizar a saida linear
	process(clk,reset)
	begin
		if reset='1' then
			saida <= (others=>'0');
			ready <= '0';
		elsif rising_edge(clk) then
			ready <= '0';
			if rdyadd_3 = '1' then
				ready <= '1';
				if outadd_3(FP_WIDTH-1) = '1' then
					saida <= (others=>'0');
				elsif outadd_3 >= s_one then
					saida <= s_one;
				else
					saida <= outadd_3;
				end if;
			end if;
		end if;
	end process;
				
end Behavioral;







