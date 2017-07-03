package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;
import flixel.math.FlxMath;

class EnemyGroup extends FlxSpriteGroup {
  var spawnTimer:Float = 0;

  public function new() {
    super();
  }

  override public function update(elapsed:Float):Void {
    spawnTimer -= elapsed;
    if (spawnTimer < 0) {
      spawnTimer = Reg.random.float(0.75, 1.5);
      var g = recycle(Enemy);
      cast(g, Enemy).spawn();
      add(g);
    }

    super.update(elapsed);
  }
}
