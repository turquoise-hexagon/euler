CSC      ?= csc
CSCFLAGS ?= -O5

BIN = $(shell find . -name 'problem*.scm' | sed 's|\.scm$$||g')

all : $(BIN)

% : %.scm
	$(CSC) $(CSCFLAGS) $<

clean :
	rm -f $(BIN)

.PHONY : all clean
