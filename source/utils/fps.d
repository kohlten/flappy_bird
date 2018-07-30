import dsfml.graphics;
import dsfml.window;
import dsfml.system;

import std.conv : to;

class FPS
{
	Duration		last;
	int 			frames;
	Text 			fps;

	this(Font font)
	{
		this.setUpFPS(font);
	}

	void update(RenderWindow window, Font font, Clock clock)
	{
		Duration current = clock.getElapsedTime();
		if ((current - last).total!"seconds" >= 1)
		{
			this.fps.setString(to!string(this.frames));
			this.last = current;
			this.frames = 0;
		}
		this.frames++;
		window.draw(this.fps);
	}

	void setUpFPS(Font font)
	{
		this.fps = new Text();

		this.fps.setFont(font);
		this.fps.setString("0");
		this.fps.setCharacterSize(20);
		this.fps.setColor(Color.Green);
	}
}