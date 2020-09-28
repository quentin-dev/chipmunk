## Module for display utils
import datatypes, logging, strformat

proc drawAt*(c: var Chip8, x: uint16, y: uint16, pixel: bool): bool =
    ## Set c.display[(y * 32) + x] to pixel and returns if overwrite
    result = c.display[(y * 32) + x]
    debug(fmt"Setting display at ({x}; {y}) (which is [{(y + 32) + x}]) to {pixel} - was {result}")
    
    c.display[(y * 32) + x] = pixel