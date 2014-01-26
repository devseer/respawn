class Mob
	list: []
	constructor: ->

	update: (map, timers) ->
		while @list.length < 200
			@list.push(
				icon: 'M'
				pos:
					x: Math.floor(Math.random() * map.width - 1)
					y: Math.floor(Math.random() * map.height - 1)
			)

		map.inject(@list)
