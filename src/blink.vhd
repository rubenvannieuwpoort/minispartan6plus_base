library ieee;
use ieee.std_logic_1164.ALL;

entity blink is port (
		clk: in std_logic;
		led: out std_logic := '0'
	);
end blink;

architecture behavioral of blink is
	signal led_status: std_logic;
begin

	led <= led_status;

	process (clk)
	begin
		if rising_edge(clk) then
			led_status <= not(led_status);
		end if;
	end process;
	
end behavioral;

