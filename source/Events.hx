
package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.tile.FlxRuntimeShader;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import meta.state.PlayState;
import openfl.display.GraphicsShader;
import openfl.filters.ShaderFilter;

class Events
{
	var rgb:FlxRuntimeShader;
	var songName:String;

	var step:Int;
	var beat:Int;

	// events vars!

	public function new(name:String)
	{
		songName = name;

		switch (songName)
		{
			case "Lovely-sound":

				rgb = new FlxRuntimeShader(Paths.shaderFragment('rbgeffect'));
				PlayState.camGame.setFilters([new ShaderFilter(rgb)]);

		}
	}

	

	public function onStep(curStep:Int)
	{
		step = curStep;
		switch (songName) {}
	}

	public function onBeat(curBeat:Int)
	{
		beat = curBeat;
		switch (songName) {}
	}

	public function onUpdate(elapsed:Float)
	{
		switch (songName) {}
	}

	public function onSection(section:Int)
	{
		switch (songName) {}
	}

	public function onPause()
	{
		switch (songName) {}
	}

	public function onResume()
	{
		switch (songName) {}
	}

	function add(Object:FlxBasic, ?layer:Null<Int>)
	{
		var layerID:Int;
		if (layer != null)
			layerID = layer;
		else
			layerID = PlayState.instance.members.length;

		PlayState.instance.insert(layerID, Object);
	}

	function remove(Obj:FlxBasic)
	{
		var index = PlayState.instance.members.indexOf(Obj);
		PlayState.instance.members[index] = null;
	}
}