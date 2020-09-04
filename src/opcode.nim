## Module for all CHIP-8 opcode utils

proc getX*(opcode: uint16): uint8 {.inline.} =
    ## Get X value from given opcode
    result = uint8((opcode and 0x0F00) shr 8)

proc getY*(opcode: uint16): uint8 {.inline.} =
    ## Get Y Value from given opcode
    result = uint8((opcode and 0X00F0) shr 4)

proc getKK*(opcode: uint16): uint8 {.inline.} =
    ## Get KK value from given opcode
    result = uint8(opcode and 0x00FF)

proc getNNN*(opcode: uint16): uint16 {.inline.} =
    ## Get NNN value from given opcode
    result = opcode and 0x0FFF