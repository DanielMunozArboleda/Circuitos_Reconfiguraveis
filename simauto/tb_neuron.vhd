----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.03.2018 15:42:50
-- Design Name: 
-- Module Name: tb_filtroSobel3_3 - Behavioral
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

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2017 09:33:21
-- Design Name: 
-- Module Name: tb_sobel2 - Behavioral
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
use std.textio.all;
use IEEE.std_logic_textio.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;
use work.fpupack.all;

entity tb_neuron is
--  Port ( );
end tb_neuron;

architecture Behavioral of tb_neuron is

--FILE input_file  : text OPEN read_mode IS sim_file;
signal reset : std_logic := '0';
signal clk : std_logic := '0';
signal start : std_logic := '0';

signal x : t_mult := (others => (others =>'0'));
signal w : t_mult := (others => (others =>'0'));

signal x1 : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal x2 : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal x3 : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal x4 : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal w1 : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal w2 : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal w3 : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal w4 : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal bias : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');

signal neuronout : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal ready : std_logic := '0';
-- conter for WOMenable
 signal WOMenable : std_logic := '0';
-- signal cnt_ena : integer range 1 to 205 := 1;

--constant num_mult_neuronio : integer := 4;
--subtype saida_mult is std_logic_vector( FP_WIDTH-1 downto 0 );
--type t_mult  is array( 0 to num_mult_neuronio-1 ) of saida_mult;

component neuronio is
	Port ( clk : in STD_LOGIC;
			 reset : in STD_LOGIC;
          start : in STD_LOGIC;
          x 	 : in t_mult;
          w 	 : in t_mult;
          bias  : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
          saida : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
          ready : out STD_LOGIC);
end component;

signal first_start : std_logic := '0';
signal next_start : std_logic := '0';

-- enderecamento das memorias ROM e WOM
signal ROMaddress : std_logic_vector(7 downto 0) := (others=>'0');

begin
   
    -- reset generator
    reset <= '0', '1' after 15 ns, '0' after 25 ns;
    
    -- clock generator
    clk <= not clk after 5 ns; 
    
    -- cria o start 
    first_start <= '0', '1' after 55 ns, '0' after 65 ns; 
    
    -- sobel architecture intanciation                    
    uut: neuronio port map(
        reset     => reset,  
        clk       => clk,
        start     => start,
        x         => x,      
        w         => w,      
        bias      => bias, 
        saida	   => neuronout,
        ready     => ready);
	
	x(0) <= x1;
	x(1) <= x2;
	x(2) <= x3;
	x(3) <= x4;
	
	w(0) <= w1;
	w(1) <= w2;
	w(2) <= w3;
	w(3) <= w4;
	
    rom_x1: process
    file infile	: text is in "x1.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    x1 <= dataf;
                    start <= '1';
                else
                    start <= '0';
                end if;
                
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process;

    rom_x2: process
    file infile	: text is in "x2.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    x2 <= dataf;
                end if;
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process;
    
    rom_x3: process
    file infile    : text is in "x3.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    x3 <= dataf;
                end if;
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process; 
 
   rom_x4: process
    file infile    : text is in "x4.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    x4 <= dataf;
                end if;
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process;

   rom_w1: process
    file infile    : text is in "w1.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    w1 <= dataf;
                end if;
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process; 
	 
   rom_w2: process
    file infile    : text is in "w2.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    w2 <= dataf;
                end if;
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process; 

   rom_w3: process
    file infile    : text is in "w3.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    w3 <= dataf;
                end if;
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process; 
	 
   rom_w4: process
    file infile    : text is in "w4.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    w4 <= dataf;
                end if;
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process;

   rom_bias: process
    file infile    : text is in "bias.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    bias <= dataf;
                end if;
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process;
	 
    WOMenable <= ready;
    
    wom_n1 : process(clk) 
    variable out_line : line;
    file out_file     : text is out "res_neuron.txt";
    begin
        -- write line to file every clock
        if (rising_edge(clk)) then
            if WOMenable = '1' then
                write (out_line, neuronout);
                writeline (out_file, out_line);
            end if; 
        end if;  
    end process ;

end Behavioral;







