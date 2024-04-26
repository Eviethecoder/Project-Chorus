package meta.state;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import hxcodec.flixel.FlxVideo;
import meta.state.menus.MainMenuState;

class VideoState extends FlxState {

	var vid:FlxVideo;
  	var title: FlxText;

	override public function create() {
		super.create();

	ForeverTools.resetMenuMusic(true, true);
    title = new FlxText(0, 200, 0, "Press SPACE to Test", 80);
    title.screenCenter(X);
    title.scrollFactor.set(0, 0);
    add(title);

	vid = new FlxVideo();
	//vid.onEndReached = () -> Main.switchState(this, new MainMenuState());
	}

	override function update(_elapsed: Float) {
    if (FlxG.keys.pressed.SPACE) {
		vid.play('assets/Video/test.mp4');
      	title.destroy();
    }
  }
}
