# machine a etat fini[code en VHDL]

Une machine à état finis est une machine séquentielle algorithmique caractérisée par un vecteur d’entrées,
un vecteur de sorties, et une séquence d’états définissant son comportement. La machine (également appelée
automate) va passer d’un état à l’autre suivant les séquences d’entrée qu’elle reçoit. On attribue généralement
à la machine un état de départ lui permettant de débuter son fonctionnement à partir d’un point fixe.


MACHINE DE MOORE - FEU ROUGE

```vhdl
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:57:05 03/08/2021 
-- Design Name: 
-- Module Name:    FEU_ROUGE - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FEU_ROUGE is
    Port ( P0 : in  STD_LOGIC;
           P1 : in  STD_LOGIC;
			  RAZ : in  STD_LOGIC;
			  CLK : in  STD_LOGIC;
           R0 : out  STD_LOGIC;
           O0 : out  STD_LOGIC;
           V0 : out  STD_LOGIC;
           R1 : out  STD_LOGIC;
           V1 : out  STD_LOGIC;
           O1 : out  STD_LOGIC);
end FEU_ROUGE;

architecture Behavioral of FEU_ROUGE is

TYPE ETAT IS (E0,E1,E2,E3,E4,E5,E6,E7);
SIGNAL ETAT_PRES,ETAT_FUT :ETAT;

begin
----------------- PROCESS DE SYNCHRONSATION -------------------

	PROC_SYNCH :PROCESS(RAZ,CLK)
	 BEGIN
		IF RAZ='0'
			THEN ETAT_PRES <= E0;
		ELSIF (CLK='1' AND CLK' EVENT)	
			THEN ETAT_PRES<=ETAT_FUT;
		END IF;
	END PROCESS PROC_SYNCH;
	
--------------- PROCESS DE CALCULE D'ETAT FUTURE----------------

	PROC_FUT: PROCESS(ETAT_PRES,P0,P1)
		BEGIN
			CASE ETAT_PRES IS
				WHEN E0 =>
						IF ( P0='1' AND P1='0')
							THEN ETAT_FUT<=E0;
						ELSIF (P0='0' AND P1='1')
							THEN ETAT_FUT<=E3;
						ELSE 	ETAT_FUT <= E1;
						END IF;
				WHEN E1 =>
					ETAT_FUT<=E2;
				WHEN E2 =>
					ETAT_FUT<=E3;
				WHEN E3 =>
					ETAT_FUT<=E4;
				WHEN E4 =>
					ETAT_FUT<=E3;
						IF(P0='1' AND P1='0')
							THEN ETAT_FUT<=E7;
						ELSIF (P0='0' AND P1='1')
						  THEN ETAT_FUT<=E4;
						ELSE  ETAT_FUT<=E5;
							END IF;
				WHEN E5 => 
					ETAT_FUT<=E6;
				WHEN E6 => 
					ETAT_FUT<=E7;
			   WHEN E7 => 
					ETAT_FUT<=E1;
					END CASE;
		END PROCESS PROC_FUT;
		
------------------------PROCESS SORTIE------------------------
		
	PROC_SORTIE :PROCESS(ETAT_PRES)
		BEGIN
			CASE ETAT_PRES IS 
				WHEN E0 =>
				 R0<='0';
				 O0<='0';
				 V0<='1';
				 R1<='1';
				 O1<='0';
				 V1<='0';
				WHEN E1 =>
				 R0<='0';
				 O0<='0';
				 V0<='1';
				 R1<='1';
				 O1<='0';
				 V1<='0';
				WHEN E2 =>
				 R0<='0';
				 O0<='0';
				 V0<='1';
				 R1<='1';
				 O1<='0';
				 V1<='0';
				WHEN E3 =>
				 R0<='0';
				 O0<='1';
				 V0<='0';
				 R1<='1';
				 O1<='0';
				 V1<='0';
				WHEN E4 =>
				 R0<='1';
				 O0<='0';
				 V0<='0';
				 R1<='0';
				 O1<='0';
				 V1<='1';
				WHEN E5 =>
				 R0<='1';
				 O0<='0';
				 V0<='0';
				 R1<='0';
				 O1<='0';
				 V1<='1';
				WHEN E6 =>
				 R0<='1';
				 O0<='0';
				 V0<='0';
				 R1<='0';
				 O1<='0';
				 V1<='1';
				WHEN E7 =>
				 R0<='1';
				 O0<='0';
				 V0<='0';
				 R1<='0';
				 O1<='1';
				 V1<='0';
		END CASE;		 
		END PROCESS PROC_SORTIE;


end Behavioral;


```
oyyyyyyyyyyyyyyyyy


