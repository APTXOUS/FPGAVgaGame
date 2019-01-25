onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib rock_pic_opt

do {wave.do}

view wave
view structure
view signals

do {rock_pic.udo}

run -all

quit -force
