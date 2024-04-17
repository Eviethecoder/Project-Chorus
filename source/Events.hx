package;

import Shaders;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
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
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;

class Events
{
	var songName:String;

	public static var shaders:Array<ShaderEffect> = [];
	public static var shaderUpdate:Array<Float->Void> = [];

	var step:Int;
	var beat:Int;

	var daShader:ChromaticAberrationEffect;

	// events vars!

	public function new(name:String)
	{
		songName = name;

		switch (songName)
		{
			case "Lovely-sound":
				daShader = new ChromaticAberrationEffect(0.0025);
				addShader(daShader);


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
		for (i in shaderUpdate)
		{
			i(elapsed);
		}
		
		
		
		switch (songName) {
			case 'Lovely-sound':
				daShader.shader.rOffset.value = [FlxG.random.float(0.001, 0.0030)];
				daShader.shader.gOffset.value = [FlxG.random.float(0.001, 0.0033)];
				daShader.shader.bOffset.value = [FlxG.random.float(0.001,  0.0032)];
				
		}
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

	function addShader(effect:ShaderEffect) // IMPORTANTE!1!1!!
	{
		if (shaders.contains(effect))
		{
			return;
		}

		shaders.push(effect);

		var newCamEffects:Array<BitmapFilter> = [];

		for (i in shaders)
		{
			newCamEffects.push(new ShaderFilter(i.shader));
		}

		FlxG.camera.setFilters(newCamEffects);
		PlayState.camHUD.setFilters(newCamEffects);
	}

	function clearShaders() // IMPORTANTE!1!1!!
	{
		FlxG.camera.setFilters([]);

		shaders = [];
	}
}