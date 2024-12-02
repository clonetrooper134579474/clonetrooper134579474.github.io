package org.flintparticles.common.utils
{
   public class Maths
   {
      
      private static const DEGTORAD:Number = Math.PI / 180;
      
      private static const RADTODEG:Number = 180 / Math.PI;
       
      
      public function Maths()
      {
         super();
      }
      
      public static function asRadians(param1:Number) : Number
      {
         return param1 * DEGTORAD;
      }
      
      public static function asDegrees(param1:Number) : Number
      {
         return param1 * RADTODEG;
      }
   }
}
