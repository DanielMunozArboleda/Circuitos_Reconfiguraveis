-------------------------------------------------
-- Company:       GRACO-UnB
-- Engineer:      DANIEL MAURICIO MUÑOZ ARBOLEDA
-- 
-- Create Date:   27-Apr-2015 
-- Design name:   addsub 
-- Module name:   addsub - behavioral
-- Description:   addition subtraction in floating-point
-- Automatically generated using the vFPUgen.m v1.0
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.fpupack.all;

entity addsubfsm_v6 is
	port (reset     :  in std_logic;
		 clk        :  in std_logic;
		 op			:  in std_logic;
		 op_a 		:  in std_logic_vector(FP_WIDTH-1 downto 0);
		 op_b 		:  in std_logic_vector(FP_WIDTH-1 downto 0);
		 start_i    :  in std_logic;
		 addsub_out : out std_logic_vector(FP_WIDTH-1 downto 0);
		 ready_as   : out std_logic);
end addsubfsm_v6;

architecture Behavioral of addsubfsm_v6 is

	signal comp_ab  : std_logic := '0';
	signal comp_eq  : std_logic := '0';
	signal compe_ab : std_logic := '0';
	signal compe_eq : std_logic := '0';

	signal sA  	  	 : std_logic := '0';
	signal auxor	 : std_logic_vector(2 downto 0) := "000";
	signal oper	  	 : std_logic := '0';
	signal s_sign	 : std_logic := '0';

   signal s_exp    : std_logic_vector(EXP_WIDTH-1 downto 0) := (others => '0');
	signal s_opa    : std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
	signal s_opb    : std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
   signal res_man  : std_logic_vector(FRAC_WIDTH+1 downto 0) := (others => '0');
   signal s_res_man: std_logic_vector(FRAC_WIDTH+1 downto 0) := (others => '0');

   signal update   : std_logic;
   type   t_state is (waiting,addsub,output);
   signal state,pr_state : t_state;

begin

-- processo para comparar expoentes
process(op_a,op_b)
begin
	if op_a(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH) > op_b(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH) then
		compe_ab <= '1';
		s_exp    <= op_a(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH);
	else
		compe_ab <= '0';
		s_exp    <= op_b(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH);
	end if;
end process;

-- processo de igualdade de expoentes
process(op_a,op_b)
begin
	if op_a(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH) = op_b(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH) then
		compe_eq <= '1';
	else
		compe_eq <= '0';
	end if;
end process;

-- processo para comparar magnitude dos numeros
process(op_a,op_b)
begin
	if op_a(FRAC_WIDTH+EXP_WIDTH-1 downto 0) > op_b(FRAC_WIDTH+EXP_WIDTH-1 downto 0) then
		comp_ab <= '1';
	else
		comp_ab <= '0';
	end if;
end process;

-- processo de igualdade dos numeros
process(op_a,op_b,compe_eq)
begin
	if op_a(FRAC_WIDTH-1 downto 0) = op_b(FRAC_WIDTH-1 downto 0) then
		if compe_eq = '1' then
			comp_eq <= '1';
		else
			comp_eq <= '0';
		end if;
	else
		comp_eq <= '0';
	end if;
end process;

sA   <= op_a(FRAC_WIDTH+EXP_WIDTH);
--oper    <= (op xor (op_a(FP_WIDTH-1) xor op_b(FP_WIDTH-1)));
auxor <= op&op_a(FP_WIDTH-1)&op_b(FP_WIDTH-1);
with auxor select
	oper <= '0' when "000",
			'1' when "001",
			'1' when "010",
			'0' when "011",
			'1' when "100",
			'0' when "101",
			'0' when "110",
			'1' when others;

-- processo para calcular signo
process(reset,clk)
variable sl : std_logic := '0';
begin
	if rising_edge(clk) then
       if reset ='1' then
           s_sign <= '0';
           sl := '0';
       else
           sl   := (op_a(FP_WIDTH-1) xor op_b(FP_WIDTH-1));
           if    (op='0' and sl='0' and sA='0' and comp_ab='0') then s_sign<='0';
           elsif (op='0' and sl='0' and sA='0' and comp_ab='1') then s_sign<='0';
           elsif (op='0' and sl='0' and sA='1' and comp_ab='0') then s_sign<='1';
           elsif (op='0' and sl='0' and sA='1' and comp_ab='1') then s_sign<='1';
           elsif (op='0' and sl='1' and sA='0' and comp_ab='0') then s_sign<='1';
           elsif (op='0' and sl='1' and sA='0' and comp_ab='1') then s_sign<='0';
           elsif (op='0' and sl='1' and sA='1' and comp_ab='0') then s_sign<='0';
           elsif (op='0' and sl='1' and sA='1' and comp_ab='1') then s_sign<='1';
           elsif (op='1' and sl='0' and sA='0' and comp_ab='0') then s_sign<='1';
           elsif (op='1' and sl='0' and sA='0' and comp_ab='1') then s_sign<='0';
           elsif (op='1' and sl='0' and sA='1' and comp_ab='0') then s_sign<='0';
           elsif (op='1' and sl='0' and sA='1' and comp_ab='1') then s_sign<='1';
           elsif (op='1' and sl='1' and sA='0' and comp_ab='0') then s_sign<='0';
           elsif (op='1' and sl='1' and sA='0' and comp_ab='1') then s_sign<='0';
           elsif (op='1' and sl='1' and sA='1' and comp_ab='0') then s_sign<='1';
           elsif (op='1' and sl='1' and sA='1' and comp_ab='1') then s_sign<='1';
           else s_sign<='0';
           end if;
       end if;
	end if;
