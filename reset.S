stacktop:
    .word _stack
_Reset:
    .word _start
.word _NMI
.word _HardFault
.word _MemManage
.word _BusFault
.word _UsageFault
.word 0
.word 0
.word 0
.word 0
.word _SVCall
.word _DebugMonitor
