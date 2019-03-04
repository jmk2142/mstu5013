# API NOTES to Bits and Atoms Game

## Available routes:

- /players/new/NAME
- /players/PID
- /players/PID/games/new
- /players/PID/games/join
- /players/PID/games/resume
- /players/PID/games/GID/join
- /players/PID/games/GID
- /players/PID/games/GID/autoplay
- /players/PID/games/GID/play/CARD

### players/new/NAME
PARAMS: NAME <String>
E.g. http://treasure.chrisproctor.net/players/new/aardvark
```
{
	"pid": 42251,
	"name": "aardvark"
}
```

### players/PID
PARAMS: PID <Number>
E.g. http://treasure.chrisproctor.net/players/42251
```
{
	"games_complete": [],
	"games_cancelled": [],
	"games_waiting": [],
	"games_playing": [],
	"pid": 42251,
	"stats": {
		"losses": 0,
		"wins": 0
	},
	"name": "aardvark"
}
```

### players/PID/games/new
PARAMS: PID <Number>
E.g. http://treasure.chrisproctor.net/players/42251/games/new
```
{
	"status": "waiting for players",
	"turns": [],
	"players": {
		"aardvark": {
			"score": 0,
			"hand": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
		}
	},
	"gid": 155113
}
```

### players/PID/games/join
PARAMS: PID <Number>
E.g. http://treasure.chrisproctor.net/players/42251/games/join
```
{
	"status": "playing",
	"turns": [{
		"treasure": 7
	}],
	"players": {
		"aardvark": {
			"score": 0,
			"hand": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
		}
	},
	"gid": 522135
}
```

### players/PID/games/resume
PARAMS: PID <Number>
E.g. http://treasure.chrisproctor.net/players/42251/games/resume
```
{
	"status": "playing",
	"turns": [{
		"treasure": 7
	}],
	"players": {
		"aardvark": {
			"score": 0,
			"hand": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
		}
	},
	"gid": 522135
}
```

### players/PID/games/GID/join
PARAMS: PID <Number>, GID <Number>
E.g. http://treasure.chrisproctor.net/players/56112/games/155113/join
```
{
	"status": "playing",
	"turns": [{
		"treasure": 10
	}],
	"players": {
		"alpha": {
			"score": 0,
			"hand": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
		},
		"aardvark": {
			"score": 0,
			"hand": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
		}
	},
	"gid": 155113
}
```
OR
```
{
	"error": "cannot join game"
}
```

### players/PID/games/GID
PARAMS: PID <Number>, GID <Number>
E.g. http://treasure.chrisproctor.net/players/42251/games/155113
```
{
	"status": "playing",
	"turns": [{
		"treasure": 10
	}],
	"players": {
		"alpha": {
			"score": 0,
			"hand": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
		},
		"aardvark": {
			"score": 0,
			"hand": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
		}
	},
	"gid": 155113
}
```

### players/PID/games/GID/autoplay
PARAMS: PID <Number>, GID <Number>
E.g. http://treasure.chrisproctor.net/players/42251/games/155113/autoplay
```
{
	"status": "playing",
	"turns": [{
		"treasure": 5
	}],
	"players": {
		"aardvark": {
			"score": 0,
			"hand": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
		},
		"bot": {
			"score": 0,
			"hand": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
		}
	},
	"gid": 516336
}
```
OR
```
{
	"error": "game already started"
}
```

### players/PID/games/GID/play/CARD
PARAMS: PID <Number>, GID <Number>, CARD <Number>
E.g. http://treasure.chrisproctor.net/players/42251/games/155113/play/13
```
{
	"status": "playing",
	"turns": [{
		"aardvark": 13,
		"treasure": 10
	}],
	"players": {
		"alpha": {
			"score": 0,
			"hand": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
		},
		"aardvark": {
			"score": 0,
			"hand": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
		}
	},
	"gid": 155113
}
```

# CHALLENGE

Integrate the Bits and Atoms API + Data with our LocalStorage.

Currently, this app can use the Bits and Atoms API to create a new player, and find a player based on the PID.

Separately, this app can store data about the user (i.e. happiness, food, code, color).

However, this application cannot save data for multiple player profiles.

Example:

- New Player > Aardvark > Configure happiness, food, code, color.
- New Player > Zebra > Configure happiness, food, code, color.
- Find Player > Aardvark PID > Load Aardvark's config data.
- Find Player > Zebra PID > Load Zebra's config data.

Refactor the code so that the application can store multiple player/user configurations.

When refreshing the application, the LAST player's configuration should automatically load on start.
