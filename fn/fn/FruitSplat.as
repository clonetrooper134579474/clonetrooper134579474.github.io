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
   import org.flintparticles.common.initializers.ScaleImageInit;
   import org.flintparticles.common.initializers.SharedImage;
   import org.flintparticles.twoD.actions.RotateToDirection;
   import org.flintparticles.twoD.emitters.Emitter2D;
   import org.flintparticles.twoD.initializers.Position;
   import org.flintparticles.twoD.zones.DiscSectorZone;
   
   public class FruitSplat extends Emitter2D
   {
      
      internal static var sprite:Bitmap;
      
      internal static var colours:Array = null;
      
      internal static var image:SharedImage = null;
       
      
      public function FruitSplat(param1:Number, param2:Point, param3:Number = 16711680)
      {
         var _loc4_:Number = NaN;
         super();
         if(image == null)
         {
            sprite = new Bitmap(BitmapData(LoadManager.getInstance().getFile("splat01.png")));
            sprite.x = -sprite.width / 2;
            sprite.y = -sprite.height / 2;
            image = new SharedImage(sprite);
         }
         counter = new Blast(param1);
         _loc4_ = Math.atan2(param2.y,param2.x);
         addInitializer(image);
         addInitializer(new ColorInit(param3));
         addInitializer(new Position(new DiscSectorZone(new Point(0,0),param2.length / 2,-param2.length / 10,_loc4_ - 0.15,_loc4_ + 0.15)));
         addInitializer(new Lifetime(5));
         addInitializer(new ScaleImageInit(0.1,1));
         addAction(new Age(Quadratic.easeOut));
         addAction(new Fade(1,0));
         addAction(new RotateToDirection());
         addAction(new ColorChange(param3,param3));
      }
   }
}
