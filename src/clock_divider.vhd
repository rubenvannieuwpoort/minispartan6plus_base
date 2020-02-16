library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_divider is
generic (
	n: integer
);
port (
	clk_in : in std_logic;
	clk_out : out std_logic
);
end clock_divider;

architecture behavioral of clock_divider is
	signal clk_count: std_logic_vector(n - 1 downto 0);
begin

	clk_out <= clk_count(n - 1);

	process (clk_in)
	begin
		if rising_edge(clk_in) then
			clk_count <= std_logic_vector(to_unsigned(to_integer(unsigned(clk_count)) + 1, n));
		end if;
	end process;

end Behavioral;