```vhdl
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:03:53 01/17/2021 
-- Design Name: 
-- Module Name:    M_COMP - Behavioral 
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

-- Uncomment the following library declaration if using
--arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity M_COMP is
    Port ( E  : in  STD_LOGIC_VECTOR (3 downto 0);
           P0 : out  STD_LOGIC;
           E0 : out  STD_LOGIC;
           M0 : out  STD_LOGIC;
           C0 : out  STD_LOGIC);
end M_COMP;

architecture Behavioral of M_COMP is

begin
-------------------------**Instruction when**-----------------------------------------------------------														
--******************************--- Sortie P0---**********************************---						
						--P0 <= '1' when (E="1011" or E="1100" or E="1111")
						  --  else '0';
--******************************--- Sortie E0---**********************************---
					--	E0 <= '1' when (E= "0100" OR E="1110" or E="1100" or E="1101")
						--    else '0';
--******************************--- Sortie M0---**********************************---							 
						--M0 <= '1' when (E= "1010" OR E="1110")
						 --   else '0';
--******************************--- Sortie C0---**********************************---							 
						--C0 <= '1' when (E= "1001" OR E="1101")
						--    else '0';						
-------------------------**Instruction WITH SELECT**-----------------------------------------------------------
							--WITH E SELECT
								--P0 <= '1' WHEN "1011"|"1100"|"1111",
							  -- '0' WHEN OTHERS;
							--WITH E SELECT
								--E0 <= '1' WHEN "0100"|"1110"|"1100"|"1101",
							  -- '0' WHEN OTHERS;
							--WITH E SELECT
							--	M0 <= '1' WHEN "1010"|"1110",
							 --  '0' WHEN OTHERS;
							--WITH E SELECT
							--	C0 <= '1' WHEN "1001"|"1101",
							 --  '0' WHEN OTHERS;
-------------------------**Instruction CASE**-----------------------------------------------------------
	PRO : process (E)
						BEGIN
--******************************--- Sortie P0---**********************************---
							CASE E is
									when "1011"|"1100"|"1111" => P0 <='1'; 
									when others => P0 <= '0'; 
							end case;
--******************************--- Sortie E0---**********************************---
							CASE E is
								 WHEN "0100"|"1110"|"1100"|"1101" => E0 <='1'; 
								 when others => E0 <= '0'; 
							end case;		
--******************************---Sortie M0---**********************************---
							CASE E is 
								WHEN "1010"|"1110" => M0 <='1'; 
								when others => M0 <= '0';
							end case;
--******************************---Sortie C0---**********************************---
							CASE E is 
								WHEN "1001"|"1101" => C0 <='1'; 
								when others => C0 <= '0';
							end case;
							end process;
------------------------------------------------------------------------------------------------------------*/----
-------------------------**Instruction IF**-----------------------------------------------------------
					--PRO : process (E)
						--   BEGIN	
--******************************--- Sortie P0---**********************************---
						--		if (E="1011" or E="1100" or E="1111") then P0 <='1';
							--	else P0 <='0';
						--		end if;
--******************************--- Sortie E0---**********************************---
			--					if (E= "0100" OR E="1110" or E="1100" or E="1101") then E0 <='1';
				--				else E0 <='0';
						--		end if;
--******************************--- Sortie M0---**********************************---
					--			if (E= "1010" OR E="1110") then M0 <='1';
						--		else M0 <='0';
						--		end if;
--******************************--- Sortie C0---**********************************---
							--	if (E= "1001" OR E="1101") then C0 <='1';
				--				else C0 <='0';
					--			end if;
					--	end process;
------------------------------------------------------------------------------------------------------------*



end Behavioral;
```
