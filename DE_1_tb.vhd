library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DE_1_tb is
end DE_1_tb;

architecture tb of DE_1_tb is

    component DE_1
        port ( L : in STD_LOGIC;
           R : in STD_LOGIC;
           CLK : in STD_LOGIC;
           L1 : out STD_LOGIC;
           L2 : out STD_LOGIC;
           L3 : out STD_LOGIC;
           R1 : out STD_LOGIC;
           R2 : out STD_LOGIC;
           R3 : out STD_LOGIC;
           count : buffer STD_LOGIC_VECTOR(1 downto 0)
           );
       end component;
       
   signal L : STD_LOGIC;
   signal R : STD_LOGIC;
   signal CLK : STD_LOGIC;
   signal L1 :  STD_LOGIC;
   signal L2 :  STD_LOGIC;
   signal L3 :  STD_LOGIC;
   signal R1 :  STD_LOGIC;
   signal R2 :  STD_LOGIC;
   signal R3 :  STD_LOGIC;
   signal count : STD_LOGIC_VECTOR(1 downto 0);
   
   constant clock_period: time := 20 ns;
   signal stop_the_clock: boolean;
   
   begin 
   dut: DE_1
   port map ( L => L,
        R => R,
        CLK => CLK,
        L1 => L1,
        L2 => L2,
        L3 => L3,
        R1 => R1,
        R2 => R2,
        R3 => R3,
        count => count);
        
    stimull: process
    begin
        L <= '0';
        R <= '0';
        wait for 80 ns;
        
        L <= '1';
        R <= '0';
        wait for 80 ns;
        
        L <= '0';
        R <= '1';
        wait for 80 ns;
        
        L <= '1';
        R <= '1';
        wait for 80 ns;
    end process;
        
  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;
        
end tb;

  