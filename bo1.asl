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
    timer.CurrentTimingMethod = TimingMethod.GameTime;
    refreshRate = 20;
}

start
{
    refreshRate = 20;
	return true;
}

gameTime
{
    return TimeSpan.FromMilliseconds(current.timer * 50);
}