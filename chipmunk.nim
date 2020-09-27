import os, logging, src/chip8, src/datatypes, system

when isMainModule:

    let logger = newConsoleLogger(fmtStr="[$time] - $levelname: ")
    addHandler(logger)

    var machine: Chip8

    machine.init()

    if paramCount() == 0:
        info("No path to rom given, exiting ...")
        quit(1)

    let path = paramStr(1)
    machine.load_rom(path)

    while true:
        machine.cycle()