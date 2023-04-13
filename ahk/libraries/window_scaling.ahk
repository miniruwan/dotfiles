; ++++++++++++++++++++++++++++++++++++++++++++
/*
Toggle Window Scaling
Reference : https://github.com/lihas/windows-DPI-scaling-sample.git
*/
^!F8::ToggleWindowScaling()
	
ToggleWindowScaling()
{
	Run("`"" packages_dir "\DPI_scaling_app\DPIScalingMFCApp.exe`"")
	WinWaitActive("DPIScalingMFCApp")
	currentDpi := ControlGetText("Edit2", "DPIScalingMFCApp")
	if(currentDpi == 100)
    {
		Send("{Tab} {Down 2} {Tab} {Enter}") ; 100 to 150
	}
    else
    {
		Send("{Tab} {Up 2} {Tab} {Enter}") ; 150 to 100
	}
	WinClose("DPIScalingMFCApp")
}