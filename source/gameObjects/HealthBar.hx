package gameObjects;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;

class HealthBar extends FlxSpriteGroup
{
	public var leftBar:FlxSprite;
	public var rightBar:FlxSprite;
	public var bg:FlxSprite;
	public var bg2:FlxSprite;
	public var valueFunction:Void->Float = function() return 0;
	public var percent(default, set):Float = 0;
	public var bounds:Dynamic = {min: 0, max: 1};
	public var leftToRight(default, set):Bool = true;
	public var barCenter(default, null):Float = 0;

	// you might need to change this if you want to use a custom bar
	public var barWidth(default, set):Int = 1;
	public var barHeight(default, set):Int = 1;
	public var barOffset:FlxPoint = new FlxPoint(3, 3);

	public function new(x:Float, y:Float, image:String = 'healthBar', valueFunction:Void->Float = null, boundX:Float = 0, boundY:Float = 1)
	{
		super(x, y);
		
		if(valueFunction != null) this.valueFunction = valueFunction;
		setBounds(boundX, boundY);
		bg2 = new FlxSprite().loadGraphic(Paths.image('UI/default/base/hpbar'));
		//bg2.alpha = 0;
		bg2.x += 180;
		bg2.y += 100;
		bg2.alpha =0;
		bg = new FlxSprite().loadGraphic(Paths.image('UI/default/base/hptop'));
		bg.antialiasing = true;
		barWidth = Std.int(bg2.width - 5);
		barHeight = Std.int(bg2.height - 8);

		leftBar = new FlxSprite().makeGraphic(Std.int(bg2.width), Std.int(bg2.height), FlxColor.WHITE);
		//leftBar.color = FlxColor.WHITE;
		leftBar.antialiasing = antialiasing = true;

		rightBar = new FlxSprite().makeGraphic(Std.int(bg2.width), Std.int(bg2.height), FlxColor.WHITE);
		rightBar.color = FlxColor.BLACK;
		rightBar.antialiasing = true;

		add(leftBar);
		add(rightBar);
		add(bg2);
		add(bg);
		regenerateClips();
	}

	override function update(elapsed:Float) {
		var value:Null<Float> = FlxMath.remapToRange(FlxMath.bound(valueFunction(), bounds.min, bounds.max), bounds.min, bounds.max, 0, 100);
		percent = (value != null ? value : 0);
		super.update(elapsed);
	}
	
	public function setBounds(min:Float, max:Float)
	{
		bounds.min = min;
		bounds.max = max;
	}

	public function setColors(left:FlxColor, right:FlxColor)
	{
		leftBar.color = left;
		rightBar.color = right;
	}

	public function updateBar()
	{
		if(leftBar == null || rightBar == null) return;

		leftBar.setPosition(bg2.x, bg2.y);
		rightBar.setPosition(bg2.x, bg2.y);

		var leftSize:Float = 0;
		if(leftToRight) leftSize = FlxMath.lerp(0, barWidth, percent / 100);
		else leftSize = FlxMath.lerp(0, barWidth, 1 - percent / 100);

		leftBar.clipRect.width = leftSize;
		leftBar.clipRect.height = barHeight;
		leftBar.clipRect.x = barOffset.x;
		leftBar.clipRect.y = barOffset.y;

		rightBar.clipRect.width = barWidth - leftSize;
		rightBar.clipRect.height = barHeight;
		rightBar.clipRect.x = barOffset.x + leftSize;
		rightBar.clipRect.y = barOffset.y;

		barCenter = leftBar.x + leftSize + barOffset.x;

		// flixel is retarded
		leftBar.clipRect = leftBar.clipRect;
		rightBar.clipRect = rightBar.clipRect;
	}

	public function regenerateClips()
	{
		if(leftBar != null)
		{
			leftBar.setGraphicSize(Std.int(bg2.width), Std.int(bg2.height));
			leftBar.updateHitbox();
			leftBar.clipRect = new FlxRect(0, 0, Std.int(bg2.width), Std.int(bg2.height));
		}
		if(rightBar != null)
		{
			rightBar.setGraphicSize(Std.int(bg2.width), Std.int(bg2.height));
			rightBar.updateHitbox();
			rightBar.clipRect = new FlxRect(0, 0, Std.int(bg2.width), Std.int(bg2.height));
		}
		updateBar();
	}

	private function set_percent(value:Float)
	{
		var doUpdate:Bool = false;
		if(value != percent) doUpdate = true;
		percent = value;

		if(doUpdate) updateBar();
		return value;
	}

	private function set_leftToRight(value:Bool)
	{
		leftToRight = value;
		updateBar();
		return value;
	}

	private function set_barWidth(value:Int)
	{
		barWidth = value;
		regenerateClips();
		return value;
	}

	private function set_barHeight(value:Int)
	{
		barHeight = value;
		regenerateClips();
		return value;
	}
}