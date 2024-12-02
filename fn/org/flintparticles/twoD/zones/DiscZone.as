package org.flintparticles.twoD.zones
{
   import flash.geom.Point;
   
   public class DiscZone implements Zone2D
   {
      
      private static const TWOPI:Number = Math.PI * 2;
       
      
      private var _innerRadius:Number;
      
      private var _innerSq:Number;
      
      private var _outerRadius:Number;
      
      private var _center:Point;
      
      private var _outerSq:Number;
      
      public function DiscZone(param1:Point = null, param2:Number = 0, param3:Number = 0)
      {
         super();
         if(param2 < param3)
         {
            throw new Error("The outerRadius (" + param2 + ") can\'t be smaller than the innerRadius (" + param3 + ") in your DiscZone. N.B. the outerRadius is the second argument in the constructor and the innerRadius is the third argument.");
         }
         if(param1 == null)
         {
            _center = new Point(0,0);
         }
         else
         {
            _center = param1;
         }
         _innerRadius = param3;
         _outerRadius = param2;
         _innerSq = _innerRadius * _innerRadius;
         _outerSq = _outerRadius * _outerRadius;
      }
      
      public function set centerX(param1:Number) : void
      {
         _center.x = param1;
      }
      
      public function get innerRadius() : Number
      {
         return _innerRadius;
      }
      
      public function getArea() : Number
      {
         return Math.PI * (_outerSq - _innerSq);
      }
      
      public function set innerRadius(param1:Number) : void
      {
         _innerRadius = param1;
         _innerSq = _innerRadius * _innerRadius;
      }
      
      public function get center() : Point
      {
         return _center;
      }
      
      public function set centerY(param1:Number) : void
      {
         _center.y = param1;
      }
      
      public function set outerRadius(param1:Number) : void
      {
         _outerRadius = param1;
         _outerSq = _outerRadius * _outerRadius;
      }
      
      public function contains(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Number = NaN;
         param1 -= _center.x;
         param2 -= _center.y;
         _loc3_ = param1 * param1 + param2 * param2;
         return _loc3_ <= _outerSq && _loc3_ >= _innerSq;
      }
      
      public function get centerX() : Number
      {
         return _center.x;
      }
      
      public function get centerY() : Number
      {
         return _center.y;
      }
      
      public function get outerRadius() : Number
      {
         return _outerRadius;
      }
      
      public function set center(param1:Point) : void
      {
         _center = param1;
      }
      
      public function getLocation() : Point
      {
         var _loc1_:Number = NaN;
         var _loc2_:Point = null;
         _loc1_ = Math.random();
         _loc2_ = Point.polar(_innerRadius + (1 - _loc1_ * _loc1_) * (_outerRadius - _innerRadius),Math.random() * TWOPI);
         _loc2_.x += _center.x;
         _loc2_.y += _center.y;
         return _loc2_;
      }
   }
}
