CC=arm-none-eabi-gcc
LD=arm-none-eabi-ld
OBJCOPY=arm-none-eabi-objcopy

LINKER_SCRIPT=simple.ld

ASFLAGS=-S -mcpu=cortex-m4 -mfloat-abi=hard -g -mthumb
CFLAGS=-c -mcpu=cortex-m4 -mfloat-abi=hard -g -mthumb -falign-functions=4
LDFLAGS=--verbose -T $(LINKER_SCRIPT) -nostartfiles

main.bin : main.elf
	$(OBJCOPY) -O binary $< $@

main.elf : reset.o crt0.o main.o huh.o $(LINKER_SCRIPT)
	$(LD) $(LDFLAGS) $(filter %.o,$^) -o $@

main.o : main.c
	$(CC) $(CFLAGS) $< -o $@

crt0.o : crt0.S
	$(CC) $(CFLAGS) $< -o $@

reset.o : reset.S
	$(CC) $(CFLAGS) $< -o $@
	
huh.S : huh.c
	$(CC) $(ASFLAGS) $< -o $@

huh.o : huh.S
	$(CC) $(CFLAGS) $< -o $@

qemu : main.bin
	/home/ner/development/qemu/build/qemu-system-arm -machine netduinoplus2 -cpu cortex-m4 -kernel main.bin -s -S || reset

gdb :
	gdb-multiarch  -x init.gdb

clean :
	rm -f main.bin main.elf *.o huh.S
