package gameObjects.userInterface;

import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;
#if sys
import sys.FileSystem;
import sys.io.File;
#end


class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	public var isPlayer:Bool = false;
	private var char:String = '';
	public var icontype:String = '';
	public var initialWidth:Int = 0;
	public var  animatedIconStage:String = 'Normal';
	public var oldx:Float = 0;
	public var oldy:Float = 0;
	

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 12, sprTracker.y - 30);
	}

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	private var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String) {
		if(this.char != char) {
			var name:String = 'icons/' + char;
			
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
			var file:Dynamic = Paths.image(name);

			loadGraphic(file); //Load stupidly first for getting the file size

			if (FileSystem.exists(Paths.psychgetPath('images/' + name + '.xml', TEXT)))
				{
					frames = Paths.getSparrowAtlas(name);
					animation.addByPrefix('win', 'win', 24, true, isPlayer);
					animation.addByPrefix('normal', 'normal', 24, true, isPlayer);
					animation.addByPrefix('loose', 'loose', 24, true, isPlayer);
					icontype = 'animated';
				}
			else
				{

				
				switch(width){

					default:
						loadGraphic(file, true, Math.floor(width / 2), Math.floor(height)); //Then load it fr
						icontype = 'default';
	
					case(450):
						loadGraphic(file, true, Math.floor(width / 3), Math.floor(height)); //starting the winning icon stuffs
						switch(char){
							default:
								icontype = 'win';
							case('eggman-super'):
								icontype = 'egg';
								trace('egg');
						}
	
					
	
					
	
				}
			}

			
			
			

			switch (icontype){ //initiate the icon animation shit 

				case ('default'):
					iconOffsets[0] = (width - 150) / 2; 
					iconOffsets[1] = (width - 150) / 2;
					animation.add(char, [0, 1], 0, false, isPlayer);
				case ('win'):
					iconOffsets[0] = (width - 150) / 3;
					iconOffsets[1] = (width - 150) / 3;
					iconOffsets[2] = (width - 150) / 3;
					animation.add(char, [0, 1, 2], 0, false, isPlayer);
				case ('egg'):
					iconOffsets[0] = (width - 150) / 3;
					iconOffsets[1] = (width - 150) / 3;
					iconOffsets[2] = (width - 150) / 3;
					animation.add(char, [0, 1, 2], 0, false, isPlayer);
			}
			updateHitbox();

			
			animation.play(char);
			this.char = char;

			antialiasing = true;
			if(char.endsWith('-pixel')) {
				antialiasing = false;
			}
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String {
		return char;
	}

	public dynamic function updateAnim(health:Float){

		var num:Int = Math.floor(Math.max(Math.min(Math.floor(health / 20), 4), 0));
		switch (icontype){
			case('default'):
			
				animation.curAnim.curFrame = (health < 20) ? 1 : 0;
	
			case('win'):
				if (health < 20)
					animation.curAnim.curFrame = 1;
				else if (health > 80 )
					animation.curAnim.curFrame = 2
				else
					animation.curAnim.curFrame = 0;


			case('egg'):
				if (health <= 9)
					animation.curAnim.curFrame = 2
				else if (health < 20)
					animation.curAnim.curFrame = 1;
				else
					animation.curAnim.curFrame = 0;

			case 'animated':
                if ((health < 20) && (animation.getByName("loose") != null)) {
                    animatedIconStage = "loose";
					animation.play("loose");
                } else if ((health > 80) && (animation.getByName("win") != null)) {
                    animatedIconStage = "win";
					animation.play("win");
                } else if (animation.getByName("normal") != null) {
                    animatedIconStage = "normal";
					animation.play("normal");

	}
}
	}
	

	public dynamic function iconbop(health:Float){
		
		scale.set(1.2, 1.2);
		updateHitbox();

	}

}
