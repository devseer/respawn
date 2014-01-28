class View
	step: true
	wall: '#'
	resource: {}

	constructor: () ->
		@wall = String.fromCharCode(0x2588)
		@viewport =
			x: 0
			y: 0
			height: 9
			width: 9

	inBounds: (x, y) ->
		return x > 0 && y > 0 &&
			x < @resource.map.length &&
			y < @resource.map[0].length

	canMove: (x, y) ->
		return @inBounds(x, y) && @resource.map[x][y]

	mobCollision: (x, y) ->
		for m in @list
			if x == m.pos.x && y == m.pos.y
				console.log('player death')

	nextStep: () ->
		@step = true

	update: (objects) ->
		for k, v of objects
			v.resource(@resource)

	draw: (handle) ->
		output = ''
		x = @resource.pos.x - (@viewport.width >> 1)
		y = @resource.pos.y - (@viewport.height >> 1)

		for i in [y...y + @viewport.height]
			for j in [x...x + @viewport.width]
				if @inBounds(i, j)
					other = false

					for m in @resource.mob
						if m.pos.x == j && m.pos.y == i
							other = true
							output += m.icon + ''

					if not other
						if j == @resource.pos.x && i == @resource.pos.y
							output += '@'
						else
							output += @resource.map[j][i] && ' ' || @wall
				else
					output += @wall
			output += '\n'

		document.body.innerHTML = output
