import globals;

import std.random : uniform;
import std.stdio : writeln;

class Pipe
{
	RectangleShape topPipe;
	RectangleShape bottomPipe;

	Vector2f moveSpeed;

	double sizePer = 6;
	double maxTop;

	this(Texture topPipeTex, Texture bottomPipeTex)
	{
		this.maxTop = size.y / 2 - (size.y / this.sizePer);

		writeln(this.maxTop);

		this.topPipe = new RectangleShape();
		this.topPipe.size = Vector2f(size.x / this.sizePer, topPipeTex.getSize().y * 2.9);
		this.topPipe.fillColor = Color.White;
		this.topPipe.setTexture(topPipeTex);

		this.bottomPipe = new RectangleShape();
		this.bottomPipe.size = Vector2f(size.x / this.sizePer, bottomPipeTex.getSize().y * 2.9);
		this.bottomPipe.fillColor = Color.White;
		this.bottomPipe.setTexture(bottomPipeTex);

		this.moveSpeed = Vector2f(-2.5, 0);

		double loc = uniform(this.maxTop / 1.5, this.maxTop);
		this.topPipe.position = Vector2f(size.x, loc - (this.topPipe.size().y));

		this.bottomPipe.position = Vector2f(size.x, loc + ((size.y / this.sizePer)));
		writeln(this.bottomPipe.position, " ", this.topPipe.position);
	}

	void draw(RenderWindow window)
	{
		window.draw(topPipe);
		window.draw(bottomPipe);
	}

	void update(bool moving = true)
	{
		if (moving)
		{
			this.topPipe.position = this.topPipe.position() + this.moveSpeed;
			this.bottomPipe.position = this.bottomPipe.position() + this.moveSpeed;
		}
	}
}