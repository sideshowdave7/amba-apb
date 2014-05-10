:::python
Report of Asynchronous AMBA-APB design  
  
  
Timing Paths  
  
Max Timing Path: .356ns = 2.809Ghz  
  
  
Endpoint                         Path Delay     Path Required     Slack  
------------------------------------------------------------------------  
PSEL (out)                         0.356 r        infinity     infinity  
PSEL (out)                         0.344 r        infinity     infinity  
PSEL (out)                         0.335 f        infinity     infinity  
PSEL (out)                         0.334 f        infinity     infinity  
PENABLE (out)                      0.274 r        infinity     infinity  
PENABLE (out)                      0.262 r        infinity     infinity  
PSEL (out)                         0.261 r        infinity     infinity  
PSEL (out)                         0.254 f        infinity     infinity  
PENABLE (out)                      0.225 f        infinity     infinity  
PENABLE (out)                      0.224 f        infinity     infinity  
PSEL (out)                         0.189 r        infinity     infinity  
PENABLE (out)                      0.180 r        infinity     infinity  
PSEL (out)                         0.168 f        infinity     infinity  
PENABLE (out)                      0.144 f        infinity     infinity  
PENABLE (out)                      0.079 r        infinity     infinity  
PENABLE (out)                      0.046 f        infinity     infinity  
  
  
  
  
  
Estimated Area (Cell Area w/out interconnection)  
  
Number of ports:                           37  
Number of nets:                             8  
Number of cells:                            6  
Number of combinational cells:              6  
Number of sequential cells:                 0  
Number of macros:                           0  
Number of buf/inv:                          2  
Number of references:                       5  
  
Combinational area:        105.369600  
Buf/Inv area:               22.579201  
Noncombinational area:       0.000000  
Net Interconnect area:      undefined  (Wire load has zero net area)  
  
Total cell area:           105.369600  
Total area:                 undefined  
 



Power
 
Global Operating Voltage = 1.8    
Power-specific unit information :  
    Voltage Units = 1V  
    Capacitance Units = 1.000000pf  
    Time Units = 1ns  
    Dynamic Power Units = 1mW    (derived from V,C,T units)  
    Leakage Power Units = 1nW  
  
  
  Cell Internal Power  =   7.9208 uW   (49%)  
  Net Switching Power  =   8.3040 uW   (51%)  
                         ---------  
Total Dynamic Power    =  16.2247 uW  (100%)  
  
Cell Leakage Power     =   1.1327 nW  
  
Information: report_power power group summary does not include estimated clock tree power. (PWR-789)  
  
                 Internal         Switching           Leakage            Total  
Power Group      Power            Power               Power              Power   (   %    )  Attrs  
--------------------------------------------------------------------------------------------------  
io_pad             0.0000            0.0000            0.0000            0.0000  (   0.00%)  
memory             0.0000            0.0000            0.0000            0.0000  (   0.00%)  
black_box          0.0000            0.0000            0.0000            0.0000  (   0.00%)  
clock_network      0.0000            0.0000            0.0000            0.0000  (   0.00%)  
register           0.0000            0.0000            0.0000            0.0000  (   0.00%)  
sequential         0.0000            0.0000            0.0000            0.0000  (   0.00%)  
combinational  7.9208e-03        8.3040e-03            1.1327        1.6226e-02  ( 100.00%)  
--------------------------------------------------------------------------------------------------  
Total          7.9208e-03 mW     8.3040e-03 mW         1.1327 nW     1.6226e-02 mW  
  
  
