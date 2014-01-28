class Map
	@height: 0
	@width: 0
	@data: []

	constructor: (width, height) ->
		@height = height
		@width = width
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
		for i in [0...3000]
			x = Math.floor(Math.random() * @width)
			y = Math.floor(Math.random() * @height)
			@data[x][y] = true
