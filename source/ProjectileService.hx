package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class ProjectileService {
  var projectiles:Array<Projectile> = new Array<Projectile>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.projectiles = new Array<Projectile>();
    this.group = group;
  }

  public function shoot(X:Float, Y:Float):Projectile {
    var projectile = recycle(X, Y);
    group.add(projectile);

    return projectile;
  }

  function recycle(X:Float, Y:Float):Projectile {
    for(projectile in projectiles) {
      if(!projectile.exists) {
        projectile.initialize(X, Y);
        return projectile;
      }
    }

    var projectile:Projectile = new Projectile();
    projectile.initialize(X, Y);
    projectiles.push(projectile);

    return projectile;
  }
}
