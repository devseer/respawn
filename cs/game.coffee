root = exports ? this

class Engine
	handle: {}

	constructor: (canvas, bgm, sfx) ->
		@handle =
			canvas: canvas
			bgm: bgm
			sfx: sfx
		@view = new View()
		@timers = new Timers()

		@player = new Player()
		@mob = new Mob()
		@main(this)

	update: () ->
		@player.update(@view, @timers)
		@mob.update(@view, @timers)
		@timers.update()

	main: (c) ->
		c.update()
		c.view.draw(c.handle)

		requestAnimationFrame(=> @main(c))

unless root.Game
	root.Game = Engine
