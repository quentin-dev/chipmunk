## Module for all relevant datatypes

type
    CPU* = object
        ## Type for the Chip8 CPU
        v*: array[16, uint8]
            ## The V registers
        i*: uint16
            ## The I register
        pc*: uint16
            ## The program counter
        sp*: uint8
            ## The stack pointer
        dt*: uint8
            ## The delay timer
        st*: uint8
            ## The sound timer

    Chip8* = object
        ## Type for the CHIP-8 itself
        memory*: array[4096, uint8]
            ## The RAM
        CPU*: CPU
            ## The CPU