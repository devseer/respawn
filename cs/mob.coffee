class Mob
	list: []
	constructor: ->

	resource: (store) ->
		store.mob = @list

	update: (view, timers) ->
		if view.step
			@updateMovement(view)
			@updatePopulation(view.width, view.height)
			view.step = false

	updatePopulation: (width, height) ->
		while @list.length < 200
			@list.push(
				icon: 'M'
				pos:
					x: Math.floor(Math.random() * width - 1)
					y: Math.floor(Math.random() * height - 1)
			)

	updateMovement: (view) ->
		for m in @list
			nextPos = m.pos
			nextPos.x = @randomDirection(nextPos.x)
			nextPos.y = @randomDirection(nextPos.y)

			if view.canMove(nextPos.x, nextPos.y)
				m.pos = nextPos

	randomDirection: (i) ->
		return Math.floor(Math.random() * 2) && i+1 || i-1
