ENTRY(_start)

MEMORY {
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 1M
    SRAM  (rw) : ORIGIN = 0x20000000, LENGTH = 128K
}

SECTIONS
{
    .text : { *(.text) } > FLASH
    .data : { *(.data) }
    /* SRAM is from 0x2000_0000 to 0x2001_ffff */
}
