import dsfml.graphics;
import dsfml.window;
import dsfml.system;
import std.math;

import std.conv : to;
import std.stdio : writeln;

import pipe;
import utils.other;
import utils.vector;

class Bird
{
	RectangleShape bird;
	Texture tbird;
	
	Vector2i displaySize;
	Vector2f size;

	Vector2f gravity;
	Vector2f acc;
	Vector2f vel;
	Vector2f max;

	bool allowUpdate = true;

	this(Vector2i displaySize, double scale)
	{
		this.loadTextures();

		this.gravity = Vector2f(0, 0.5);
		this.acc = Vector2f(0, 0);
		this.vel = Vector2f(0, 0);
		this.max = Vector2f(0, 10);

		this.displaySize = displaySize;
		this.bird = new RectangleShape();
		this.size = this.tbird.getSize() * 4;
		this.bird.size = this.size;
		this.bird.position(Vector2f((this.displaySize.x / 2) - this.size.x / 2, ((this.displaySize.y / 2) - this.size.y / 2) - 50));
		this.bird.setTexture(this.tbird);
		this.bird.fillColor = Color(255, 255, 255);
	}

	void draw(RenderWindow window)
	{
		window.draw(this.bird);
	}

	void update()
	{
		if (this.allowUpdate)
		{
			this.applyForce(gravity);
			this.vel += this.acc;
			this.acc *= 0;
			if (fabs(this.vel.y) > this.max.y)
			{
				if (this.vel.y > 0)
					this.vel.y = this.max.y;
				else
					this.vel.y = -this.max.y;
			}
			this.bird.position(this.bird.position() + this.vel);
			if (this.vel.y < 0)
				this.bird.rotation(-20);
			else if (this.vel.y > 0)
				this.bird.rotation(map(this.vel.y, 0, 10,this.bird.rotation(), 60));
			writeln(this.bird.rotation());
		}
	}

	void applyForce(Vector2f force)
	{
		this.acc += force;
	}

	void jump()
	{
		writeln("Jump!");
		this.applyForce(Vector2f(0, -13));
	}

	bool checkForHit(Pipe[] pipes, Vector2f groundPos)
	{
		Vector2f nextPos = this.bird.position() += this.vel;

		if (nextPos.y + this.bird.size().y - 5 >= groundPos.y)
			this.allowUpdate = false;
		foreach (pipe; pipes)
		{
		 	if (collidesRect(pipe.bottomPipe, this.bird))
		 		this.allowUpdate = false;
		 	if (collidesRect(pipe.topPipe, this.bird))
		 		this.allowUpdate = false;
		}
		return this.allowUpdate;
	}

	void loadTextures()
	{
		this.tbird = new Texture();
		this.tbird.loadFromFile("sprites/bird_middle.png");
	}
}