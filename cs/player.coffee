class Player
	canMove: true
	keys: []

	pos:
		x: 20
		y: 20

	action:
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

	resource: (store) ->
		store.pos = @pos

	update: (view, timers) ->
		last_x = @pos.x
		last_y = @pos.y

		if @canMove
			if @keys[@action.up] && view.canMove(@pos.x, @pos.y - 1) then @pos.y--
			if @keys[@action.down] && view.canMove(@pos.x, @pos.y + 1) then @pos.y++
			if @keys[@action.left] && view.canMove(@pos.x - 1, @pos.y) then @pos.x--
			if @keys[@action.right] && view.canMove(@pos.x + 1, @pos.y) then @pos.x++

		if @pos.x != last_x || @pos.y != last_y
			@canMove = false
			view.nextStep()

			timers.addTimer(200, () =>
				@canMove = true
				return false
			)
