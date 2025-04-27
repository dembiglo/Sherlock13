# ────────────────────────────────────────────────────────────────
# Sherlock 13 – Makefile minimal & ports automatiques
# ────────────────────────────────────────────────────────────────
# Dépendances (Ubuntu/WSL) :
#   sudo apt install build-essential libsdl2-dev \
#        libsdl2-image-dev libsdl2-ttf-dev
# ────────────────────────────────────────────────────────────────

# ↓ Modifie ici si tes fichiers sources ont d'autres noms
SRV_SRC := server.c
CLI_SRC := sh13.c

CC      := gcc
CFLAGS  := -std=c11 -Wall -O2 -g -D_GNU_SOURCE -D_DEFAULT_SOURCE
SDL_C   := $(shell sdl2-config --cflags)
SDL_L   := $(shell sdl2-config --libs) -lSDL2_ttf -lSDL2_image -lpthread

SRV_BIN := server
CLI_BIN := sh13
PORT_SRV := 5000              # port TCP du serveur

# ─── cibles par défaut ──────────────────────────────────────────
all: $(SRV_BIN) $(CLI_BIN)

$(SRV_BIN): $(SRV_SRC)        # compilation du serveur
	$(CC) $(CFLAGS) $< -o $@

$(CLI_BIN): $(CLI_SRC)        # compilation du client SDL2
	$(CC) $(CFLAGS) $(SDL_C) $< -o $@ $(SDL_L)

# ─── nettoyage ─────────────────────────────────────────────────
clean:
	rm -f $(SRV_BIN) $(CLI_BIN) *.o

# ─── exécution pratique ────────────────────────────────────────
run-server: $(SRV_BIN)
	./$(SRV_BIN) $(PORT_SRV)

#  Usage exemple :
#     make run-client NAME=Alice ID=0   (=> port local 6100)
#     make run-client NAME=Bob   ID=1   (=> port local 6101)
NAME ?= Player
ID   ?= 0
PORT_LOCAL := $(shell echo $$((6100 + $(ID))))

run-client: $(CLI_BIN)
	./$(CLI_BIN) 127.0.0.1 $(PORT_SRV) 127.0.0.1 $(PORT_LOCAL) $(NAME)

.PHONY: all clean run-server run-client
