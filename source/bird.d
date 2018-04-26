import dsfml.graphics;
import dsfml.window;
import dsfml.system;

import std.conv : to;
import std.stdio : writeln;

class Bird
{
	RectangleShape bird;
	Texture tbird;
	Vector2i displaySize;
	Vector2f size;

	this(Vector2i displaySize, Texture tbird, int scale)
	{
		this.displaySize = displaySize;
		this.tbird = tbird;
		this.bird = new RectangleShape();
		this.size = this.tbird.getSize() * 4;
		this.bird.size = this.size;
		this.bird.position(Vector2f(((this.displaySize.x / 2) - this.size.x / 2), ((this.displaySize.y - ) / 2) - this.size.y / 2));
		this.bird.setTexture(this.tbird);
		this.bird.fillColor = Color(255, 255, 255);
	}

	void draw(RenderWindow window)
	{
		window.draw(this.bird);
	}

	void update()
	{

	}
}