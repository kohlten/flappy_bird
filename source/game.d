import dsfml.graphics;
import dsfml.window;
import dsfml.system;

import std.conv : to;
import std.random : Random, unpredictableSeed, uniform;
import std.stdio : writeln;
import bird;

class Game
{
	Random			rng;

	RenderWindow	window;
	Vector2i		size;
	ContextSettings	settings;
	Color			color;

	Texture			background;
	Texture			ground;
	Texture			tbird;
	RectangleShape 	rBackground;
	RectangleShape	rGround;

	int 			scale = 4;

	Bird 			bird;

	this(Random rng)
	{
		this.loadTextures();
		this.color = Color(0, 0, 0);
		this.window = new RenderWindow(VideoMode(this.size.x, this.size.y), "Flappy Bird");
		this.window.setFramerateLimit(60);
		this.rng = rng;
		this.bird = new Bird(this.size, this.tbird, this.scale);
	}

	void run()
	{
		while (this.window.isOpen())
		{
			this.getEvents();
			this.window.clear(this.color);
			this.window.draw(this.rBackground);
			this.window.draw(this.rGround);
			this.bird.draw(this.window);
			this.window.display();
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
			{}
			if (event.type == Event.EventType.KeyPressed)
			{}
		}
	}

	void loadTextures()
	{
		this.background = new Texture();
		this.background.loadFromFile("sprites/background.png");
		this.rBackground = new RectangleShape();
		this.size = this.background.getSize() * this.scale;
		this.rBackground.size = Vector2f(this.size);
		this.rBackground.fillColor = Color(255, 255, 255);
		this.rBackground.setTexture(this.background);
		this.ground = new Texture();
		this.ground.loadFromFile("sprites/ground.png");
		this.rGround = new RectangleShape();
		this.rGround.size = to!Vector2f(this.ground.getSize() * this.scale);
		this.rGround.fillColor = Color(255, 255, 255);
		this.rGround.setTexture(this.ground);
		this.rGround.position(Vector2f(-4, ((this.size.y / this.scale) * (this.scale - 1)) + 40));
		this.tbird = new Texture();
		this.tbird.loadFromFile("sprites/bird_middle.png");
	}
}