onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib boom_up_opt

do {wave.do}

view wave
view structure
view signals

do {boom_up.udo}

run -all

quit -force
