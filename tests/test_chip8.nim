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

    test "JP 0x21A":
        machine.decode(0x121A)
        check(machine.CPU.pc == 0x21A)
    
    test "LD V[2], F4":
        machine.decode(0x62F4)
        check(machine.CPU.v[2] == 0xF4)
    
    test "XOR V[2], V[3]":
        machine.CPU.v[2] = 4
        machine.CPU.v[3] = 2
        machine.decode(0x8233)
        check(machine.CPU.v[2] == (4 xor 2))

    test "LD I, FF4":
        machine.decode(0xAFF4)
        check(machine.CPU.i == 0xFF4)

    test "LD [I], V[3]":
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
