# ugh fuck you just work T_T

ELM_FILES := $(wildcard src/*.elm)

all: $(ELM_FILES)
	elm make src/App.elm --optimize --output=main.js
	uglifyjs main.js --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=main.min.js

dev: $(ELM_FILES)
	elm make src/App.elm --output=main.dev.js
