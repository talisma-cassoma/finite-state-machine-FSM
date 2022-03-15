-- Company: 
-- Engineer:       TALISMA MANUEL
-- 
-- Create Date:    06:57:05 03/08/2021 
-- Design Name: 
-- Module Name:    FEU_ROUGE - Behavioral 
-- Project Name:   FEU_ROUGE
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

