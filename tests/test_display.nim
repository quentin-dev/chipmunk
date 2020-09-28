## Display utilities tests
import datatypes, display, unittest

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