class Map
	constructor: () ->
		@data = [
			['.','.','.','.','.'],
			['.','.','.','.','.'],
			['.','.','.','.','.'],
			['.','.','.','.','.']]

	update: () ->

	draw: (handle) ->
		output = ''
		(output += tile.join(' ') + '<br />') for tile in @data
		document.body.innerHTML = output
