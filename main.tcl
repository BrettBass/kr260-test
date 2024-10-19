# ----------------------------------------------------------------
# IO Map
# ----------------------------------------------------------------
set_property -dict {PACKAGE_PIN H12 IOSTANDARD LVCM0S33} {get_ports {leds[0]}}
set_property -dict {PACKAGE_PIN E10 IOSTANDARD LVCM0S33} {get_ports {leds[1]}}
set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVCM0S33} {get_ports {leds[2]}}
set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCM0S33} {get_ports {leds[3]}}
set_property -dict {PACKAGE_PIN B10 IOSTANDARD LVCM0S33} {get_ports {btn}}


# ----------------------------------------------------------------
# Clock Virtual clock
# ----------------------------------------------------------------
create_clock -add -name clk_virt_100mhz -period 10.00

# ----------------------------------------------------------------
# Input Timing
# ----------------------------------------------------------------
set_false_path -from {btn}
set_input_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {btn}]
set_input_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 2.000 [get_ports {btn}]

# ----------------------------------------------------------------
# Output Timing
# ----------------------------------------------------------------
set_false_path -to {leds[0]}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {leds[0]}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 2.000 [get_ports {leds[0]}]

set_false_path -to {leds[1]}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {leds[1]}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 2.000 [get_ports {leds[1]}]

set_false_path -to {leds[2]}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {leds[2]}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 2.000 [get_ports {leds[2]}]

set_false_path -to {leds[3]}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {leds[3]}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 2.000 [get_ports {leds[3]}]

