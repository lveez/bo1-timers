state("BlackOps")
{
    int timer : 0x1679870;    
	int game_paused : 0x8902B4;
}

state("BGamerT5")
{
    int timer : 0x1679870;    
	int game_paused : 0x8902B4;
}

init
{
	refreshRate = 20;
}


startup
{
	vars.start_time = 0;
	timer.CurrentTimingMethod = TimingMethod.GameTime;
	refreshRate = 20;
}

start
{
	refreshRate = 20;
	return true;
}

update
{
	if (timer.CurrentPhase == TimerPhase.Paused)
	{
		if (current.game_paused == 0)
		{
			vars.start_time = current.timer;
		}
		timer.CurrentPhase = TimerPhase.Running;
	}

	if (current.timer < vars.start_time)
	{
		vars.start_time = current.timer;
	}

	vars.time = (current.timer - vars.start_time) * 50;

	// reset if restarts game
	if (current.timer < old.timer)
	{
		vars.strart_time = 0;
	}
}

gameTime
{	
    	return TimeSpan.FromMilliseconds(vars.time);
}