package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import flixel.FlxObject;

import flash.geom.ColorTransform;

class Enemy extends FlxSprite {
  var points:Int;

  public function new() {
    super();
    points = 50;

    loadGraphic("assets/images/fish.png");
    replaceColor(0xffff00ff, 0);
    scale.x = 0.25;
    scale.y = 0.25;
    updateHitbox();
    width = 110;
    height = 30;
    offset.x = offset.x + 25;
    offset.y = offset.y + 22;
    velocity.x = -10;

    setFacingFlip(FlxObject.LEFT, false, false);
    setFacingFlip(FlxObject.RIGHT, true, false);
  }

  public override function hurt(damage:Float):Void {
    if (!alive) return;

    super.hurt(damage);
  }

  public override function kill():Void {
    alive = false;

    Reg.pointService.showPoints(x + width/2, y + height/2, points, 0xffffffff);
    Reg.score += points;

    FlxG.camera.shake(0.005, 0.2);
    exists = false;
  }

  public override function update(elapsed:Float) {
    super.update(elapsed);
  }

  public function spawn():Void {
    var side = Reg.random.int(0, 1);
    if (side < 1) {
      x = -200;
      velocity.x = 100;
      facing = FlxObject.RIGHT;
    } else {
      x = FlxG.width + 200;
      velocity.x = -100;
      facing = FlxObject.LEFT;
    }

    y = Reg.random.int(20, FlxG.height - 100);


    alive = true;
    exists = true;

    var type = Reg.random.int(0, 3);

    switch(type) {
      case 1:
        color = 0xff44ff44;
        points = 75;
        return;
      case 2:
        color = 0xffff4444;
        points = 100;
        return;
      default:
        color = 0xffffffff;
        points = 50;
    }
  }
}
