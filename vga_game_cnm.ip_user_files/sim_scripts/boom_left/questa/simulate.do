onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib boom_left_opt

do {wave.do}

view wave
view structure
view signals

do {boom_left.udo}

run -all

quit -force
