## Module for display utils
import datatypes

proc drawAt*(c: var Chip8, x: uint8, y: uint8, pixel: bool): bool =
    ## Set c.display[x][y] to pixel and returns if overwrite
    result = c.display[y * 64 + x]
    c.display[y * 64 + x] = pixel