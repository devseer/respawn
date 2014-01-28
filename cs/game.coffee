root = exports ? this

class Engine
	objects: {}

	constructor: (canvas, bgm, sfx) ->
		@view = new View()
		@timer = new Timer()

		@objects =
			map: new Map(100, 100)
			player: new Player()
			mob: new Mob()

		@view.update(@objects)
		@main(this)

	update: () ->
		@timer.update()
		o.update(@view, @timer) for o in @objects

	main: (c) ->
		c.update()
		c.view.update(c.objects)
		c.view.draw()

		requestAnimationFrame(=> @main(c))

unless root.Game
	root.Game = Engine
