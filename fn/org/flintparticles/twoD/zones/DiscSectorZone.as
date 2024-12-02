package org.flintparticles.twoD.zones
{
   import flash.geom.Point;
   
   public class DiscSectorZone implements Zone2D
   {
      
      private static var TWOPI:Number = Math.PI * 2;
       
      
      private var _minAngle:Number;
      
      private var _innerRadius:Number;
      
      private var _minAllowed:Number;
      
      private var _innerSq:Number;
      
      private var _outerRadius:Number;
      
      private var _center:Point;
      
      private var _maxAngle:Number;
      
      private var _outerSq:Number;
      
      public function DiscSectorZone(param1:Point = null, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0)
      {
         super();
         if(param2 < param3)
         {
            throw new Error("The outerRadius (" + param2 + ") can\'t be smaller than the innerRadius (" + param3 + ") in your DiscSectorZone. N.B. the outerRadius is the second argument in the constructor and the innerRadius is the third argument.");
         }
         _center = !!param1 ? param1.clone() : new Point(0,0);
         _innerRadius = param3;
         _outerRadius = param2;
         _innerSq = _innerRadius * _innerRadius;
         _outerSq = _outerRadius * _outerRadius;
         _minAngle = param4;
         _maxAngle = param5;
         if(_maxAngle)
         {
            while(_maxAngle > TWOPI)
            {
               _maxAngle -= TWOPI;
            }
            while(_maxAngle < 0)
            {
               _maxAngle += TWOPI;
            }
            _minAllowed = _maxAngle - TWOPI;
            if(_minAngle)
            {
               if(param4 == param5)
               {
                  _minAngle = _maxAngle;
               }
               else
               {
                  _minAngle = clamp(_minAngle);
               }
            }
         }
      }
      
      public function set minAngle(param1:Number) : void
      {
         _minAngle = clamp(param1);
      }
      
      public function get outerRadius() : Number
      {
         return _outerRadius;
      }
      
      public function set centerX(param1:Number) : void
      {
         _center.x = param1;
      }
      
      public function set centerY(param1:Number) : void
      {
         _center.y = param1;
      }
      
      public function getArea() : Number
      {
         return Math.PI * _outerSq - Math.PI * _innerSq;
      }
      
      public function set innerRadius(param1:Number) : void
      {
         _innerRadius = param1;
         _innerSq = _innerRadius * _innerRadius;
      }
      
      public function get maxAngle() : Number
      {
         return _maxAngle;
      }
      
      public function get innerRadius() : Number
      {
         return _innerRadius;
      }
      
      public function set outerRadius(param1:Number) : void
      {
         _outerRadius = param1;
         _outerSq = _outerRadius * _outerRadius;
      }
      
      public function set maxAngle(param1:Number) : void
      {
         _maxAngle = param1;
         while(_maxAngle > TWOPI)
         {
            _maxAngle -= TWOPI;
         }
         while(_maxAngle < 0)
         {
            _maxAngle += TWOPI;
         }
         _minAllowed = _maxAngle - TWOPI;
         _minAngle = clamp(_minAngle);
      }
      
      public function contains(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         param1 -= _center.x;
         param2 -= _center.y;
         _loc3_ = param1 * param1 + param2 * param2;
         if(_loc3_ > _outerSq || _loc3_ < _innerSq)
         {
            return false;
         }
         _loc4_ = Math.atan2(param2,param1);
         return (_loc4_ = clamp(_loc4_)) >= _minAngle;
      }
      
      public function get minAngle() : Number
      {
         return _minAngle;
      }
      
      public function get centerX() : Number
      {
         return _center.x;
      }
      
      public function get center() : Point
      {
         return _center;
      }
      
      public function getLocation() : Point
      {
         var _loc1_:Number = NaN;
         var _loc2_:Point = null;
         _loc1_ = Math.random();
         _loc2_ = Point.polar(_innerRadius + (1 - _loc1_ * _loc1_) * (_outerRadius - _innerRadius),_minAngle + Math.random() * (_maxAngle - _minAngle));
         _loc2_.x += _center.x;
         _loc2_.y += _center.y;
         return _loc2_;
      }
      
      public function set center(param1:Point) : void
      {
         _center = param1;
      }
      
      private function clamp(param1:Number) : Number
      {
         if(_maxAngle)
         {
            while(param1 > _maxAngle)
            {
               param1 -= TWOPI;
            }
            while(param1 < _minAllowed)
            {
               param1 += TWOPI;
            }
         }
         return param1;
      }
      
      public function get centerY() : Number
      {
         return _center.y;
      }
   }
}
