package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class PlayState extends FlxState {
  var pointGroup:FlxSpriteGroup;
  var hud:HUD;
  var effectSprite:FlxSprite;

  override public function create():Void {
    super.create();
    Reg.random = new FlxRandom();
    Reg.score = 0;

    registerServices();

    add(pointGroup);
    add(hud);

    effectSprite = new FlxSprite();
    effectSprite.makeGraphic(640, 480, 0xff772b7d);
    add(effectSprite);

    FlxTween.tween(effectSprite, { alpha: 0 }, 0.25, {
      ease: FlxEase.quadOut,
      onComplete: function(t):Void {
        effectSprite.visible = false;
      }
    });
  }

  private function registerServices():Void {
    pointGroup = new FlxSpriteGroup();
    Reg.pointService = new PointService(pointGroup);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

    recordHighScores();
  }

  private function recordHighScores():Void {
    if (FlxG.save.data.highScore == null) {
      FlxG.save.data.highScore = 0;
    }
    if (Reg.score > FlxG.save.data.highScore) {
      FlxG.save.data.highScore = Reg.score;
    }
  }
}
