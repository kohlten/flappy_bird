import globals;

import std.conv : to;
import std.random : uniform;
import std.stdio : writeln;
import std.algorithm;

import bird;
import pipe;
import load;

class Game
{
	RenderWindow	window;
	ContextSettings	settings;
	Color			color;

	Texture			background;
	Texture			ground;
	Texture 		bottomPipe;
	Texture 		topPipe;

	RectangleShape 	rBackground;
	RectangleShape	rGround;

	double 			scale = 4.5;
	long			frames = 0;

	Bird 			bird;
	Pipe[] pipes;

	bool move = true;
	bool wait = true;
	bool pause = false;

	this()
	{
		this.loadTextures();
		this.color = Color.Black;
		this.window = new RenderWindow(VideoMode(size.x, size.y), "Flappy Bird", RenderWindow.Style.Titlebar | RenderWindow.Style.Close);
		this.window.setFramerateLimit(60);
		this.window.setVerticalSyncEnabled(true);
		this.window.setMouseCursorVisible(false);
		this.bird = new Bird(size, this.scale);
	}

	void run()
	{
		while (this.window.isOpen())
		{
			this.getEvents();
			this.update();
			this.window.clear(this.color);
			this.window.draw(this.rBackground);
			this.window.draw(this.rGround);
			foreach (pipe; pipes)
				pipe.draw(this.window);
			this.bird.draw(this.window);
			this.window.display();
		}
	}

	void update()
	{
		if (this.move && !this.wait && !this.pause)
		{
			this.bird.update();
			this.move = this.bird.checkForHit(this.pipes, this.rGround.position());
			if (this.frames % 150 == 0)
				this.pipes ~= new Pipe(this.topPipe, this.bottomPipe);
			foreach (pipe; pipes)
			{
				pipe.update();
				if (pipe.bottomPipe.position().x < -pipe.bottomPipe.size().x)
					this.pipes = remove!(a => a == pipe)(this.pipes);
			}
			this.frames++;
		}
	}

	void getEvents()
	{
		Event event;
		while (this.window.pollEvent(event))
		{
			if (event.type == Event.EventType.Closed)
				window.close();
			if (event.type == Event.EventType.MouseButtonPressed)
			{
				if (this.wait)
						this.wait = false;
				this.bird.jump();
			}
			if (event.type == Event.EventType.KeyPressed)
				if (event.key.code == Keyboard.Key.Space)
				{
					if (this.wait)
						this.wait = false;
					this.bird.jump();
				}
			if (event.type == Event.EventType.LostFocus)
    			this.pause = true;

			if (event.type == Event.EventType.GainedFocus)
    			this.pause = false;
		}
	}

	void loadTextures()
	{
		this.background = loadTexture("sprites/background.png");
		this.ground = loadTexture("sprites/ground.png");
		this.bottomPipe = loadTexture("sprites/tube_up.png");
		this.topPipe = loadTexture("sprites/tube_down.png");

		if (!this.background || !this.ground || !this.bottomPipe || !this.topPipe)
			writeln("Failed to load a sprite");

		this.rBackground = newRectangle(Vector2f(size), Vector2f(0, 0), this.background);

		this.rGround = newRectangle(Vector2f(size.x, size.y / this.scale),
									Vector2f(0, size.y - (size.y / this.scale)),
									this.ground);
	}
}
