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

proc init*(c: var CPU) =
    ## Initialize the program counter
    
    c.pc = 0x200
    info(fmt"Initialized CPU program counter to {c.pc:#X}")

proc load_rom*(c: var Chip8, path: string) =
    ## Loads the rom at the specified path into CHIP-8 RAM

    info(fmt"Going to load rom {path}")

    let romSize = getFileSize(path)
    doAssert int(romSize) < (4096 - 0x200)

    let rom = newFileStream(path, fmRead)
    discard rom.readData(addr(c.memory[0x200]), int(romSize))

    info(fmt"Loaded rom {path} into CHIP-8 RAM")

var logger = newConsoleLogger(fmtStr="[$time] - $levelname: ")
addHandler(logger)

var machine: Chip8

machine.CPU.init()

let path = (if paramCount() > 0: paramStr(1) else: "./roms/BLINKY")
machine.load_rom(path)