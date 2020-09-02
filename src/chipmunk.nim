import os, streams, logging, strformat

type
    CPU* = object
        ## Type for the Chip8 CPU
        v*: array[16, uint8]
            ## The V registers
        i*: uint16
            ## The I register
        pc*: uint16
            ## The program counter
        sp*: uint8
            ## The stack pointer
        dt*: uint8
            ## The delay timer
        st*: uint8
            ## The sound timer

    Chip8* = object
        ## Type for the CHIP-8 itself
        memory*: array[4096, uint8]
            ## The RAM
        CPU*: CPU
            ## The CPU

proc load_rom*(c: var Chip8, path: string) =
    ## Loads the rom at the specified path into CHIP-8 RAM

    info(fmt"Trying to load: {path}")

    let romSize = getFileSize(path)
    doAssert int(romSize) < (4096 - 0x200)

    let rom = newFileStream(path, fmRead)
    discard rom.readData(addr(c.memory[0x200]), int(romSize))

var logger = newConsoleLogger(fmtStr="[$time] - $levelname: ")
addHandler(logger)

var plop: Chip8

let path = (if paramCount() > 0: paramStr(1) else: "./roms/INVADERS")
plop.load_rom(path)