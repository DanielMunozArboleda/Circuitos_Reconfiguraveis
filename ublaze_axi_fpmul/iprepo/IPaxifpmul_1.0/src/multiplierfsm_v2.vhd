----------------------------------------------------------------------------------
-- Company: 		 GRACO
-- Engineer: 		 Daniel Mauricio Muñoz
-- 
-- Create Date:    11:20:25 03/25/2011 
-- Design Name: 
-- Module Name:    miltiplierfsm_v2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.fpupack.all;

entity multiplierfsm_v2 is
    port (reset 	 :  in std_logic; 
	       clk	 	 :  in std_logic;          
	 		 op_a	 	 :  in std_logic_vector(FP_WIDTH-1 downto 0);
          op_b	 	 :  in std_logic_vector(FP_WIDTH-1 downto 0);
			 start_i	 :  in std_logic;
          mul_out  : out std_logic_vector(FP_WIDTH-1 downto 0);
			 ready_mul: out std_logic);
end multiplierfsm_v2;

architecture Behavioral of multiplierfsm_v2 is
	signal s_add_exp : std_logic_vector(EXP_WIDTH downto 0);
	signal s_mul_out : std_logic_vector(FP_WIDTH-1 downto 0) := (others => '0');
	signal s_mul_man : std_logic_vector((FRAC_WIDTH*2)+1 downto 0);
	signal update    : std_logic;
	type   t_state is (waiting,postmul,exception);
	signal state,pr_state : t_state;

begin

	process(clk,reset)
	begin
		if rising_edge(clk) then
			if reset ='1' then
				state     <= waiting;
				mul_out   <= (others => '0');
				ready_mul <= '0';
			else
				state     <= pr_state;
				ready_mul <= '0';
				if update = '1' then
					mul_out   <= s_mul_out;
					ready_mul <= '1';
				end if;
			end if;
		end if;
	end process;

	process(op_a,op_b,start_i,state)
		variable v_add_exp : std_logic_vector(EXP_WIDTH downto 0);
		variable s_exponen : std_logic_vector(EXP_WIDTH-1 downto 0);
		variable s_mantisa : std_logic_vector(FRAC_WIDTH-1 downto 0);
	begin
		update    <= '0';
		case state is 
			when waiting =>
				s_exponen := (others => '0');
				s_mantisa := (others => '0');
				v_add_exp := (others => '0');
				s_mul_out <= (others => '0');			
				if start_i = '1' then
					if op_a(FP_WIDTH-2 downto 0) = 0 or op_b(FP_WIDTH-2 downto 0) = 0 then --(others => '0') or op_b = (others => '0') then
						update    <= '0';
						pr_state  <= exception;
					else 
						update    <= '0';
						pr_state  <= postmul;
					end if;
				else
					update    <= '0';
					pr_state  <= waiting;
				end if;

			when postmul =>
				if s_mul_man((FRAC_WIDTH*2)+1) = '1' then
					v_add_exp := s_add_exp + '1';
					s_mantisa := s_mul_man(FRAC_WIDTH*2 downto FRAC_WIDTH+1);
				else
					v_add_exp := s_add_exp;
					s_mantisa := s_mul_man((FRAC_WIDTH*2)-1 downto FRAC_WIDTH);
				end if;

				if s_add_exp(EXP_WIDTH) = '1' or s_add_exp(EXP_WIDTH-1 downto 0) = EXP_ONE or op_a(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH) = EXP_ONE or op_b(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH) = EXP_ONE then  -- infinite
					v_add_exp(EXP_WIDTH-1 downto 0) := (others => '1'); --"11111111";
					s_mantisa := (others => '0'); --"00000000000000000000000";  -- (others => '0');
				end if;
				s_exponen := v_add_exp(EXP_WIDTH-1 downto 0);						
				s_mul_out(FP_WIDTH-1) <= op_a(FP_WIDTH-1) XOR op_b(FP_WIDTH-1);
				s_mul_out(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH) <= s_exponen;
				s_mul_out(FRAC_WIDTH-1 downto 0) <= s_mantisa; 
				update    <= '1';
				pr_state <= waiting;

			when exception =>
				s_exponen := (others => '0');
				s_mantisa := (others => '0');
				v_add_exp := (others => '0');
				s_mul_out <= (others => '0');
				update    <= '1';
				pr_state  <= waiting;
				
			when others =>
				s_exponen := (others => '0');
				s_mantisa := (others => '0');
				v_add_exp := (others => '0');
				s_mul_out <= (others => '0');
				update    <= '0';
				pr_state  <= waiting;			

		end case;						
	end process;

--	s_mul_man <= op_a(FRAC_WIDTH-1 downto 0) * op_b(FRAC_WIDTH-1 downto 0);
	s_mul_man <= ('1'&op_a(FRAC_WIDTH-1 downto 0)) * ('1' & op_b(FRAC_WIDTH-1 downto 0));
	s_add_exp <= ('0'&op_a(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH))+('0'&op_b(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH))-bias;
end Behavioral;
