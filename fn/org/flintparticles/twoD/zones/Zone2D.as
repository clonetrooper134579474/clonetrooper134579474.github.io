package org.flintparticles.twoD.zones
{
   import flash.geom.Point;
   
   public interface Zone2D
   {
       
      
      function getArea() : Number;
      
      function getLocation() : Point;
      
      function contains(param1:Number, param2:Number) : Boolean;
   }
}
