class Map
	@width: 0
	@height: 0
	@data: []

	constructor: (width, height) ->
		@width = width
		@height = height
		@newMap()
		@generate()

	resource: (store) ->
		store.map = @data

	update: ->

	newMap: ->
		@data = for i in [0...@width]
			for j in [0...@height]
				false

	generate: ->
		size =
			width: 9
			height: 9

		grid =
			width: Math.floor(@width / size.width)
			height: Math.floor(@height / size.height)

		room = for i in [0...grid.width]
			for j in [0...grid.height]
				[]

		next = @reroll(grid)

		for i in [0...64]
			neighbour = @randomNeighbour(next)
			if @boundsCheck(neighbour, grid)
				room[next.x][next.y].push(neighbour)
				next = neighbour
			else
				next = @reroll(grid)

		@fillCells(grid, size, room)

	reroll: (dimensions) ->
		x: Math.floor(Math.random() * dimensions.width)
		y: Math.floor(Math.random() * dimensions.height)

	fillCells: (dimensions, size, room) ->
		for i in [0...dimensions.width - 1]
			for j in [0...dimensions.height - 1]
				if room[i][j].length
					@fillRoom(i * size.width, j * size.height, size.width, size.height)
					@fillPath(
						i * size.width, j * size.height,
						room[i][j][0].x * size.width, room[i][j][0].y * size.height,
						size.width, size.height
					)

	fillRoom: (x, y, width, height) ->
		scale = Math.floor(Math.random() * 3) + 1
		px = x + scale
		py = y + scale
		pwidth = x + width - scale
		pheight = y + height - scale

		for i in [px...pwidth]
			for j in [py...pheight]
				@data[i][j] = true

	fillPath: (fx, fy, tx, ty, width, height) ->
		offsetwidth = Math.floor(width / 2)
		offsetheight = Math.floor(height / 2)

		if fx == tx
			for i in [fy...ty]
				@data[fx + offsetwidth][i + offsetheight] = true
		else
			for i in [fx...tx]
				@data[i + offsetwidth][fy + offsetheight] = true

	boundsCheck: (pos, area) ->
		return pos.x > 0 && pos.x < area.width && pos.y > 0 && pos.y < area.height

	randomNeighbour: (pos) ->
		if Math.floor(Math.random() * 2)
			neighbour =
				x: pos.x
				y: pos.y + (Math.floor(Math.random() * 2) && 1 || -1)
		else
			neighbour =
				x: pos.x + (Math.floor(Math.random() * 2) && 1 || -1)
				y: pos.y
		return neighbour

