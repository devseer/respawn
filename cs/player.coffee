class Player
	keys: []

	pos:
		x: 20
		y: 20

	action:
		attack: 32
		up: 82
		down: 72
		left: 83
		right: 84

	constructor: (handle) ->
		for i in [0..255]
			@keys.push(false)

		k = @keys
		document.onkeydown = (e) ->
			k[e.keyCode] = true

		document.onkeyup = (e) ->
			k[e.keyCode] = false

	update: (map) ->
		if @keys[@action.up] && map.canMove(@pos.x, @pos.y - 1) then @pos.y--
		if @keys[@action.down] && map.canMove(@pos.x, @pos.y + 1) then @pos.y++
		if @keys[@action.left] && map.canMove(@pos.x - 1, @pos.y) then @pos.x--
		if @keys[@action.right] && map.canMove(@pos.x + 1, @pos.y) then @pos.x++
		map.updateViewport(@pos.x, @pos.y)
