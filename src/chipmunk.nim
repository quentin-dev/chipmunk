import os, streams, logging, strformat

type
    Opcode = enum
        ## Enum for the CHIP-8 CPU opcodes
        LD

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

proc getX(opcode: uint16): uint8 {.inline.} =
    ## Get X value from given opcode
    result = uint8((opcode and 0x0F00) shr 8)

proc getKK(opcode: uint16): uint8 {.inline.} =
    ## Get KK value from given opcode
    result = uint8(opcode and 0x00FF)

proc getNNN(opcode: uint16): uint16 {.inline.} =
    ## Get NNN value from given opcode
    result = opcode and 0x0FFF

proc decode(c: var CPU, opcode: uint16) =
    ## Decode given opcode
    
    case opcode and 0xF000:
        of 0x1000:
            c.pc = getNNN(opcode)
            info(fmt"JP {getNNN(opcode):#X}")
        of 0x6000:
            c.v[getX(opcode)] = getKK(opcode)
            info(fmt"LD V[{getX(opcode):#X}], {getKK(opcode):#X}")
        of 0xA000:
            c.i = getNNN(opcode)
            info(fmt"LD I, {getNNN(opcode):#X}")
        else:
            raise newException(OSError, fmt"Unhandled opcode {opcode:#X}")

    

proc cycle*(c: var Chip8) =
    ## Runs a CPU cycle

    let opcode: uint16 = (uint16(c.memory[c.CPU.pc]) shl 8) or c.memory[c.CPU.pc + 1]
    info(fmt"Got opcode {opcode:#X}")

    c.CPU.pc += 2

    c.CPU.decode(opcode)

var logger = newConsoleLogger(fmtStr="[$time] - $levelname: ")
addHandler(logger)

var machine: Chip8

machine.CPU.init()

let path = (if paramCount() > 0: paramStr(1) else: "./roms/BLINKY")
machine.load_rom(path)

while true:
    machine.cycle()