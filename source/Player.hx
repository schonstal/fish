package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import flixel.FlxObject;

import flash.geom.ColorTransform;

class Player extends FlxSprite {
  var points:Int;

  public function new() {
    super();

    loadGraphic("assets/images/fish.png");
    replaceColor(0xffff00ff, 0);
    angle = 90;
    scale.x = 0.5;
    scale.y = 0.5;
    updateHitbox();

    y = FlxG.height - 25;

    setFacingFlip(FlxObject.LEFT, false, true);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public override function update(elapsed:Float) {
    if (x < 0) {
      x = 0;
    }

    if (x > FlxG.width - width) {
      x = FlxG.width - width;
    }

    if (FlxG.keys.pressed.LEFT) {
      velocity.x = -200;
      facing = FlxObject.LEFT;
    } else if (FlxG.keys.pressed.RIGHT) {
      velocity.x = 200;
      facing = FlxObject.RIGHT;
    } else {
      velocity.x = 0;
    }


    if (FlxG.keys.justPressed.SPACE) {
      Reg.projectileService.shoot(x + 100, y);
    }

    super.update(elapsed);
  }
}
