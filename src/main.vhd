library ieee;
use ieee.std_logic_1164.all;

entity main is
	port (
		clk_50mhz: in std_logic;
		clk_32mhz: in std_logic;
		dip_switch: in std_logic_vector(7 downto 0);
		push_switch: in std_logic_vector(5 downto 0);
		
		led: out std_logic_vector(7 downto 0);
		audio: out std_logic_vector(1 downto 0);
		
		io_a: inout std_logic_vector(11 downto 0);
		io_b: inout std_logic_vector(11 downto 0);
		io_c: inout std_logic_vector(11 downto 0);
		io_d: inout std_logic_vector( 3 downto 0);
		io_e: inout std_logic_vector(11 downto 0);
		io_f: inout std_logic_vector(11 downto 0)

	);
end main;

architecture behavioral of main is

	signal clk, clk_generated: std_logic;

	component clock_generator
	port (
		clk_in: in std_logic;
		clk_out : out std_logic
	);
	end component;
	
	component clock_divider
	generic (
		n: integer
	);
	port (
		clk_in: in std_logic;
		clk_out : out std_logic
	);
	end component;
	
	component blink
	port (
		clk: in std_logic;
		led: out std_logic
	);
	end component;
	
begin

	led(7 downto 1) <= "0000000";
	audio <= "00";
		
	-- clocking
	clock_div: clock_divider generic map(n => 25) port map(clk_in => clk_50mhz, clk_out => clk);
	
	-- blink component
	blinkie: blink port map(clk => clk, led => led(0));

end behavioral;