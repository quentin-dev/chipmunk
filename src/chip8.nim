## Module for the general CHIP-8 implementation
import os, streams, logging, strformat, datatypes, opcode

proc init*(c: var Chip8) =
    ## Initialize the program counter

    c.CPU.pc = 0x200
    info(fmt"Initialized CPU program counter to {c.CPU.pc:#X}")

proc load_rom*(c: var Chip8, path: string) =
    ## Loads the rom at the specified path into CHIP-8 RAM

    info(fmt"Going to load rom {path}")

    let romSize = getFileSize(path)
    doAssert int(romSize) < (4096 - 0x200)

    let rom = newFileStream(path, fmRead)
    discard rom.readData(addr(c.memory[0x200]), int(romSize))

    info(fmt"Loaded rom {path} into CHIP-8 RAM")

proc decode*(c: var Chip8, opcode: uint16) =
    ## Decode given opcode

    case opcode and 0xF000:
        of 0x0000:
            case opcode:
                of 0x00E0:
                    error("NOT IMPLEMENTED - CLS")
                of 0x00EE:
                    c.CPU.sp -= 1
                    c.CPU.pc = c.stack[c.CPU.sp]
                    info("RET")
                else:
                    raise newException(OSError, fmt"Unhandled opcode {opcode:#X}")
        of 0x1000:
            c.CPU.pc = getNNN(opcode)
            info(fmt"JP {getNNN(opcode):#X}")
        of 0x2000:
            c.stack[c.CPU.sp] = c.CPU.pc
            c.CPU.sp += 1
            c.CPU.pc = getNNN(opcode)
            info(fmt"CALL {getNNN(opcode):#X}")
        of 0x3000:
            if c.CPU.v[getX(opcode)] == getKK(opcode):
                c.CPU.pc += 2
            info(fmt"SE V[{getX(opcode):#X}], {getKK(opcode):#X}")
        of 0x6000:
            c.CPU.v[getX(opcode)] = getKK(opcode)
            info(fmt"LD V[{getX(opcode):#X}], {getKK(opcode):#X}")
        of 0x7000:
            c.CPU.v[getX(opcode)] = c.CPU.v[getX(opcode)] + getKK(opcode)
            info(fmt"ADD V[{getX(opcode):#X}], {getKK(opcode):#X}")
        of 0x8000:
            case opcode and 0x000F:
                of 0:
                    c.CPU.v[getX(opcode)] = c.CPU.v[getY(opcode)]
                    info(fmt"LD V[{getX(opcode):#X}], V[{getY(opcode):#X}]")
                of 2:
                    c.CPU.v[getX(opcode)] = (c.CPU.v[getX(opcode)] and c.CPU.v[getY(opcode)])
                    info(fmt"AND V[{getX(opcode):#X}], V[{getY(opcode):#X}]")
                of 3:
                    c.CPU.v[getX(opcode)] = c.CPU.v[getX(opcode)] xor c.CPU.v[getY(opcode)]
                    info(fmt"XOR V[{getX(opcode):#X}], V[{getY(opcode):#X}]")
                of 6:
                    c.CPU.v[0xF] = c.CPU.v[getX(opcode)] mod 2
                    c.CPU.v[getX(opcode)] = c.CPU.v[getX(opcode)] shr 1
                of 0xE:
                    c.CPU.v[0xF] = (if (c.CPU.v[getX(opcode)] and 0x80) == 0x80: 1 else: 0)
                    c.CPU.v[getX(opcode)] = c.CPU.v[getX(opcode)] shl 1
                else:
                    raise newException(OSError, fmt"Unhandled opcode {opcode:#X}")
        of 0xA000:
            c.CPU.i = getNNN(opcode)
            info(fmt"LD I, {getNNN(opcode):#X}")
        of 0xF000:
            for i in uint8(0)..getX(opcode):
                debug(fmt"Loading V[{i:#X}] = {c.CPU.v[i]:#X} into RAM @ {c.CPU.i + i:#X}")
                c.memory[c.CPU.i + i] = c.CPU.v[i]
            info(fmt"LD [I], V[{getX(opcode):#X}]")
        else:
            raise newException(OSError, fmt"Unhandled opcode {opcode:#X}")

proc cycle*(c: var Chip8) =
    ## Runs a CPU cycle

    let opcode: uint16 = (uint16(c.memory[c.CPU.pc]) shl 8) or c.memory[c.CPU.pc + 1]
    debug(fmt"Got opcode {opcode:#X}")

    c.CPU.pc += 2

    c.decode(opcode)