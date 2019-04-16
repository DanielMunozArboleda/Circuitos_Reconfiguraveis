-------------------------------------------------
-- Company:       GRACO-UnB
-- Engineer:      DANIEL MAURICIO MUÑOZ ARBOLEDA
-- 
-- Create Date:   04-Sep-2012 
-- Design name:   divNR 
-- Module name:   divNR - behavioral
-- Description:   floating-point division using Newton-Raphson
-- Automatically generated using the vFPUgen.m v1.0
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.fpupack.all;
use work.entities.all;

entity divNR is
	port (reset      :  in std_logic;
		  clk        :  in std_logic;
		  op_a 		 :  in std_logic_vector(FP_WIDTH-1 downto 0);
		  op_b 		 :  in std_logic_vector(FP_WIDTH-1 downto 0);
		  start_i    :  in std_logic;
		  div_out    : out std_logic_vector(FP_WIDTH-1 downto 0);
		  ready_div  : out std_logic);
end divNR;

architecture Behavioral of divNR is

type RAM is array(FRAC_WIDTH-2 downto 0) of std_logic;
type RRAM is array(TSed downto 0) of RAM;
signal MEM : RRAM := ("0000011101010000011101",--1
                      "0000111100001111000011",--2
                      "0001011101000101110100",--3
                      "0001111111111111111111",--4
                      "0010100101001010010100",--5
                      "0011001100110011001100",--6
                      "0011110111001011000010",--7
                      "0100100100100100100100",--8
                      "0101010101010101010101",--9
                      "0110001001110110001001",--10
                      "0111000010100011110101",--11
                      "0111111111111111111111",--12
                      "1001000010110010000101",--13
                      "1010001011101000101110",--14
                      "1011011011011011011011",--15
                      "1110010100001101011110");--16

signal SgnNumer	: std_logic := '0';
signal ExpNumer	: std_logic_vector(EXP_WIDTH-1 downto 0) := (others => '0');
signal MntNumer	: std_logic_vector(FRAC_WIDTH downto 0)  := (others => '0');
signal SgnDnmnd	: std_logic := '0';
signal ExpDnmnd	: std_logic_vector(EXP_WIDTH-1 downto 0) := (others => '0');
signal MntDnmnd	: std_logic_vector(FRAC_WIDTH downto 0)  := (others => '0');
signal MntResul	: std_logic_vector(FRAC_WIDTH downto 0)  := (others => '0');
signal Expoente	: std_logic_vector(EXP_WIDTH-1 downto 0) := (others => '0');
signal CpiaResul	: std_logic_vector(FP_WIDTH-1 downto 0)  := (others => '0');
signal CalDiv		: std_logic := '0';
signal FinDiv		: std_logic := '0';
signal SAddr     	: integer range 0 TO TSed;
signal SDOut     	: std_logic_vector(FRAC_WIDTH-2 downto 0);
signal Ea        	: std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
signal opA_mul		: std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
signal opB_mul		: std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
signal out_mul		: std_logic_vector(FRAC_WIDTH*2+1 downto 0) := (others => '0');
signal start_mul	: std_logic := '0';

type State_Type is (Start,NewtonRaphson,Result,ResultEc);
signal State : State_Type := Start;

type   t_state is (waiting,selseed,mul1,compl);
signal pr_state, nx_state : t_state := waiting;

begin

process(op_b)
begin
	if op_b(FRAC_WIDTH-1 downto 0) <= "01100011100011100011100" then
       if op_b(FRAC_WIDTH-1 downto 0) <= "00001110001110001110001" then SAddr <= 0;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "00011100011100011100011" then SAddr <= 1;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "00101010101010101010101" then SAddr <= 2;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "00111000111000111000111" then SAddr <= 3;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "01000111000111000111001" then SAddr <= 4;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "01010101010101010101010" then SAddr <= 5;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "01100011100011100011100" then SAddr <= 6;
		else SAddr <= 7;
		end if;
	else
       if op_b(FRAC_WIDTH-1 downto 0) <= "01110001110001110001110" then SAddr <= 8;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "10000000000000000000000" then SAddr <= 9;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "10001110001110001110010" then SAddr <= 10;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "10011100011100011100011" then SAddr <= 11;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "10101010101010101010101" then SAddr <= 12;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "10111000111000111000111" then SAddr <= 13;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "11000111000111000111001" then SAddr <= 14;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "11010101010101010101011" then SAddr <= 15;
		else SAddr <= 15;
		end if;
	end if;
end process;

Expoente <= ExpNumer - ExpDnmnd + bias;

SgnNumer <= op_a(FP_WIDTH-1);
SgnDnmnd <= op_b(FP_WIDTH-1);
ExpNumer <= op_a(FP_WIDTH-2 downto FRAC_WIDTH);
ExpDnmnd <= op_b(FP_WIDTH-2 downto FRAC_WIDTH);
MntNumer <= ('1' & op_a(FRAC_WIDTH-1 downto 0));
MntDnmnd <= ('1' & op_b(FRAC_WIDTH-1 downto 0));

