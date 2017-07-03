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
  var background:FlxSprite;

  var projectileGroup:FlxSpriteGroup;
  var enemies:EnemyGroup;
  var player:Player;

  override public function create():Void {
    super.create();
    Reg.random = new FlxRandom();
    Reg.score = 0;

    background = new FlxSprite();
    background.makeGraphic(640, 480, 0xff2a2c36);
    add(background);

    registerServices();

    hud = new HUD();

    add(pointGroup);
    add(hud);

    enemies = new EnemyGroup();
    add(enemies);

    player = new Player();
    add(player);

    effectSprite = new FlxSprite();
    effectSprite.makeGraphic(640, 480, 0xff772b7d);
    add(effectSprite);

    FlxTween.tween(effectSprite, { alpha: 0 }, 0.25, {
      ease: FlxEase.quadOut
    });

    FlxG.debugger.drawDebug = true;
  }

  private function registerServices():Void {
    pointGroup = new FlxSpriteGroup();
    Reg.pointService = new PointService(pointGroup);

    projectileGroup = new FlxSpriteGroup();
    add(projectileGroup);
    Reg.projectileService = new ProjectileService(projectileGroup);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

    FlxG.overlap(enemies, projectileGroup, function(enemy:Enemy, projectile:FlxSprite):Void {
      enemy.hurt(100);
      projectile.exists = false;

      effectSprite.alpha = 0.25;
      FlxTween.tween(effectSprite, { alpha: 0 }, 0.25, {
        ease: FlxEase.quadOut
      });
    });

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
