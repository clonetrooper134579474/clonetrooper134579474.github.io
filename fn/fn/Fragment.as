package fn
{
   import com.exileetiquette.loader.LoadManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Fragment extends Sprite
   {
       
      
      public var rotationSpeed:Number;
      
      public var img:Bitmap;
      
      public var velocity:Point;
      
      public function Fragment(param1:*, param2:Number, param3:Number, param4:Point, param5:Number, param6:Number)
      {
         super();
         x = param2;
         y = param3;
         velocity = param4;
         rotation = param5;
         rotationSpeed = param6;
         img = new Bitmap(BitmapData(LoadManager.getInstance().getFile(param1)));
         img.x = -img.width / 2;
         img.y = -img.height / 2;
         addChild(img);
      }
   }
}