FMul1 : fixMul
port map (op_a    => opA_mul,
			 op_b    => opB_mul,
			 mul_out => out_mul);

process(reset,clk)
variable P		: std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
variable Vax 	: std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
variable cont  : integer range 0 to Niter;
begin
	if rising_edge(clk)	then
		if reset='1' then
			nx_state <= waiting;
			P			:= (others => '0');
			Vax		:= (others => '0');
			Ea 		<= (others => '0');
			opA_mul  <= (others => '0');
			opB_mul  <= (others => '0');
			cont     := 0;
			FinDiv	<= '0';
		else
			case nx_state is
				when waiting =>
					P		:= (others => '0');
					Vax		:= (others => '0');
					FinDiv	<= '0';
					cont     := 0;
					SDOut <= std_logic_vector((MEM(SAddr)));
					if CalDiv = '1' then
						nx_state <= selseed;
					else
						nx_state <= waiting;
					end if;

				when selseed =>
					Ea 		<= ("01" & SDOut);
					opA_mul  <= MntDnmnd;
					opB_mul  <= ("01" & SDOut);
					nx_state <= mul1;

				when mul1 =>
					P  		:= out_mul(FRAC_WIDTH*2 downto FRAC_WIDTH);
					Vax 		:= not(P) + '1';
					opA_mul  <= Ea;
					opB_mul  <= Vax;
					FinDiv	<= '0';
					nx_state <= compl;

				when compl =>
					Ea 		<= out_mul(FRAC_WIDTH*2 downto FRAC_WIDTH);
					cont     := cont + 1;
					if cont = Niter then
						opA_mul  <= MntNumer;
						opB_mul  <= out_mul(FRAC_WIDTH*2 downto FRAC_WIDTH);
						FinDiv   <= '1';
						nx_state <= waiting;
					else
						opA_mul  <= MntDnmnd;
						opB_mul  <= out_mul(FRAC_WIDTH*2 downto FRAC_WIDTH);
						FinDiv   <= '0';
						nx_state <= mul1;
					end if;

				when others =>
					nx_state <= waiting;
			end case;
		end if;
	end if;
end process;

CntrlGral: process(clk,reset)
variable ExpoenteR	: std_logic_vector(EXP_WIDTH -1  downto 0) := (others => '0');
begin
	if rising_edge(clk) then
		if reset = '1' then
			State	<= Start;
			CalDiv	<= '0';
			ExpoenteR	:= (others => '0');
			CpiaResul	<= (others => '0');
			MntResul		<= (others => '0');
		else
 			case State is
 				when Start=>
 					if start_i = '1' then
 						if op_a = Zero AND op_b = Zero then
 							CpiaResul <= Inf; --Infinito Positivo
 							State <= ResultEc;
 							CalDiv <= '0';
 						elsif op_a = op_b then
 							CpiaResul <= s_one;
 							State <= ResultEc;
 							CalDiv <= '0';
 						elsif op_a = Zero then
 							CpiaResul <= Zero;
 							State <= ResultEc;
 							CalDiv <= '0';
 						elsif op_b = Zero then
 							CpiaResul <= Inf; --Infinito Positivo
 							State <= ResultEc;
 							CalDiv <= '0';
						elsif op_a(FRAC_WIDTH-1 downto 0) = op_b(FRAC_WIDTH-1 downto 0) then
 							MntResul <= OneM;
 							State <= Result;
 							CalDiv <= '0';
 						else
 							State <= NewtonRaphson;
 							CalDiv <= '1';
 						end if;
					else
					   CalDiv <= '0';
					   State	<= Start;
                  ready_div <= '0';
 					end if;

 				when NewtonRaphson=>
					CalDiv <= '0';
 					if FinDiv = '1' then
						MntResul <= out_mul(FRAC_WIDTH*2 downto FRAC_WIDTH);
						State <= Result;
 					end if;
 					ready_div <= '0';

 				when Result=>
 					CpiaResul(FP_WIDTH-1) <= SgnNumer XOR SgnDnmnd;
 					if MntResul(FRAC_WIDTH) = '0' then
 						ExpoenteR := Expoente - 1;
 						CpiaResul(FRAC_WIDTH-1 downto 0) <= (MntResul(FRAC_WIDTH-2 downto 0) & '0');
 					else
 						ExpoenteR := Expoente;
 						CpiaResul(FRAC_WIDTH-1 downto 0) <= MntResul(FRAC_WIDTH-1 downto 0);
 					end if;
 					CpiaResul(FP_WIDTH-2 downto FRAC_WIDTH) <= ExpoenteR;
 					ready_div <= '1';
 					State <= Start;

 				when ResultEc=>
 					ready_div <= '1';
 					State <= Start;

				when others => null;
 			end case;
		end if;
	end if;
end process;

div_out <= CpiaResul;

end Behavioral;
