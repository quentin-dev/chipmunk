## Display utilities tests
import datatypes, display, unittest, sprites, chip8

suite "display util test suite":

    var machine: Chip8

    setup:
        machine = Chip8()
        # No need for init here

    test "simple bit to bool - true":
        check(bool(0x1) == true)
    
    test "simple bit to bool - false":
        check(bool(0x0) == false)

    test "drawAt test - empty previous pixel & new true":
        check(drawAt(machine, 0, 0, true) == false)
        check(machine.display[0] == true)

    test "drawAt test - empty previous pixel & new false":
        check(drawAt(machine, 0, 0, false) == false)
        check(machine.display[0] == false)

    test "drawAt test - filled previous pixel & new true":
        machine.display[0] = true
        check(drawAt(machine, 0, 0, true) == true)
        check(machine.display[0] == true)

    test "drawAt test - filled previous pixel & new false":
        machine.display[0] = true
        check(drawAt(machine, 0, 0, false) == true)
        check(machine.display[0] == false)

    test "drawAt test - check coordinates (1, 0)":
        check(drawAt(machine, 1, 0, true) == false)
        check(machine.display[1] == true)

    test "drawAt test - check coordinates (0, 1)":
        check(drawAt(machine, 0, 1, true) == false)
        check(machine.display[(1 * 32) + 0] == true)

    test "drawAt test - check coordinates (4, 5)":
        check(drawAt(machine, 4, 5, true) == false)
        check(machine.display[(5 * 32) + 4] == true)

    test "drawAt test - check coordinates (10, 24)":
        check(drawAt(machine, 10, 24, true) == false)
        check(machine.display[(24 * 32) + 10] == true)

suite "load sprite test suite":

    var machine: Chip8

    setup:
        machine = Chip8()
        machine.init()

    test "check sprite 0 in memory":
        check(machine.memory[0x0] == SPRITES[0][0])
        check(machine.memory[0x1] == SPRITES[0][1])
        check(machine.memory[0x2] == SPRITES[0][2])
        check(machine.memory[0x3] == SPRITES[0][3])
        check(machine.memory[0x4] == SPRITES[0][4])

    test "check sprite 1 in memory":
        check(machine.memory[0x5] == SPRITES[1][0])
        check(machine.memory[0x6] == SPRITES[1][1])
        check(machine.memory[0x7] == SPRITES[1][2])
        check(machine.memory[0x8] == SPRITES[1][3])
        check(machine.memory[0X9] == SPRITES[1][4])

    test "check sprite 2 in memory":
        check(machine.memory[0xA] == SPRITES[2][0])
        check(machine.memory[0xB] == SPRITES[2][1])
        check(machine.memory[0xC] == SPRITES[2][2])
        check(machine.memory[0xD] == SPRITES[2][3])
        check(machine.memory[0xE] == SPRITES[2][4])

    test "check sprite 3 in memory":
        check(machine.memory[0xF] == SPRITES[3][0])
        check(machine.memory[0x10] == SPRITES[3][1])
        check(machine.memory[0x11] == SPRITES[3][2])
        check(machine.memory[0x12] == SPRITES[3][3])
        check(machine.memory[0x13] == SPRITES[3][4])

    test "check sprite 4 in memory":
        check(machine.memory[0x14] == SPRITES[4][0])
        check(machine.memory[0x15] == SPRITES[4][1])
        check(machine.memory[0x16] == SPRITES[4][2])
        check(machine.memory[0x17] == SPRITES[4][3])
        check(machine.memory[0x18] == SPRITES[4][4])

    test "check sprite 5 in memory":
        check(machine.memory[0x19] == SPRITES[5][0])
        check(machine.memory[0x1A] == SPRITES[5][1])
        check(machine.memory[0x1B] == SPRITES[5][2])
        check(machine.memory[0x1C] == SPRITES[5][3])
        check(machine.memory[0x1D] == SPRITES[5][4])

    test "check sprite 6 in memory":
        check(machine.memory[0x1E] == SPRITES[6][0])
        check(machine.memory[0x1F] == SPRITES[6][1])
        check(machine.memory[0x20] == SPRITES[6][2])
        check(machine.memory[0x21] == SPRITES[6][3])
        check(machine.memory[0x22] == SPRITES[6][4])
    
    test "check sprite 7 in memory":
        check(machine.memory[0x23] == SPRITES[7][0])
        check(machine.memory[0x24] == SPRITES[7][1])
        check(machine.memory[0x25] == SPRITES[7][2])
        check(machine.memory[0x26] == SPRITES[7][3])
        check(machine.memory[0x27] == SPRITES[7][4])

    test "check sprite 8 in memory":
        check(machine.memory[0x28] == SPRITES[8][0])
        check(machine.memory[0x29] == SPRITES[8][1])
        check(machine.memory[0x2A] == SPRITES[8][2])
        check(machine.memory[0x2B] == SPRITES[8][3])
        check(machine.memory[0x2C] == SPRITES[8][4])

    test "check sprite 9 in memory":
        check(machine.memory[0x2D] == SPRITES[9][0])
        check(machine.memory[0x2E] == SPRITES[9][1])
        check(machine.memory[0x2F] == SPRITES[9][2])
        check(machine.memory[0x30] == SPRITES[9][3])
        check(machine.memory[0x31] == SPRITES[9][4])

    test "check sprite A in memory":
        check(machine.memory[0x32] == SPRITES[10][0])
        check(machine.memory[0x33] == SPRITES[10][1])
        check(machine.memory[0x34] == SPRITES[10][2])
        check(machine.memory[0x35] == SPRITES[10][3])
        check(machine.memory[0x36] == SPRITES[10][4])

    test "check sprite B in memory":
        check(machine.memory[0x37] == SPRITES[11][0])
        check(machine.memory[0x38] == SPRITES[11][1])
        check(machine.memory[0x39] == SPRITES[11][2])
        check(machine.memory[0x3A] == SPRITES[11][3])
        check(machine.memory[0x3B] == SPRITES[11][4])

    test "check sprite C in memory":
        check(machine.memory[0x3C] == SPRITES[12][0])
        check(machine.memory[0x3D] == SPRITES[12][1])
        check(machine.memory[0x3E] == SPRITES[12][2])
        check(machine.memory[0x3F] == SPRITES[12][3])
        check(machine.memory[0x40] == SPRITES[12][4])
    
    test "check sprite D in memory":
        check(machine.memory[0x41] == SPRITES[13][0])
        check(machine.memory[0x42] == SPRITES[13][1])
        check(machine.memory[0x43] == SPRITES[13][2])
        check(machine.memory[0x44] == SPRITES[13][3])
        check(machine.memory[0x45] == SPRITES[13][4])

    test "check sprite E in memory":
        check(machine.memory[0x46] == SPRITES[14][0])
        check(machine.memory[0x47] == SPRITES[14][1])
        check(machine.memory[0x48] == SPRITES[14][2])
        check(machine.memory[0x49] == SPRITES[14][3])
        check(machine.memory[0x4A] == SPRITES[14][4])

    test "check sprite F in memory":
        check(machine.memory[0x4B] == SPRITES[15][0])
        check(machine.memory[0x4C] == SPRITES[15][1])
        check(machine.memory[0x4D] == SPRITES[15][2])
        check(machine.memory[0x4E] == SPRITES[15][3])
        check(machine.memory[0x4F] == SPRITES[15][4])