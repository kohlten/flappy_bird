import dsfml.graphics;
import dsfml.window;
import dsfml.system;

import std.conv : to;
import std.random : Random, unpredictableSeed, uniform;
import std.stdio : writeln;

class Game
{
	RenderWindow window;
	Vector2i size;
	Color color;
	ContextSettings settings;
	Random rng;
	Texture background;
	Texture ground;
	RectangleShape rBackground;
	RectangleShape rGround;

	this(Random rng)
	{
		this.size.x = 500;
		this.size.y = 800;
		this.color = Color(0, 0, 0);
		this.window = new RenderWindow(VideoMode(this.size.x, this.size.y), "Mines");
		this.window.setFramerateLimit(60);
		this.loadTextures();
		this.rng = rng;
	}

	void run()
	{
		while (this.window.isOpen())
		{
			this.getEvents();
			this.window.clear(this.color);
			this.window.draw(this.rBackground);
			this.window.draw(this.rGround);
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
		this.rBackground.size = to!Vector2f(this.size);
		this.rBackground.fillColor = Color(255, 255, 255);
		this.rBackground.setTexture(this.background);
		this.ground = new Texture();
		this.ground.loadFromFile("sprites/ground.png");
		this.rGround = new RectangleShape();
		this.rGround.size = Vector2f(169 * 3, 59 * 3);
		this.rGround.fillColor = Color(255, 255, 255);
		this.rGround.setTexture(this.ground);
		this.rGround.position(Vector2f(-4, (this.size.y / 4) * 3 + 24));
	}
}