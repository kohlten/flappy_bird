module utils.other;

import globals;

import std.random;
import std.stdio;
import std.math;



/**
 * rotateCenter takes a object that uses dsfml.graphics.transformable,
 * and rotates it by degrees and then returns that object.
 * See also http://dsfml.com/dsfml/graphics/transformable.html
 */

O rotateCenter(O)(O object, float degrees)
{
	if (isNaN(degrees))
		degrees = 0;
	object.origin(object.size / 2);
	object.rotation(degrees);
	return object;
}

/**
 * getRandomObject returns a random object from the list objects.
 */
O getRandomObject(O)(O[] objects)
{
	ulong index = uniform(0, objects.length);
	return (objects[index]);
}

/**
 * getRandomObject returns a random object from the list objects using suppilied rng.
 */
O getRandomObject(O)(O[] objects, Random rng)
{
	ulong index = uniform(0, objects.length, rng);
	return objects[index];
}

//https://github.com/SFML/SFML/wiki/Source%3A-Simple-Collision-Detection

/**
 * collidesRect takes two shapes and checks if they are intersecting in any way.
 * Returns a true if they are and false otherwise. Not to be used when you want perfect collisions,
 * look at pixelPerfectCollision for that.
 * Also look at http://dsfml.com/dsfml/graphics/transformable.html
 */
bool collidesRect(ShapeOne, ShapeTwo)(ShapeOne shapeone, ShapeTwo shapetwo)
{
	if (shapeone.getGlobalBounds().intersects(shapetwo.getGlobalBounds()))
		return true;
	return false;
}

bool pixelPerfectCollision(ShapeOne, ShapeTwo)(ShapeOne shapeone, ShapeTwo shapetwo)
{
	if (collidesRect(shapeone, shapetwo))
	{
		Image texOne = shapeone.getTexture().copyToImage();
		Image texTwo = shapetwo.getTexture().copyToImage();
		Vector2f posOne = shapeone.position();
		Vector2f posTwo = shapetwo.position();
		Vector2f sizeOne = shapeone.size();
		Vector2f sizeTwo = shapetwo.size();


	}
}

float degreesToRaidians(float degrees)
{
	return degrees * (PI / 180);
}

float radiansToDegrees(float radians)
{
	return radians * (180 / PI);
}
