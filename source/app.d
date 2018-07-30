import dsfml.window;
import dsfml.system;
import dsfml.graphics;

import game;

import std.stdio : writeln;
import std.conv : to;

void main()
{
	//setMouseCursorVisible;
	//setVerticalSyncEnabled
	auto game = new Game();
	game.run();
}
