package fn
{
   import com.exileetiquette.loader.LoadManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import org.flintparticles.common.actions.Age;
   import org.flintparticles.common.actions.ColorChange;
   import org.flintparticles.common.actions.Fade;
   import org.flintparticles.common.counters.Blast;
   import org.flintparticles.common.energyEasing.Quadratic;
   import org.flintparticles.common.initializers.ColorInit;
   import org.flintparticles.common.initializers.Lifetime;
   import org.flintparticles.common.initializers.SharedImage;
   import org.flintparticles.twoD.actions.Accelerate;
   import org.flintparticles.twoD.actions.LinearDrag;
   import org.flintparticles.twoD.actions.Move;
   import org.flintparticles.twoD.actions.Rotate;
   import org.flintparticles.twoD.actions.ScaleAll;
   import org.flintparticles.twoD.emitters.Emitter2D;
   import org.flintparticles.twoD.initializers.Position;
   import org.flintparticles.twoD.initializers.RotateVelocity;
   import org.flintparticles.twoD.initializers.Velocity;
   import org.flintparticles.twoD.zones.DiscZone;
   import org.flintparticles.twoD.zones.LineZone;
   
   public class FruitExplosion extends Emitter2D
   {
      
      internal static var sprite:Bitmap;
      
      internal static var colours:Array = null;
      
      internal static var image:SharedImage = null;
       
      
      public function FruitExplosion(param1:Number, param2:Point, param3:Number, param4:Number = 16711680)
      {
         var _loc5_:Number = NaN;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         super();
         if(image == null)
         {
            sprite = new Bitmap(BitmapData(LoadManager.getInstance().getFile("particle01.png")));
            sprite.x = -sprite.width / 2;
            sprite.y = -sprite.height / 2;
            image = new SharedImage(sprite);
         }
         counter = new Blast(param1);
         _loc5_ = Math.atan2(param2.y,param2.x);
         addInitializer(image);
         addInitializer(new ColorInit(param4));
         addInitializer(new Velocity(new DiscZone(new Point(0,0),param3,param3 / 2)));
         (_loc6_ = param2).normalize(param3 * 1.5);
         _loc7_ = new Point(-_loc6_.x,-_loc6_.y);
         addInitializer(new Position(new LineZone(_loc6_,_loc7_)));
         addInitializer(new Lifetime(1));
         addInitializer(new RotateVelocity(-2,2));
         addAction(new Age(Quadratic.easeOut));
         addAction(new Move());
         addAction(new Fade(1,1));
         addAction(new ScaleAll(1,0));
         addAction(new Rotate());
         addAction(new LinearDrag(0.01));
         addAction(new Accelerate(0,100));
         addAction(new ColorChange(param4,param4));
      }
   }
}
