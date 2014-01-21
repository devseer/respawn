class Map
	constructor: () ->
		height = 100
		width = 100

		@viewport =
			x: 0
			y: 0
			height: 9
			width: 9

		@data = for i in [0...width]
			for j in [0...height]
				'.'

	update: () ->

	draw: (handle) ->
		output = ''
		center =
			x: @viewport.x + @viewport.width >> 1
			y: @viewport.y + @viewport.height >> 1

		for i in [@viewport.x...@viewport.x + @viewport.width]
			for j in [@viewport.y...@viewport.y + @viewport.height]
				output += ((i == center.x && j == center.y) && '@' || @data[i][j]) + ' '
			output += '\n'

		document.body.innerHTML = output
