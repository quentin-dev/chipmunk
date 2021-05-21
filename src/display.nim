## Module for display utils
import datatypes, logging, strformat, sprites, system

proc loadSprites*(c: var Chip8) =
    ## Load default sprits into memory

    for i in 0..(len(SPRITES) - 1):
        debug(fmt"Loading SPRITES[{i}] to RAM")
        for j in 0..(SPRITE_BYTES - 1):
            c.memory[i * SPRITE_BYTES + j] = SPRITES[i][j]

proc drawAt*(c: var Chip8, x: uint16, y: uint16, pixel: bool): bool =
    ## Set c.display[(y * 32) + x] to pixel and returns if overwrite

    result = c.display[(y * 32) + x]
    debug(fmt"Setting display at ({x}; {y}) (which is [{(y + 32) + x}]) to {pixel} - was {result}")
    
    c.display[(y * 32) + x] = pixel