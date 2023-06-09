state("BlackOps")
{
    int timer : 0x1679870;    
	int game_paused : 0x8902B4;
	byte roundchange : 0x165695D;
}

state("BGamerT5")
{
    int timer : 0x1679870;    
	int game_paused : 0x8902B4;
	byte roundchange : 0x165695D;
}
startup
{
	vars.loop = 0; // this allows us to check when round changes
	vars.round_start = 0;
	timer.CurrentTimingMethod = TimingMethod.GameTime;
}

start
{
	return true;
}

update
{
	if (current.roundchange == 0 && current.roundchange != old.roundchange)
	{
		if (vars.loop == 0)
		{
			// round has changed
			// first update loop
			vars.loop = 1;

			// update round start time
			vars.round_start = current.timer;
		}
		else 
		{
			vars.loop = 0;
		}
	}

	// reset if restarts game
	if (current.timer < old.timer)
	{
		vars.loop = 0;
		vars.round_start = 0;
	}
}

isLoading
{
	return true;
}

gameTime
{	
	if (current.timer - vars.round_start < 0)
	{
		return TimeSpan.FromMilliseconds(0);
	}
	return TimeSpan.FromMilliseconds((current.timer - vars.round_start) * 50);
}