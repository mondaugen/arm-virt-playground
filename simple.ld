ENTRY(_start)

SECTIONS
{
    . = 0x08000000;
    .text :
    {
        reset.o(.text);
        . = 0x1000;
        crt0.o(.text);
        *(.text);
        _etext = .;
    }
    /* SRAM is from 0x2000_0000 to 0x2001_ffff */
    . = 0x20000000;
    .mdata : AT( ADDR(.text) + SIZEOF(.text) )
    {
        _data = .;
        *(.data);
        _edata = .;
    }
    .bss :
    {
        _bstart = .;
        *(.bss);
        _bend = .;
    }
    . = 0x20020000;
    _stack = .;
}

