----------------------------------------------------------------------------------
-- ECE 431 Reconfigurable Computing
-- Engineer: Alexander Rotariu
-- 
-- Create Date: 02/22/2022 10:47:00 AM
-- Design Name: Car Headlight Model 
-- Module Name: DE_1 - Behavioral
-- Project Name: Design_Exercise_1
-- Target Devices: BASYS 3 DIGILENT 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DE_1 is
    port ( L : in STD_LOGIC; --SW 5 
           R : in STD_LOGIC; --SW 10
           clk : inout STD_LOGIC := '0'; --inout for sim, in for basys
           L1 : out STD_LOGIC := '0'; --LED 13
           L2 : out STD_LOGIC := '0'; --LED 14
           L3 : out STD_LOGIC := '0'; --LED 15
           R1 : out STD_LOGIC := '0'; --LED 0 
           R2 : out STD_LOGIC := '0'; --LED 1
           R3 : out STD_LOGIC := '0'  --LED 2
           );
  
end DE_1;

architecture Behavioral of DE_1 is

type state is (S0, S1, S2, S3);
signal currentState : state; --setting the initial state to S0
signal nextState : state := S0;
--STATE DEFINITIONS:
           -- "S0" --> ALL LIGHTS OFF
           -- "S1" --> 1 LIGHT ON
           -- "S2" --> 2 LIGHTS ON
           -- "S3" --> ALL LIGHTS ON

signal slowClk: STD_LOGIC;  --slowClk signal to be used later

signal clk_signal : std_logic := '0';
constant clk_cycle: time := 20ns;

begin 




--SLOW CLOCK
--SENS LIST(MAIN CLOCK)

--COUNTER OUPUT OF SLOWCLOCK
--INITIALIZE AS 0
--START COUNTING CLOCK CYCLES 
--EVERY RISING EDGE COUNT
--HITS A HIGH THRESHOLD (UPWARDS OF 1 MIL)
--ONCE IT HITS RESET

--Slow Clock, Framework given by Professor Moulic of SUNY Albany
--slow_clock : process (clk) is 

-- slow clock signal will be updated based on the clock input
-- slow clock is essentailly what we will be using to drive our state transitions on the board.
    --count is our counter used for sloweing down the 100Mhz clock from the basys 3 board
--    variable count: integer range 0 to 15000000; 
--        begin
        --Detecting rising edge
