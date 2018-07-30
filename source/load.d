import globals;
import std.stdio : writeln;

RectangleShape newRectangle(Vector2f size,
							Vector2f position = Vector2f(0, 0),
							Texture texture = null,
							Color color = Color.White)
{
	RectangleShape shape = new RectangleShape();

	shape.size = size;
	shape.fillColor = color;
	shape.setTexture(texture);
	shape.position(position);
	return shape;
}

Texture loadTexture(string filename)
{
	Texture texture = new Texture();
	assert(texture.loadFromFile(filename), "Failed to load image " ~ filename ~ "!");
	return texture;
}