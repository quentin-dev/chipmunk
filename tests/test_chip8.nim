## CHIP-8 implementation tests
import datatypes, chip8, unittest

suite "general chip8 methods test suite":

    var machine: Chip8

    setup:
        machine = Chip8()
        machine.init()

    test "essential program counter init check":
        check(machine.CPU.pc == 0x200)

suite "chip8 decode test suite":

    var machine: Chip8

    setup:
        machine = Chip8()
        machine.init()

    test "Ox121A -> JP 0x21A":
        machine.decode(0x121A)
        check(machine.CPU.pc == 0x21A)
    
    test "0x62F4 -> LD V[2], F4":
        machine.decode(0x62F4)
        check(machine.CPU.v[2] == 0xF4)
    
    test "0x8233 -> XOR V[2], V[3]":
        machine.CPU.v[2] = 4
        machine.CPU.v[3] = 2
        machine.decode(0x8233)
        check(machine.CPU.v[2] == (4 xor 2))

    test "0xAFF4 -> LD I, FF4":
        machine.decode(0xAFF4)
        check(machine.CPU.i == 0xFF4)

    test "0xF355 -> LD [I], V[3]":
        machine.CPU.i = 0x300
        machine.CPU.v[0] = 0x4
        machine.CPU.v[1] = 0x3
        machine.CPU.v[2] = 0x2
        machine.CPU.v[3] = 0x1
        machine.CPU.v[4] = 0xF
        machine.decode(0xF355)
        check(machine.memory[0x300] == 0x4)
        check(machine.memory[0x300 + 1] == 0x3)
        check(machine.memory[0x300 + 2] == 0x2)
        check(machine.memory[0x300 + 3] == 0x1)
        check(machine.memory[0x300 + 4] != 0xF)

    test "0X23AE -> CALL 0x3AE":
        let oldSP = machine.CPU.sp
        let oldPC = machine.CPU.pc
        machine.decode(0x23AE)
        check(machine.CPU.sp == (oldSP + 1))
        check(machine.stack[oldSP] == oldPC)
        check(machine.CPU.pc == 0x3AE)

    test "0x7C4E -> ADD V[0xC], 0x4E":
        machine.CPU.v[0xC] = 0x3
        machine.decode(0x7C4E)
        check(machine.CPU.v[0xC] == (0x3 + 0x4E))

    test "0x3E80 -> SE V[E], 0x80 (not equal)":
        let oldPC = machine.CPU.pc
        machine.CPU.v[0xE] = 0x12
        machine.decode(0X3E80)
        check(machine.CPU.pc == oldPC)

    test "0x3E80 -> SE V[E], 0x80 (equal)":
        let oldPC = machine.CPU.pc
        machine.CPU.v[0xE] = 0x80
        machine.decode(0X3E80)
        check(machine.CPU.pc == (oldPC + 2))

    test "0X00EE -> RET":
        machine.CPU.sp = 1
        machine.stack[0] = 0x31
        machine.decode(0x00EE)
        check(machine.CPU.pc == 0x31)
        check(machine.CPU.sp == 0)
    
    test "0x8022 -> AND V[0], V[2]":
        machine.CPU.v[0] = 3
        machine.CPU.v[2] = 2
        machine.decode(0x8022)
        check(machine.CPU.v[0] == (2 and 3))

    test "0x8020 -> LD V[0], V[2]":
        machine.CPU.v[0] = 3
        machine.CPU.v[2] = 2
        machine.decode(0x8020)
        check(machine.CPU.v[0] == 2)
