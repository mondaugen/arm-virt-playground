.global _NMI
.type _NMI, %function
_NMI:
    b _NMI

.global _HardFault
.type _HardFault, %function
_HardFault:
    b _HardFault

.global _MemManage
.type _MemManage, %function
_MemManage:
    b _MemManage

.global _BusFault
.type _BusFault, %function
_BusFault:
    b _BusFault

.global _UsageFault
.type _UsageFault, %function
_UsageFault:
    b _UsageFault

.global _SVCall
.type _SVCall, %function
_SVCall:
    b _SVCall

.global _DebugMonitor
.type _DebugMonitor, %function
_DebugMonitor:
    b _DebugMonitor
