package fn
{
   import com.exileetiquette.loader.LoadManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Bomb extends Sprite
   {
       
      
      public var rotationSpeed:Number;
      
      public const radius:Number = 40;
      
      public var img:Bitmap;
      
      public var velocity:Point;
      
      public function Bomb(param1:Number, param2:Number, param3:Point)
      {
         super();
         x = param1;
         y = param2;
         velocity = param3;
         rotationSpeed = Math.random() * 20 - 10;
         img = new Bitmap(BitmapData(LoadManager.getInstance().getFile("bomb.png")));
         img.x = -img.width / 2;
         img.y = -img.height / 2;
         addChild(img);
      }
   }
}
