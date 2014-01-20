root = exports ? this

class Engine
	handle: {}

	constructor: (canvas, bgm, sfx) ->
		@handle =
			canvas: canvas
			bgm: bgm
			sfx: sfx

		@main(this)

	update: () ->

	draw: () ->

	main: (c) ->
		c.update()
		c.draw()

		requestAnimationFrame(=> @main(c))

unless root.Game
	root.Game = Engine
