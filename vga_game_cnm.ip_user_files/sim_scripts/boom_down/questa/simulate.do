onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib boom_down_opt

do {wave.do}

view wave
view structure
view signals

do {boom_down.udo}

run -all

quit -force
