onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib boat_up_opt

do {wave.do}

view wave
view structure
view signals

do {boat_up.udo}

run -all

quit -force
