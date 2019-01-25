onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib boat_left_opt

do {wave.do}

view wave
view structure
view signals

do {boat_left.udo}

run -all

quit -force
