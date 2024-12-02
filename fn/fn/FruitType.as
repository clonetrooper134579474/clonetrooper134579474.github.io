package fn
{
   public class FruitType
   {
       
      
      public var points:Number;
      
      public var name:String;
      
      public var colour:Number;
      
      public var radius:Number;
      
      public var fragmentSrc:String;
      
      public var spriteSrc:String;
      
      public function FruitType(param1:String, param2:String, param3:String, param4:Number, param5:Number, param6:Number)
      {
         super();
         radius = param4;
         points = param5;
         name = param1;
         spriteSrc = param2;
         fragmentSrc = param3;
         colour = param6;
      }
      
      public static function compareFunc(param1:FruitType, param2:FruitType) : Number
      {
         return 0;
      }
   }
}
