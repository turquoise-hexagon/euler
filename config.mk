CSC ?= csc

SRC = solution.scm
BIN = $(basename $(SRC))

all : CSCFLAGS += -O5
all : $(BIN)

debug : CSCFLAGS += -O0 -d3
debug : $(BIN)

$(BIN) : $(SRC)
	$(CSC) $(CSCFLAGS) $<

clean :
	rm -f $(BIN)
	rm -f $(BIN).link

.PHONY : all debug clean
