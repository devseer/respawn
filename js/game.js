// Generated by CoffeeScript 1.6.3
(function() {
  var Engine, Map, Mob, Player, Timer, View, root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Engine = (function() {
    Engine.prototype.objects = {};

    function Engine(canvas, bgm, sfx) {
      this.view = new View();
      this.timer = new Timer();
      this.objects = {
        map: new Map(100, 100),
        player: new Player(),
        mob: new Mob()
      };
      this.view.update(this.objects);
      this.main(this);
    }

    Engine.prototype.update = function(c) {
      var k, v, _ref, _results;
      c.timer.update();
      _ref = c.objects;
      _results = [];
      for (k in _ref) {
        v = _ref[k];
        _results.push(v.update(c.view, c.timer));
      }
      return _results;
    };

    Engine.prototype.main = function(c) {
      var _this = this;
      c.update(c);
      c.view.update(c.objects);
      c.view.draw();
      return requestAnimationFrame(function() {
        return _this.main(c);
      });
    };

    return Engine;

  })();

  if (!root.Game) {
    root.Game = Engine;
  }

  Mob = (function() {
    Mob.prototype.list = [];

    function Mob() {}

    Mob.prototype.resource = function(store) {
      return store.mob = this.list;
    };

    Mob.prototype.update = function(view, timers) {
      if (view.step) {
        this.updateMovement(view);
        this.updatePopulation(view.width, view.height);
        return view.step = false;
      }
    };

    Mob.prototype.updatePopulation = function(width, height) {
      var _results;
      _results = [];
      while (this.list.length < 200) {
        _results.push(this.list.push({
          icon: 'M',
          pos: {
            x: Math.floor(Math.random() * width - 1),
            y: Math.floor(Math.random() * height - 1)
          }
        }));
      }
      return _results;
    };

    Mob.prototype.updateMovement = function(view) {
      var m, nextPos, _i, _len, _ref, _results;
      _ref = this.list;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        m = _ref[_i];
        nextPos = m.pos;
        nextPos.x = this.randomDirection(nextPos.x);
        nextPos.y = this.randomDirection(nextPos.y);
        if (view.canMove(nextPos.x, nextPos.y)) {
          _results.push(m.pos = nextPos);
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    Mob.prototype.randomDirection = function(i) {
      return Math.floor(Math.random() * 2) && i + 1 || i - 1;
    };

    return Mob;

  })();

  Player = (function() {
    Player.prototype.canMove = true;

    Player.prototype.keys = [];

    Player.prototype.pos = {
      x: 20,
      y: 20
    };

    Player.prototype.action = {
      up: 87,
      down: 83,
      left: 65,
      right: 68
    };

    function Player(handle) {
      var i, k, _i;
      for (i = _i = 0; _i <= 255; i = ++_i) {
        this.keys.push(false);
      }
      k = this.keys;
      document.onkeydown = function(e) {
        return k[e.keyCode] = true;
      };
      document.onkeyup = function(e) {
        return k[e.keyCode] = false;
      };
    }

    Player.prototype.resource = function(store) {
      return store.pos = this.pos;
    };

    Player.prototype.update = function(view, timers) {
      var last_x, last_y,
        _this = this;
      last_x = this.pos.x;
      last_y = this.pos.y;
      if (this.canMove) {
        if (this.keys[this.action.up] && view.canMove(this.pos.x, this.pos.y - 1)) {
          this.pos.y--;
        }
        if (this.keys[this.action.down] && view.canMove(this.pos.x, this.pos.y + 1)) {
          this.pos.y++;
        }
        if (this.keys[this.action.left] && view.canMove(this.pos.x - 1, this.pos.y)) {
          this.pos.x--;
        }
        if (this.keys[this.action.right] && view.canMove(this.pos.x + 1, this.pos.y)) {
          this.pos.x++;
        }
      }
      if (this.pos.x !== last_x || this.pos.y !== last_y) {
        this.canMove = false;
        view.nextStep();
        return timers.addTimer(200, function() {
          _this.canMove = true;
          return false;
        });
      }
    };

    return Player;

  })();

  View = (function() {
    View.prototype.step = true;

    View.prototype.wall = '#';

    View.prototype.resource = {};

    function View() {
      this.wall = String.fromCharCode(0x2588);
      this.viewport = {
        width: 9,
        height: 9
      };
    }

    View.prototype.inBounds = function(x, y) {
      return x > 0 && y > 0 && x < this.resource.map.length && y < this.resource.map[0].length;
    };

    View.prototype.canMove = function(x, y) {
      return this.inBounds(x, y) && this.resource.map[x][y];
    };

    View.prototype.mobCollision = function(x, y) {
      var m, _i, _len, _ref, _results;
      _ref = this.list;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        m = _ref[_i];
        if (x === m.pos.x && y === m.pos.y) {
          _results.push(console.log('player death'));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    View.prototype.nextStep = function() {
      return this.step = true;
    };

    View.prototype.update = function(objects) {
      var k, v, _results;
      _results = [];
      for (k in objects) {
        v = objects[k];
        _results.push(v.resource(this.resource));
      }
      return _results;
    };

    View.prototype.draw = function(handle) {
      var i, j, m, other, output, x, y, _i, _j, _k, _len, _ref, _ref1, _ref2;
      output = '';
      x = this.resource.pos.x - (this.viewport.width >> 1);
      y = this.resource.pos.y - (this.viewport.height >> 1);
      for (i = _i = y, _ref = y + this.viewport.height; y <= _ref ? _i < _ref : _i > _ref; i = y <= _ref ? ++_i : --_i) {
        for (j = _j = x, _ref1 = x + this.viewport.width; x <= _ref1 ? _j < _ref1 : _j > _ref1; j = x <= _ref1 ? ++_j : --_j) {
          if (this.inBounds(i, j)) {
            other = false;
            _ref2 = this.resource.mob;
            for (_k = 0, _len = _ref2.length; _k < _len; _k++) {
              m = _ref2[_k];
              if (m.pos.x === j && m.pos.y === i) {
                other = true;
                output += m.icon + '';
              }
            }
            if (!other) {
              if (j === this.resource.pos.x && i === this.resource.pos.y) {
                output += '@';
              } else {
                output += this.resource.map[j][i] && ' ' || this.wall;
              }
            }
          } else {
            output += this.wall;
          }
        }
        output += '\n';
      }
      return document.body.innerHTML = output;
    };

    return View;

  })();

  Map = (function() {
    Map.height = 0;

    Map.width = 0;

    Map.data = [];

    function Map(width, height) {
      this.height = height;
      this.width = width;
      this.newMap();
      this.generate();
    }

    Map.prototype.resource = function(store) {
      return store.map = this.data;
    };

    Map.prototype.update = function() {};

    Map.prototype.newMap = function() {
      var i, j;
      return this.data = (function() {
        var _i, _ref, _results;
        _results = [];
        for (i = _i = 0, _ref = this.width; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
          _results.push((function() {
            var _j, _ref1, _results1;
            _results1 = [];
            for (j = _j = 0, _ref1 = this.height; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
              _results1.push(false);
            }
            return _results1;
          }).call(this));
        }
        return _results;
      }).call(this);
    };

    Map.prototype.generate = function() {
      var i, x, y, _i, _results;
      _results = [];
      for (i = _i = 0; _i < 3000; i = ++_i) {
        x = Math.floor(Math.random() * this.width);
        y = Math.floor(Math.random() * this.height);
        _results.push(this.data[x][y] = true);
      }
      return _results;
    };

    return Map;

  })();

  Timer = (function() {
    Timer.prototype.timestamp = 0;

    Timer.prototype.list = [];

    function Timer() {
      this.updateTime();
    }

    Timer.prototype.update = function() {
      var i, _results;
      this.updateTime();
      _results = [];
      for (i in this.list) {
        if (this.list[i].time < this.timestamp) {
          _results.push(this.executeTimer(this.list[i], i));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    Timer.prototype.addTimer = function(interval, callback) {
      return this.list.push({
        interval: interval,
        time: this.timestamp + interval,
        callback: callback
      });
    };

    Timer.prototype.executeTimer = function(timer, index) {
      if (timer.callback()) {
        return this.renewTimer(timer);
      } else {
        return this.list.splice(index, 1);
      }
    };

    Timer.prototype.renewTimer = function(timer) {
      return timer.time = timer.interval + this.timestamp;
    };

    Timer.prototype.updateTime = function() {
      return this.timestamp = new Date().getTime();
    };

    return Timer;

  })();

}).call(this);
