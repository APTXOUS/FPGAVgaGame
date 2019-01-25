onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib boom_right_opt

do {wave.do}

view wave
view structure
view signals

do {boom_right.udo}

run -all

quit -force
