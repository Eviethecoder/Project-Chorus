package meta;


class Macros {
	public static macro function getBuildTime()
	{
		var buildTime = DateTools.format(Date.now(), "%Y-%m-%d_%H:%M:%S");
		return macro $v{buildTime};
	}
}