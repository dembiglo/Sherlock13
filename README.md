# Sherlock 13 (SH13)

## Description
Sherlock 13 est une adaptation en C du jeu de société "Sherlock 13".  
Ce projet utilise :
- des sockets TCP pour la communication serveur-client,
- la bibliothèque SDL2 pour l'affichage graphique des clients.

Il contient deux programmes :
- `server` : gère la logique du jeu côté serveur,
- `sh13` : client graphique pour jouer.

---

## Installation

### Prérequis
Avant de compiler, vous devez avoir installé :
- `gcc` (compilateur C)
- `make`
- `libsdl2-dev`
- `libsdl2-image-dev`
- `libsdl2-ttf-dev`
- `pthread` (en général déjà inclus)

Pour installer les dépendances sur Ubuntu/Debian :

```bash
sudo apt update
sudo apt install gcc make libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev
```

---

## Compilation

Utilisez `make` :

```bash
make
```

Cela compile automatiquement :
- `server`
- `sh13`

Le `Makefile` utilisé est :

```makefile
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
```

Pour nettoyer les exécutables :

```bash
make clean
```

---

## Exécution

### 1. Lancer le serveur

Sur une machine (serveur ou locale), lancez :

```bash
./server <port>
```

Exemple :

```bash
./server 12345
```

**Le serveur doit être lancé avant les clients !**

---

### 2. Lancer les clients

Chaque joueur doit exécuter le client `sh13` :

```bash
./sh13 <ip serveur> <port serveur> <ip client> <port client> <nom joueur>
```

Exemple :

```bash
./sh13 127.0.0.1 12345 127.0.0.1 4000 Sherlock
```

⚠️ **Attention** :
- Chaque joueur doit utiliser **un port client différent** (ex: 4000, 4001, 4002, 4003).
- Il faut exactement **4 joueurs** pour démarrer la partie.

---

## Fonctionnement du Jeu

- Cliquez sur **Connect** pour vous connecter au serveur.
- Une fois 4 joueurs connectés, la partie commence.
- Utilisez les boutons pour :
  - Questionner un joueur,
  - Interroger sur un objet,
  - Accuser directement (guilt).
- Le bouton **Go** permet d'envoyer votre action.
- Quand un joueur trouve le coupable, la partie se termine.

---

## Ressources nécessaires

Placez dans le dossier du projet :
- Les images : `SH13_0.png`, `SH13_1.png`, ..., `SH13_12.png`
- Les objets : `SH13_pipe_120x120.png`, etc.
- Les boutons : `gobutton.png`, `connectbutton.png`
- La police : `sans.ttf`

---

## Conseils d'affichage (Linux)

Si vous utilisez WSL ou un environnement sans affichage graphique :

```bash
export DISPLAY=:0
```

Puis utilisez un serveur X11 local (comme Xming ou VcXsrv sur Windows).

---

## Auteurs

- Projet réalisé par Gloire DEMBI.


