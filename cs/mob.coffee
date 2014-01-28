class Mob
	list: []
	constructor: ->

	update: (view, timers) ->
		if view.step
			@updateMovement(view)
			@updatePopulation(view.width, view.height)
			view.updateMobs(@list)
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
			nextPos.x += Math.round(Math.random() - 1)
			nextPos.y += Math.round(Math.random() - 1)

			if view.canMove(nextPos.x, nextPos.y)
				m.pos = nextPos
