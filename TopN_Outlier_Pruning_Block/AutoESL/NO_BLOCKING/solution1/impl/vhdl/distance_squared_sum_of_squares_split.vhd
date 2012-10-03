-- ==============================================================
-- File generated by AutoESL - High-Level Synthesis System (C, C++, SystemC)
-- Version: 2012.1
-- Copyright (C) 2012 Xilinx Inc. All rights reserved.
-- 
-- ==============================================================

Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity distance_squared_sum_of_squares_split is
    generic (
        DataWidth : INTEGER := 64;
        AddressRange : INTEGER := 8;
        AddressWidth : INTEGER := 3);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        we0 : IN STD_LOGIC;
        d0 : IN STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0);
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0);
        address1 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce1 : IN STD_LOGIC;
        we1 : IN STD_LOGIC;
        d1 : IN STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of distance_squared_sum_of_squares_split is
    component distance_squared_sum_of_squares_split_ram is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            d0 : IN STD_LOGIC_VECTOR;
            we0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR;
            addr1 : IN STD_LOGIC_VECTOR;
            ce1 : IN STD_LOGIC;
            d1 : IN STD_LOGIC_VECTOR;
            we1 : IN STD_LOGIC);
    end component;



begin
    distance_squared_sum_of_squares_split_ram_U :  component distance_squared_sum_of_squares_split_ram
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        d0 => d0,
        we0 => we0,
        q0 => q0,
        addr1 => address1,
        ce1 => ce1,
        d1 => d1,
        we1 => we1);

end architecture;

