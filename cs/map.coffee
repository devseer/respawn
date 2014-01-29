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
			width: 7
			height: 7

		grid =
			width: Math.floor(@width / size.width)
			height: Math.floor(@height / size.height)

		room = for i in [0...grid.width]
			for j in [0...grid.height]
				[]

		next = @reroll(grid)

		for i in [0...64]
			#if room[next.x][next.y].length > 0
			#	next = @reroll(grid)
			#else
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

	fillRoom: (x, y, width, height) ->
		px = x + 1
		py = y + 1
		pwidth = x + width - 1
		pheight = y + height - 1
		for i in [px...pwidth]
			for j in [py...pheight]
				@data[i][j] = true

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

