import datatypes, chip8, unittest

suite "Sample chipmunk test suite":

    var machine: Chip8

    setup:
        machine = Chip8()
        machine.init()

    test "essential program counter init check":
        require(machine.CPU.pc == 0x200)
