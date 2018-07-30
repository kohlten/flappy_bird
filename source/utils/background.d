module background;

import dsfml.graphics;

class Background
{
	Texture background;
	Sprite drawable;

	this()
	{
		this.background = new Texture();
		this.drawable = new Sprite();
		this.background.loadFromFile("images/PNG/Backgrounds/colored_grass.png");
		this.drawable.setTexture(this.background);
		this.drawable.color(Color(255, 255, 255));
	}

	void draw(RenderWindow window)
	{
		window.draw(this.drawable);
	}
}