--            if( clk = '1' and clk'event) then
            --once it hits our counter limit, update our slower clock to 1
--                if (count = 15000000) then
--                    count := 0;
--                    slowClk <= '1';
                --if we didnt hit our upper limit, keep incrementing counter
--                else 
--                    count := count + 1;
--                    slowClk <= '0';
--                 end if;
--             end if;
-- end process slow_clock;

                    
--Clock Process
--      this clock was used for simulation
--      using slow clock for simulation didnt achieve desired results
-- USE SLOW CLOCK FOR WHEN PUSHING DESIGN TO BOARD
-- USE SIMCLOCK WHEN USING
 
simclock: process(clk)
    begin
    clk <= not clk after clk_cycle/2;
end process;

--mealy_machine will be driven by the slow clock
--sens list: change in the slow clock, left input or right input
--mealy_machine: process(slowClk, L, R) -- USE THIS FOR SLOW CLOCK (BASYS)
mealy_machine: process(clk, L, R) -- USE THIS FOR NORMAL CLOCK (SIMULATION)
    begin
    currentState <= nextState;     --UPDATE OUR CURRENT STATE ACCORINGLY (DEFAULT S0)

    --ONCE WE HIT A RISING EDGE ON THE SLOW CLOCK
    --FIND WHICH STATE WE ARE IN, THE OUTPUTS OF THAT STATE, AND 
    --WHAT STATE WE WILL BE IN NEXT CLOCK CYCLE
    
  --if(slowClk ='1' and slowClk'event) then -- USE THIS FOR SLOW CLOCK (BASYS)
  if(clk = '1' and clk'event) then -- USE THIS FOR NORMAL CLOCK (SIMULATION)
        case currentState is
            when S0 => -- NO LIGHTS
                if(L ='0' and R='0') then
                    L1 <= '0'; L2 <= '0'; L3 <= '0'; 
                    R1 <= '0'; R2 <= '0'; R3 <= '0';
                    nextState <= S0;
                elsif(L='1' and R='0') then
                    L1 <= '1'; L2 <= '0'; L3 <= '0'; 
                    R1 <= '0'; R2 <= '0'; R3 <= '0';
                    nextState <= S1;
                elsif(L='0' and R='1') then 
                    L1 <= '0'; L2 <= '0'; L3 <= '0'; 
                    R1 <= '1'; R2 <= '0'; R3 <= '0';
                    nextState <= S1;
                elsif(L ='1' and R='1') then
                    L1 <= '1'; L2 <= '1'; L3 <= '1'; 
                    R1 <= '1'; R2 <= '1'; R3 <= '1';
                    nextState <= S3;
                end if;
                            
            when S1 =>  
                
                if(L ='0' and R='0') then
                    L1 <= '0'; L2 <= '0'; L3 <= '0';
                    R1 <= '0'; R2 <= '0'; R3 <= '0';
                    nextState <= S0;
                elsif(L='1' and R='0') then
                    L1 <= '1'; L2 <= '1'; L3 <= '0'; 
                    R1 <= '0'; R2 <= '0'; R3 <= '0';
                    nextState <= S2;
                elsif(L='0' and R='1') then 
                    L1 <= '0'; L2 <= '0'; L3 <= '0'; 
                    R1 <= '1'; R2 <= '1'; R3 <= '0';
                    nextState <= S2;
                elsif(L ='1' and R='1') then
                    L1 <= '1'; L2 <= '1'; L3 <= '1'; 
                    R1 <= '1'; R2 <= '1'; R3 <= '1';
                    nextState <= S3;
                end if;
                
            when S2 => -- 2 LIGHTS ARE ON FROM LEFT OR RIGHT
                
                if(L ='0' and R='0') then
                    L1 <= '0'; L2 <= '0'; L3 <= '0'; 
                    R1 <= '0'; R2 <= '0'; R3 <= '0';
                    nextState <= S0;
                elsif(L='1' and R='0') then
                    L1 <= '1'; L2 <= '1'; L3 <= '1'; 
                    R1 <= '0'; R2 <= '0'; R3 <= '0';
                    nextState <= S3;
                elsif(L='0' and R='1') then 
                    L1 <= '0'; L2 <= '0'; L3 <= '0'; 
                    R1 <= '1'; R2 <= '1'; R3 <= '1';
                    nextState <= S3;
                elsif(L ='1' and R='1') then
                    L1 <= '1'; L2 <= '1'; L3 <= '1'; 
                    R1 <= '1'; R2 <= '1'; R3 <= '1';
                    nextState <= S3;
                end if;
                
            when S3 => --ALL LIGHTS ARE ON, OR 3 FROM LEFT OR RIGHT ON
            
                if(L ='0' and R='0') then
                    L1 <= '0'; L2 <= '0'; L3 <= '0'; 
                    R1 <= '0'; R2 <= '0'; R3 <= '0';
                    nextState <= S0;
                elsif(L='1' and R='0') then
                    L1 <= '0'; L2 <= '0'; L3 <= '0'; 
                    R1 <= '0'; R2 <= '0'; R3 <= '0';
                    nextState <= S0;
                elsif(L='0' and R='1') then 
                    L1 <= '0'; L2 <= '0'; L3 <= '0'; 
                    R1 <= '0'; R2 <= '0'; R3 <= '0';
                    nextState <= S0;
                elsif(L ='1' and R='1') then
                    L1 <= '1'; L2 <= '1'; L3 <= '1'; 
                    R1 <= '1'; R2 <= '1'; R3 <= '1';
                    nextState <= S3;
                end if;
                
            end case;
                    
    end if;        
end process;
    
    
   
end Behavioral;

