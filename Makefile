CSCFLAGS += -O5

BIN = $(shell find src -name '*.scm' | sed 's|^src|bin|g;s|\.scm$$||g')

all: $(BIN)

bin/% : src/%.scm
	@mkdir -p bin
	csc $(CSCFLAGS) $< -o $@

clean :
	rm -rf bin

.PHONY : clean
