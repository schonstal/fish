package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxVector;

class Projectile extends FlxSprite {
  public function new() {
    super();

    loadGraphic("assets/images/fish.png");
    replaceColor(0xffff00ff, 0);
    scale.x = 0.1;
    scale.y = 0.1;
    angle = 90;
    color = 0xff4444ff;
    updateHitbox();
  }

  public function initialize(X:Float, Y:Float):Void {
    x = X;
    y = Y;

    visible = true;
    exists = true;

    velocity.y = -300;
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
