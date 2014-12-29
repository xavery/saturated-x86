CFLAGS := -DDEBUG -ggdb
PROGNAME := sadd
SOURCES := sadd.c sadd_impl.asm
OBJECTS := $(addsuffix .o,$(basename $(SOURCES)))
LISTINGS := $(addsuffix .lst,$(filter %.asm,$(SOURCES)))

all : $(PROGNAME)

$(PROGNAME) : $(OBJECTS)

%.o : %.asm
	nasm -f elf64 -F dwarf -o $@ -l $<.lst $<

.PHONY : clean

clean :
	$(RM) $(OBJECTS) $(PROGNAME) $(LISTINGS)
