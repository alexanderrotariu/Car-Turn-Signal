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
end DE_1;



architecture Behavioral of DE_1 is

begin 
    process(L,R, CLK)
    begin
    
        if(L'event or R'event) then
            count <= "00";
        end if;
        
       if(CLK = '1' and CLK'event) then
       
            if(L = '0' and R = '0') then
                L1 <= '0';
                L2 <= '0';
                L3 <= '0';
                R1 <= '0';
                R2 <= '0';
                R3 <= '0';
                count <= "00";
            
            elsif(L = '1' and R = '0') then
                if(count = "00") then
                    L1 <= '1';
                    count <= "01";
                elsif(count = "01") then
                    L2 <= '1';
                    count <= "10";
                elsif(count = "10") then
                    L3 <= '1';
                    count <= "11";
                elsif(count = "11") then
                    L1 <= '0';
                    L2 <= '0';
                    L3 <= '0';
                    count <= "00";
                end if;
                    
            elsif(L = '0' and R = '1') then
                if(count = "00") then
                    R1 <= '1';
                    count <= "01";
                elsif(count = "01") then
                    R2 <= '1';
                    count <= "10";
                elsif(count = "10") then
                    R3 <= '1';
                    count <= "11";
                elsif(count = "11") then
                    R1 <= '0';
                    R2 <= '0';
                    R3 <= '0';
                    count <= "00";
                end if;
                
            elsif(L = '1' and R = '1') then
                L1 <= '1';
                L2 <= '1';
                L3 <= '1';
                R1 <= '1';
                R2 <= '1';
                R3 <= '1';
                    
            end if;    
        end if;
        
    end process;
end Behavioral;

