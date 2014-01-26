class Player
	canMove: true
	keys: []

	pos:
		x: 20
		y: 20

	action:
		attack: 32
		up: 87
		down: 83
		left: 65
		right: 68

	constructor: (handle) ->
		for i in [0..255]
			@keys.push(false)

		k = @keys
		document.onkeydown = (e) ->
			k[e.keyCode] = true

		document.onkeyup = (e) ->
			k[e.keyCode] = false

	update: (map, timers) ->
		last_x = @pos.x
		last_y = @pos.y

		if @canMove
			if @keys[@action.up] && map.canMove(@pos.x, @pos.y - 1) then @pos.y--
			if @keys[@action.down] && map.canMove(@pos.x, @pos.y + 1) then @pos.y++
			if @keys[@action.left] && map.canMove(@pos.x - 1, @pos.y) then @pos.x--
			if @keys[@action.right] && map.canMove(@pos.x + 1, @pos.y) then @pos.x++

		if @pos.x != last_x || @pos.y != last_y
			@canMove = false
			timers.addTimer(200, () =>
				@canMove = true
				return false
			)

		map.updateViewport(@pos.x, @pos.y)
