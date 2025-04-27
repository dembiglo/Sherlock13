CC = gcc
CFLAGS = -Wall -Wextra -g
SDLFLAGS = `sdl2-config --cflags --libs` -lSDL2_image -lSDL2_ttf -lpthread

all: server sh13

server: server.c
	$(CC) $(CFLAGS) server.c -o server

sh13: sh13.c
	$(CC) $(CFLAGS) sh13.c -o sh13 $(SDLFLAGS)

clean:
	rm -f server sh13
