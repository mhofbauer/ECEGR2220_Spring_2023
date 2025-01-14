--------------------------------------------------------------------------------
--
-- LAB #6 - Processor Elements
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BusMux2to1 is
	Port(	selector: in std_logic;
			In0, In1: in std_logic_vector(31 downto 0);
			Result: out std_logic_vector(31 downto 0) );
end entity BusMux2to1;

architecture selection of BusMux2to1 is
begin
-- Add your code here
	with selector select
		Result <= In0 when '0',
			  In1 when others;
	

end architecture selection;

--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Control is
      Port(clk : in  STD_LOGIC;
           opcode : in  STD_LOGIC_VECTOR (6 downto 0);
           funct3  : in  STD_LOGIC_VECTOR (2 downto 0);
           funct7  : in  STD_LOGIC_VECTOR (6 downto 0);
           Branch : out  STD_LOGIC_VECTOR(1 downto 0);
           MemRead : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           ALUCtrl : out  STD_LOGIC_VECTOR(4 downto 0);
           MemWrite : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           ImmGen : out STD_LOGIC_VECTOR(1 downto 0));
end Control;

architecture Boss of Control is
	signal ALUtemp: std_logic_vector(4 downto 0);
begin
-- Add your code here
	
	ALUtemp<= 
	"00000"	when opcode = "0110011" and funct3 = "000" and funct7= "0000000" else	--add
	"00001"	when opcode = "0110011" and funct3 = "000" and funct7= "0100000"else -- sub
	"00011"	when opcode = "0110011" and funct3 = "000" and funct7= "0000000"else --or
	"00010"	when opcode = "0110011" and  funct3 = "111" and funct7= "0000000"else --and
	"00100"	when opcode = "0110011" and  funct3 = "001" and funct7= "0000000"else --sll
	"00101"	when opcode = "0110011" and  funct3 = "101" and funct7= "0000000"else --srl
	"00000"	when opcode = "0010011" and funct7= "000"else -- addi
	"00011"	when opcode = "0010011" and funct7= "110" else -- ori
	"00010"	when opcode = "0010011" and funct7= "000" else -- andi
	"00100"	when opcode = "0010011" and funct7= "001" else -- slli
	"00101"	when opcode = "0010011" and funct7= "101"; -- srli

	ALUCtrl <= ALUtemp;
	
	ImmGen <= 	"11"	when opcode = "0010011"else	--I type
			"10"	when opcode = "1100011"else	--B type
			"01"	when opcode = "0100011"else   	--S type
			"00";



	--would need to implement other functions outside of the ones our ALU already handles
end Boss;

--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ProgramCounter is
    Port(Reset: in std_logic;
	 Clock: in std_logic;
	 PCin: in std_logic_vector(31 downto 0);
	 PCout: out std_logic_vector(31 downto 0));
end entity ProgramCounter;

architecture executive of ProgramCounter is
begin
-- Add your code here
	process(Clock,Reset)
	begin
	if rising_edge(Clock) then
		PCout <=PCin;
	end if;

	if Reset "1" then
		PCout <= "00000000";
	
	end process

end executive;
--------------------------------------------------------------------------------
