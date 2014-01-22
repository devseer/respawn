root = exports ? this

class Engine
	handle: {}

	constructor: (canvas, bgm, sfx) ->
		@handle =
			canvas: canvas
			bgm: bgm
			sfx: sfx
		@map = new Map()
		@player = new Player()
		@timers = new Timers()
		@main(this)

	update: () ->
		@player.update(@map, @timers)
		@map.update()
		@timers.update()

	draw: (handle) ->
		@map.draw(handle)

	main: (c) ->
		c.update()
		c.draw(c.handle)

		requestAnimationFrame(=> @main(c))

unless root.Game
	root.Game = Engine
