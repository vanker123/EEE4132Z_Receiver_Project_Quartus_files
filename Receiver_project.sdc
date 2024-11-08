set_clock_groups -exclusive -group [get_clocks {altera_reserved_tck}]

set_input_delay  -clock altera_reserved_tck -clock_fall 3 [get_ports {altera_reserved_tdi}]
set_input_delay  -clock altera_reserved_tck -clock_fall 3 [get_ports {altera_reserved_tms}]
set_output_delay -clock altera_reserved_tck -clock_fall 3 [get_ports {altera_reserved_tdo}]