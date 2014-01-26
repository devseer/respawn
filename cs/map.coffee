class Map
	list: []

	constructor: () ->
		@height = 100
		@width = 100

		@viewport =
			x: 0
			y: 0
			height: 9
			width: 9

		@data = for i in [0...@width]
			for j in [0...@height]
				Math.random() > 0.8 && '#' || '.'

	update: () ->

	inBounds: (x, y) ->
		return x > 0 && y > 0 && x < @data.length && y < @data[0].length

	canMove: (x, y) ->
		return @inBounds(x, y) && @data[x][y] == '.'

	updateViewport: (x, y) ->
		@viewport.x = x - (@viewport.width >> 1)
		@viewport.y = y - (@viewport.height >> 1)

	inject: (mobs) ->
		@list = mobs

	draw: (handle) ->
		output = ''
		center =
			x: @viewport.x + (@viewport.width >> 1)
			y: @viewport.y + (@viewport.height >> 1)

		for i in [@viewport.y...@viewport.y + @viewport.height]
			for j in [@viewport.x...@viewport.x + @viewport.width]
				if @inBounds(i, j)
					other = false

					for m in @list
						if m.pos.x == j && m.pos.y == i
							other = true
							output += m.icon

					if not other
						output += ((j == center.x && i == center.y) && '@' || @data[j][i]) + ' '
				else
					output += '  '
			output += '\n'

		document.body.innerHTML = output
