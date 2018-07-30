module utils.vector;

import globals;
import std.math;

/**
 * getHeading returns the current direction of a vector in
 * degrees or radians. 
 */
float getHeading(V)(V vector, bool degrees = true)
{
	if (degrees)
		return atan2(vector.y, vector.x) * 180 / PI;
	else
		return atan2(vector.y, vector.x);
}

/**
 * getMag returns the current magnitude of a vector.
 */
float getMag(V)(V pos)
{
	return sqrt(pos.x * pos.x + pos.y * pos.y);
}

/**
 * normalize returns the vector as a length of one.
 */
V normalize(V)(V pos)
{
	float mag = getMag!(V)(pos);
	if (mag == 0)
		return pos;
	return pos / mag; 
}

/**
 * setMag normalizes a vector and then times it by n.
 */
V setMag(V)(V pos, float n)
{
	return pos.normalize!(V)() * n;
}

/**
 * dist the distance between two vectors.
 */
float dist(V)(V v1, V v2)
{
	return hypot(v2.x - v1.x, v2.y - v1.y);
}

/**
 * constrain takes a number and a low and a high to return a number in between that range.
 */
N constrain(N)(N n, N low, N high)
{
	return fmax(fmin(n, high), low);
}

/**
 * map returns a number between a range of start 1 and stop 1 to a range of start2 and stop2.
 * if constrain is true, will make sure that value is between the ending range.
 */
N map(N)(N n, N start1, N stop1, N start2, N stop2, bool withinBounds = false)
{
	N newval = (n - start1) / (stop1 - start1) * (stop2 - start2) + start2;
	if (!withinBounds)
		return newval;
	if (start2 < stop2)
		return constrain!(N)(newval, start2, stop2);
	else
		return constrain!(N)(newval, stop2, start2);
}

/**
 * rotatePoint takes and vector and an angle and converts the angle to 
 * radians (if it is in degrees) and then rotates that point. 
 * Returns the rotated vector.
 */
V rotatePoint(V)(V point, float angle, bool radians = false)
{
	V rotated;
	
	if (!radians)
		angle *= 0.0174533;
	
	rotated.x = point.x * cos(angle) + point.y * sin(angle);
	rotated.y = -point.x * sin(angle) + point.y * cos(angle);

	return rotated;
}