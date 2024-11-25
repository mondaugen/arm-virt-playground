.global _start
/*
_start needs to be marked with type "function" so that the linker puts the
correct address for jumping to it.
Basically, the processor calls "BX" on the address at memory space FLASH_BEGIN + 4
BX jumps to addresses. The addresses must be aligned on a 2-byte boundary, which
takes sense because Thumb instructions are 2 bytes wide. The 0th bit is then
used to change the encoding. This is for processors that can use both ARM32 and
thumb instructions. For thumb this bit is set and the processor we are
interested in (Cortext M4 or M7) only understands Thumb encoding, so the linker
will add 1 to the address to make the BX instruction work properly.
*/
.type _start, %function
_start:
    /* copy .data section */
_start.copy_data:
    ldr r0, =_data
    ldr r1, =_edata
    ldr r2, =_etext
_start.copy_data_loop:
    cmp r0,r1
    beq _start.zero_bss
    ldr r3, [r2]
    str r3, [r0]
    add r2, r2, #4
    add r0, r0, #4
    b _start.copy_data_loop
_start.zero_bss:
    ldr r0, =_bstart
    ldr r1, =_bend
    bic r2, r2
_start.zero_bss_loop:
    cmp r0, r1
    beq _start.zero_bss_end
    str r2, [r0]
    add r0, #4
    b _start.zero_bss_loop
_start.zero_bss_end:
#ifdef SIMULATE_FAULT_SVC
_start.simulate_fault_svc:
    svc #123
#endif
#ifdef SIMULATE_FAULT_DIV_0
_start.simulate_fault_div_0:
    ldr r1, =0xe000ed14 /* CCR register */
    ldr r3, =0x00000010 /* enable DIV_0_TRP */
    str r3, [r1]
    sdiv r0, r2
#endif
_start.jump_main:
    b main
