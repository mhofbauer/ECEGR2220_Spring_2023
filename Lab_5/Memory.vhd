--------------------------------------------------------------------------------
--
-- LAB #5 - Memory and Register Bank
--
--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity RAM is
    Port(Reset:	  in std_logic;
	 Clock:	  in std_logic;	 
	 OE:      in std_logic;
	 WE:      in std_logic;
	 Address: in std_logic_vector(29 downto 0);
	 DataIn:  in std_logic_vector(31 downto 0);
	 DataOut: out std_logic_vector(31 downto 0));
end entity RAM;

architecture staticRAM of RAM is

   type ram_type is array (0 to 127) of std_logic_vector(31 downto 0);
   signal i_ram : ram_type;

begin

  RamProc: process(Clock, Reset, OE, WE, Address) is

  begin
    if Reset = '1' then
      for i in 0 to 127 loop   
          i_ram(i) <= X"00000000";
      end loop;
    end if;
	
    	

   	if falling_edge(Clock) then
	-- Add code to write data to RAM
	-- Use to_integer(unsigned(Address)) to index the i_ram array
		if(WE = '1')then
			if((to_integer(unsigned(Address)) >= 0) and (to_integer(unsigned(Address)) <= 127))then
				i_ram(to_integer(unsigned(Address))) <= DataIn;
			end if;
		end if;
    	
	end if;

	-- Rest of the RAM implementation
	if(OE = '0') then
		if((to_integer(unsigned(Address)) >= 0) and (to_integer(unsigned(Address)) <= 127))then
			DataOut <= i_ram(to_integer(unsigned(Address))); else
			DataOut <= (OTHERS => 'Z');
		end if;
	else
		DataOut <= (OTHERS => 'Z');
	end if;

  end process RamProc;

end staticRAM;	


--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity Registers is
    Port(ReadReg1: in std_logic_vector(4 downto 0); 
         ReadReg2: in std_logic_vector(4 downto 0); 
         WriteReg: in std_logic_vector(4 downto 0);
	 WriteData: in std_logic_vector(31 downto 0);
	 WriteCmd: in std_logic;
	 ReadData1: out std_logic_vector(31 downto 0);
	 ReadData2: out std_logic_vector(31 downto 0));
end entity Registers;

architecture remember of Registers is
	component register32
  	    port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
	end component;
	
	signal a0:std_logic_vector(31 downto 0);
	signal a1:std_logic_vector(31 downto 0);
	signal a2:std_logic_vector(31 downto 0);
	signal a3:std_logic_vector(31 downto 0);
	signal a4:std_logic_vector(31 downto 0);
	signal a5:std_logic_vector(31 downto 0);
	signal a6:std_logic_vector(31 downto 0);
	signal a7:std_logic_vector(31 downto 0);
	signal hardwiredZero:std_logic_vector(31 downto 0);
	
	signal writeIn: std_logic_vector(7 downto 0);
	
begin
    -- Add your code here for the Register Bank implementation
	ReadData1 <=	a0 when (ReadReg1="01010") else
			a1 when (ReadReg1="01011") else
			a2 when (ReadReg1="01100") else
			a3 when (ReadReg1="01101") else
			a4 when (ReadReg1="01110") else
			a5 when (ReadReg1="01111") else
			a6 when (ReadReg1="10000") else
			a7 when (ReadReg1="10001") else
			hardwiredZero when (ReadReg1="00000") else
			(others => 'Z');


	ReadData2 <=	a0 when (ReadReg1="01010") else
			a1 when (ReadReg1="01011") else
			a2 when (ReadReg1="01100") else
			a3 when (ReadReg1="01101") else
			a4 when (ReadReg1="01110") else
			a5 when (ReadReg1="01111") else
			a6 when (ReadReg1="10000") else
			a7 when (ReadReg1="10001") else
			hardwiredZero when (ReadReg1="00000") else
			(others => 'Z');
	

	process(WriteCmd, WriteReg)
	begin
		if(WriteCmd = '1') then
			case WriteReg is 
				when "01010" => writeIn <= "10000000";
				when "01011" => writeIn <= "01000000";
				when "01100" => writeIn <= "00100000";
				when "01101" => writeIn <= "00010000";
				when "01110" => writeIn <= "00001000";
				when "01111" => writeIn <= "00000100";
				when "10000" => writeIn <= "00000010";
				when "10001" => writeIn <= "00000001";

				when others  => writeIn <= "00000000";
			
			end case;
		else
			writeIn <= "00000000";
		end if;
	end process;

	
	
	 x0:register32 PORT MAP (WriteData,'0','1','1','0','0','0', hardwiredZero);			--Zero
	x10:register32 PORT MAP (WriteData,'0','1','1', writeIn(0),'0','0', a0);	--A0
	x11:register32 PORT MAP (WriteData,'0','1','1', writeIn(1),'0','0', a1);	--A1
	x12:register32 PORT MAP (WriteData,'0','1','1', writeIn(2),'0','0', a2);	--A2
	x13:register32 PORT MAP (WriteData,'0','1','1', writeIn(3),'0','0', a3);	--A3
	x14:register32 PORT MAP (WriteData,'0','1','1', writeIn(4),'0','0', a4);	--A4
	x15:register32 PORT MAP (WriteData,'0','1','1', writeIn(5),'0','0', a5);	--A5
	x16:register32 PORT MAP (WriteData,'0','1','1', writeIn(6),'0','0', a6);	--A6
	x17:register32 PORT MAP (WriteData,'0','1','1', writeIn(7),'0','0', a7);	--A7

end remember;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