end process;

-- processo para calcular alineamento das mantisas segundo diferencia de expoentes
process(op_a,op_b,compe_eq,compe_ab)
variable sub_exp : integer range 0 to int_alin := 0;
begin
	if compe_eq='1' then 
       sub_exp := 0;
		if op_a(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH) = 0 then -- exception when 0+0 or 0-0
			s_opa   <= '0'&op_a(FRAC_WIDTH-1 downto 0);
			s_opb   <= '0'&op_b(FRAC_WIDTH-1 downto 0);
		else
			s_opa   <= '1'&op_a(FRAC_WIDTH-1 downto 0);
			s_opb   <= '1'&op_b(FRAC_WIDTH-1 downto 0);
		end if;
	elsif compe_ab='1' then
		sub_exp := conv_integer(op_a(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH) - (op_b(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH)));
		s_opa   <= '1'&op_a(FRAC_WIDTH-1 downto 0);
		s_opb   <= to_stdlogicvector(to_bitvector('1'&op_b(FRAC_WIDTH-1 downto 0)) srl sub_exp);
	else
		sub_exp := conv_integer(op_b(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH) - (op_a(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH)));
		s_opb   <= '1'&op_b(FRAC_WIDTH-1 downto 0);
		s_opa   <= to_stdlogicvector(to_bitvector('1'&op_a(FRAC_WIDTH-1 downto 0)) srl sub_exp);
	end if;
end process;

-- processo para somar ou substrair as mantissas
process(s_opa,s_opb,oper,comp_ab)
begin
   if oper='0' then
       s_res_man <= '0'&s_opa+s_opb;
   elsif comp_ab='1' then
       s_res_man <= '0'&s_opa-s_opb;
   else
       s_res_man <= '0'&s_opb-s_opa;
   end if;
end process;

-- registro intermediario
process(reset,clk)
begin
	if rising_edge(clk) then
       if reset='1' then
           res_man<=(others=>'0');
       else
           res_man<=s_res_man;
       end if;
	end if;
end process;

-- processo para normalizar resultado da mantisa quando necessario
process(clk,reset)
variable pos : integer range 0 to FRAC_WIDTH := 0;
variable sign : std_logic := '0';
variable s_res_exp: std_logic_vector(EXP_WIDTH-1 downto 0) := (others => '0');
variable out_man  : std_logic_vector(FRAC_WIDTH-1 downto 0) := (others => '0');
begin
	if rising_edge(clk) then
       if reset ='1' then
           sign := '0';
           s_res_exp := (others=>'0');
           out_man   := (others=>'0');
           addsub_out<= (others=>'0');
       else
           if update = '1' then
               if oper='0' and res_man(FRAC_WIDTH+1)='1' then 
                   sign := s_sign;
                   s_res_exp := s_exp+'1';
                   out_man   := res_man(FRAC_WIDTH downto 1);
               else
                   if comp_eq='1' and oper='0' then
                       sign      := s_sign;
                       s_res_exp := op_a(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH);
                       out_man   := op_a(FRAC_WIDTH-1 downto 0);
                   elsif comp_eq='1' and oper='1' then
                       sign      := '0';
                       s_res_exp := (others => '0');
                       out_man   := (others => '0');
                   elsif res_man(FRAC_WIDTH)='1' then 
                       sign      := s_sign;
                       s_res_exp := s_exp;
                       out_man   := res_man(FRAC_WIDTH-1 downto 0);
                   else
                       sign := s_sign;
                       for i in 1 to FRAC_WIDTH loop
                           pos := i;
                           exit when res_man(FRAC_WIDTH-i) = '1';
                       end loop;
                       s_res_exp := s_exp-CONV_STD_LOGIC_VECTOR(pos,EXP_WIDTH);
                       out_man   := to_stdlogicvector(to_bitvector(res_man(FRAC_WIDTH-1 downto 0)) sll pos);
                   end if;
               end if;
               addsub_out(FRAC_WIDTH+EXP_WIDTH) <= sign;
               addsub_out(FRAC_WIDTH+EXP_WIDTH-1 downto FRAC_WIDTH) <= s_res_exp(EXP_WIDTH-1 downto 0);
               addsub_out(FRAC_WIDTH-1 downto 0)  <= out_man;
           end if;
       end if;
	end if;
end process;

-- processo para actualizar estado
actualiza: process(clk,reset)
begin
	if rising_edge(clk) then
       if reset ='1' then
           state <= waiting;
       else
           state <= pr_state;
       end if;
	end if;
end process;

-- processo principal: FSM
principal: process(state,start_i)
begin
	case state is 
		when waiting =>
			ready_as  <= '0';
			update    <= '0';
			if start_i='1' then
				pr_state <= addsub;
			else
				pr_state <= waiting;
			end if;
		when addsub =>
			ready_as  <= '0';
			update    <= '1';
			pr_state  <= output;
		when output => 
			ready_as  <= '1';
			update    <= '0';
			pr_state  <= waiting;
		when others =>
			ready_as  <= '0';
			update    <= '0';
			pr_state  <= waiting;
	end case;
end process;

end Behavioral;
