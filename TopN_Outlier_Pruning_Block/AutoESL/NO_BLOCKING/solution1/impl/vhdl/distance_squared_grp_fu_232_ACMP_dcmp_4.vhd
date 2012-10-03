-- ==============================================================
-- File generated by AutoESL - High-Level Synthesis System (C, C++, SystemC)
-- Version: 2012.1
-- Copyright (C) 2012 Xilinx Inc. All rights reserved.
-- 
-- ==============================================================

Library ieee;
use ieee.std_logic_1164.all;

entity distance_squared_grp_fu_232_ACMP_dcmp_4 is
    generic (
        ID         : integer := 4;
        NUM_STAGE  : integer := 3;
        din0_WIDTH : integer := 64;
        din1_WIDTH : integer := 64;
        dout_WIDTH : integer := 1
    );
    port (
        clk    : in  std_logic;
        reset  : in  std_logic;
        ce     : in  std_logic;
        din0   : in  std_logic_vector(din0_WIDTH-1 downto 0);
        din1   : in  std_logic_vector(din1_WIDTH-1 downto 0);
        opcode : in  std_logic_vector(4 downto 0);
        dout   : out std_logic_vector(dout_WIDTH-1 downto 0)
    );
end entity;

architecture arch of distance_squared_grp_fu_232_ACMP_dcmp_4 is
    --------------------- Component ---------------------
    component distance_squared_ap_dcmp_1_no_dsp is
        port (
            aclk                    : in  std_logic;
            aclken                  : in  std_logic;
            s_axis_a_tvalid         : in  std_logic;
            s_axis_a_tdata          : in  std_logic_vector(63 downto 0);
            s_axis_b_tvalid         : in  std_logic;
            s_axis_b_tdata          : in  std_logic_vector(63 downto 0);
            s_axis_operation_tvalid : in  std_logic;
            s_axis_operation_tdata  : in  std_logic_vector(7 downto 0);
            m_axis_result_tvalid    : out std_logic;
            m_axis_result_tdata     : out std_logic_vector(7 downto 0)
        );
    end component;
    --------------------- Constant ----------------------
    -- AutoESL opcode
    constant AP_OEQ : std_logic_vector(4 downto 0) := "00001";
    constant AP_OGT : std_logic_vector(4 downto 0) := "00010";
    constant AP_OGE : std_logic_vector(4 downto 0) := "00011";
    constant AP_OLT : std_logic_vector(4 downto 0) := "00100";
    constant AP_OLE : std_logic_vector(4 downto 0) := "00101";
    constant AP_ONE : std_logic_vector(4 downto 0) := "00110";
    constant AP_UEQ : std_logic_vector(4 downto 0) := "01001";
    constant AP_UGT : std_logic_vector(4 downto 0) := "01010";
    constant AP_UGE : std_logic_vector(4 downto 0) := "01011";
    constant AP_ULT : std_logic_vector(4 downto 0) := "01100";
    constant AP_ULE : std_logic_vector(4 downto 0) := "01101";
    constant AP_UNE : std_logic_vector(4 downto 0) := "01110";
    -- FPV6 opcode
    constant OP_EQ  : std_logic_vector(7 downto 0) := "00010100";
    constant OP_GT  : std_logic_vector(7 downto 0) := "00100100";
    constant OP_GE  : std_logic_vector(7 downto 0) := "00110100";
    constant OP_LT  : std_logic_vector(7 downto 0) := "00001100";
    constant OP_LE  : std_logic_vector(7 downto 0) := "00011100";
    constant OP_NE  : std_logic_vector(7 downto 0) := "00101100";
    --------------------- Local signal ------------------
    signal aclk        : std_logic;
    signal aclken      : std_logic;
    signal a_tvalid    : std_logic;
    signal a_tdata     : std_logic_vector(63 downto 0);
    signal b_tvalid    : std_logic;
    signal b_tdata     : std_logic_vector(63 downto 0);
    signal op_tvalid   : std_logic;
    signal op_tdata    : std_logic_vector(7 downto 0);
    signal r_tvalid    : std_logic;
    signal r_tdata     : std_logic_vector(7 downto 0);
    signal ce_buf1     : std_logic;
    signal din0_buf1   : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_buf1   : std_logic_vector(din1_WIDTH-1 downto 0);
    signal opcode_buf1 : std_logic_vector(4 downto 0);
begin
    --------------------- Instantiation -----------------
    distance_squared_ap_dcmp_1_no_dsp_u : component distance_squared_ap_dcmp_1_no_dsp
    port map (
        aclk                    => aclk,
        aclken                  => aclken,
        s_axis_a_tvalid         => a_tvalid,
        s_axis_a_tdata          => a_tdata,
        s_axis_b_tvalid         => b_tvalid,
        s_axis_b_tdata          => b_tdata,
        s_axis_operation_tvalid => op_tvalid,
        s_axis_operation_tdata  => op_tdata,
        m_axis_result_tvalid    => r_tvalid,
        m_axis_result_tdata     => r_tdata
    );

    --------------------- Assignment --------------------
    aclk     <= clk;
    aclken   <= ce_buf1;
    a_tvalid <= '1';
    a_tdata  <= din0_buf1;
    b_tvalid <= '1';
    b_tdata  <= din1_buf1;
    dout     <= r_tdata(0 downto 0);

    --------------------- Opcode ------------------------
    process (opcode_buf1) begin
        case (opcode_buf1) is
            when AP_OEQ => op_tdata <= OP_EQ;
            when AP_OGT => op_tdata <= OP_GT;
            when AP_OGE => op_tdata <= OP_GE;
            when AP_OLT => op_tdata <= OP_LT;
            when AP_OLE => op_tdata <= OP_LE;
            when AP_ONE => op_tdata <= OP_NE;
            when AP_UEQ => op_tdata <= OP_EQ;
            when AP_UGT => op_tdata <= OP_GT;
            when AP_UGE => op_tdata <= OP_GE;
            when AP_ULT => op_tdata <= OP_LT;
            when AP_ULE => op_tdata <= OP_LE;
            when AP_UNE => op_tdata <= OP_NE;
            when others => op_tdata <= OP_EQ;
        end case;
    end process;

    --------------------- Input buffer ------------------
    process (clk) begin
        if clk'event and clk = '1' then
            ce_buf1     <= ce;
            din0_buf1   <= din0;
            din1_buf1   <= din1;
            opcode_buf1 <= opcode;
        end if;
    end process;

end architecture;
