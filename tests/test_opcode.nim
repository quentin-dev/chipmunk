## Opcode utilities tests
import opcode, unittest

suite "opcode util test suite":

    test "getX test":
        check(getX(0xA489) == 0x4)

    test "getY test":
        check(getY(0xA489) == 0x8)

    test "getKK test":
        check(getKK(0xA489) == 0x89)

    test "getNNN test":
        check(getNNN(0xA489) == 0x489)

    test "getN test":
        check(getN(0xD432) == 0x2)