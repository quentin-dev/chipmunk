import streams
import os

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

type
    Chip8* = object
        ## Type for the CHIP-8 itself
        memory*: array[4096, uint8]
        ## The RAM

proc load_rom*(c: var Chip8, path: string) =
    let romSize = getFileSize(path)
    doAssert int(romSize) < (4096 - 0x200)

    let rom = newFileStream(path, fmRead)
    discard rom.readData(addr(c.memory[0x200]), int(romSize))

var plop: Chip8
plop.load_rom("INVADERS")