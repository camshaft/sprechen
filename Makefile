PROJECT = sprechen

# dependencies

DEPS = cowboy cowboy_base jxa-cowboy-router fast_key
dep_cowboy = pkg://cowboy master
dep_cowboy_base = https://github.com/camshaft/cowboy_base.git master
dep_jxa-cowboy-router = https://github.com/camshaft/jxa-cowboy-router.git master
dep_fast_key = https://github.com/camshaft/fast_key.git master

JXA_SRC = $(wildcard src/*.jxa)
JXA_OUT = $(patsubst src/%.jxa, ebin/%.beam, $(JXA_SRC))

TEST_SRC = $(wildcard test/*.jxa)
TEST_OUT = $(patsubst test/%.jxa, ebin/%.beam, $(TEST_SRC))

all: deps app bin/joxa $(JXA_OUT)

include erlang.mk

repl: all
	@ERL_LIBS=deps:. rlwrap ./bin/joxa

bin/joxa:
	@mkdir -p bin
	@curl -L -o $@ https://gist.githubusercontent.com/camshaft/b5f1047d6749459e90a5/raw/joxa
	@chmod +x $@

ebin/%.beam: src/%.jxa
	@ERL_LIBS=deps ./bin/joxa -o ebin -c $<

.PHONY: compile-test
