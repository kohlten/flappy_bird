module utils.animator;

import globals;
import load;

import std.stdio;

class Animator
{
	private:
		Texture[][] textures;
		Duration[] rateOfChange;
		string[] states;
		uint state;
		uint current;
		Duration prev;
		bool playing = false;
		int timesPlayed;
		int maxTimes = -1;

	public:
		this(string[][] textureNames, string[] states)
		{
			assert(textureNames.length == states.length, "Invalid states or textures!");
			foreach (i; 0 .. textureNames.length)
			{
				this.textures ~= this.loadTextures(textureNames[i]);
				this.states ~= states[i];
			}
			
			this.rateOfChange.length = this.textures.length;
			this.states = states;
		}

		this() {}

		ulong addState(string state, string[] textureNames ...)
		{
			this.states ~= state;
			this.textures ~= this.loadTextures(textureNames);
			assert(this.states.length == this.textures.length, "Invalid states or textures!");
			this.rateOfChange.length++;
			return this.states.length - 1;
		}

		void updateTicks(Clock clock)
		{
			assert(this.states.length > 0, "Need to load in images before updating");
			if (this.playing && (this.timesPlayed < this.maxTimes) || this.maxTimes == -1)
			{
				auto time = clock.getElapsedTime();
				if ((time - this.prev) > this.rateOfChange[this.state])
				{
					this.current++;
					this.prev = time;
				}
				if (this.current > this.textures[this.state].length - 1)
				{
					writeln("Max is: ", this.maxTimes, " Times played: ", this.timesPlayed);
					//writeln("Reset");
					this.timesPlayed++;
					this.current = 0;
				}
			}
		}

		void changeRate(Duration newRate, string state)
		{
			uint loc = findState(state);
			this.rateOfChange[loc] = newRate;
		}

		void changeState(string newState)
		{
			uint loc = -1;

			loc = this.findState(newState);
			assert(loc >= 0, "state not found!");
			this.state = loc;
			this.playing = false;
			this.timesPlayed = 0;
			this.maxTimes = -1;
		}

		string getState()
		{
			return this.states[this.state];
		}

		Texture getTexCurrent()
		{
			assert(this.states.length > 0, "Need to load in images before updating");
			return this.textures[this.state][this.current];
		}

		ulong getCurrentStateLength()
		{
			return this.textures[this.state].length;
		}

		ulong getIntCurrent()
		{
			return this.current;
		}

		void play(int times = -1)
		{
			this.playing = true;
			this.timesPlayed = 0;
			this.maxTimes = times;
		}

		void stop()
		{
			this.playing = false;
		}

	private: 
		Texture[] loadTextures(string[] textureNames)
		{
			Texture[] outTextures;
			foreach(i; 0 .. textureNames.length)
				outTextures ~= loadTexture(textureNames[i]);
			return outTextures;
		}

		uint findState(string newState)
		{
			uint loc = -1;
			foreach (i; 0 .. this.states.length)
			{
				if (this.states[i] == newState)
				{
					loc = cast(uint)i;
					break;
				}
			}
			assert(loc >= 0, "Could not find state " ~ newState);
			return loc;
		}
}
