import globals;

import std.conv : to;
import std.random : uniform;
import std.stdio : writeln;
import std.algorithm;

import bird;
import pipe;

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

	this()
	{
		this.loadTextures();
		this.color = Color.Black;
		this.window = new RenderWindow(VideoMode(size.x, size.y), "Flappy Bird");
		this.window.setFramerateLimit(60);
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
		this.bird.update();
		this.bird.checkForHit(this.pipes, this.rGround.position());
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

	void getEvents()
	{
		Event event;
		while (this.window.pollEvent(event))
		{
			if (event.type == Event.EventType.Closed)
				window.close();
			if (event.type == Event.EventType.MouseButtonPressed)
			{}
			if (event.type == Event.EventType.KeyPressed)
				if (event.key.code == Keyboard.Key.Space)
					this.bird.jump();
		}
	}

	void loadTextures()
	{
		this.background = new Texture();
		this.background.loadFromFile("sprites/background.png");

		this.rBackground = new RectangleShape();
		size = Vector2i(600, 800);
		this.rBackground.size = Vector2f(size);
		this.rBackground.fillColor = Color.White;
		this.rBackground.setTexture(this.background);

		this.ground = new Texture();
		this.ground.loadFromFile("sprites/ground.png");

		this.rGround = new RectangleShape();
		this.rGround.size = Vector2f(size.x, size.y / this.scale);
		this.rGround.fillColor = Color.White;
		this.rGround.setTexture(this.ground);
		this.rGround.position(Vector2f(0, size.y - (size.y / this.scale)));

		this.bottomPipe = new Texture();
		this.bottomPipe.loadFromFile("sprites/tube_up.png");

		this.topPipe = new Texture();
		this.topPipe.loadFromFile("sprites/tube_down.png");
	}
}