import os, logging, src/chip8, src/datatypes

when isMainModule:

    let logger = newConsoleLogger(fmtStr="[$time] - $levelname: ")
    addHandler(logger)

    var machine: Chip8

    machine.init()

    let path = (if paramCount() > 0: paramStr(1) else: "./roms/BLINKY")
    machine.load_rom(path)

    while true:
        machine.cycle()