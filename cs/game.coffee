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

	update: (c) ->
		c.timer.update()
		for k, v of c.objects
			v.update(c.view, c.timer)

	main: (c) ->
		c.update(c)
		c.view.update(c.objects)
		c.view.draw()

		requestAnimationFrame(=> @main(c))

unless root.Game
	root.Game = Engine
