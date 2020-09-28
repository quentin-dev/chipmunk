## Display utilities tests
import datatypes, display, unittest

suite "display util test suite":

    var machine: Chip8

    setup:
        machine = Chip8()
        # No need for init here

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