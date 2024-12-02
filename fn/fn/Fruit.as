package fn
{
   import com.exileetiquette.loader.LoadManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Fruit extends Sprite
   {
       
      
      public var type:FruitType;
      
      public var rotationSpeed:Number;
      
      public var img:Bitmap;
      
      public var velocity:Point;
      
      public function Fruit(param1:FruitType, param2:Number, param3:Number, param4:Point)
      {
         super();
         x = param2;
         y = param3;
         velocity = param4;
         rotationSpeed = Math.random() * 20 - 10;
         this.type = param1;
         img = new Bitmap(BitmapData(LoadManager.getInstance().getFile(param1.spriteSrc)));
         img.x = -img.width / 2;
         img.y = -img.height / 2;
         addChild(img);
      }
   }
}
