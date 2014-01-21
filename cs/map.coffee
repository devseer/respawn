class Map
	constructor: () ->
		@height = 100
		@width = 100
		@viewport =
			x: 0
			y: 0

		@data = for i in [0...width]
			for j in [0...height]
				'.'

	update: () ->

	draw: (handle) ->
		output = ''
		(output += tile.join(' ') + '\n') for tile in @data
		document.body.innerHTML = output
