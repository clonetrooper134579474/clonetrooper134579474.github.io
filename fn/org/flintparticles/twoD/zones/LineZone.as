package org.flintparticles.twoD.zones
{
   import flash.geom.Point;
   
   public class LineZone implements Zone2D
   {
       
      
      private var _length:Point;
      
      private var _end:Point;
      
      private var _start:Point;
      
      public function LineZone(param1:Point = null, param2:Point = null)
      {
         super();
         if(param1 == null)
         {
            _start = new Point(0,0);
         }
         else
         {
            _start = param1;
         }
         if(param2 == null)
         {
            _end = new Point(0,0);
         }
         else
         {
            _end = param2;
         }
         _length = _end.subtract(_start);
      }
      
      public function getArea() : Number
      {
         return _length.length;
      }
      
      public function set start(param1:Point) : void
      {
         _start = param1;
         _length = _end.subtract(_start);
      }
      
      public function get end() : Point
      {
         return _end;
      }
      
      public function get endX() : Number
      {
         return _end.x;
      }
      
      public function get endY() : Number
      {
         return _end.y;
      }
      
      public function get start() : Point
      {
         return _start;
      }
      
      public function contains(param1:Number, param2:Number) : Boolean
      {
         if((param1 - _start.x) * _length.y - (param2 - _start.y) * _length.x != 0)
         {
            return false;
         }
         return (param1 - _start.x) * (param1 - _end.x) + (param2 - _start.y) * (param2 - _end.y) <= 0;
      }
      
      public function getLocation() : Point
      {
         var _loc1_:Point = null;
         var _loc2_:Number = NaN;
         _loc1_ = _start.clone();
         _loc2_ = Math.random();
         _loc1_.x += _length.x * _loc2_;
         _loc1_.y += _length.y * _loc2_;
         return _loc1_;
      }
      
      public function set startX(param1:Number) : void
      {
         _start.x = param1;
         _length = _end.subtract(_start);
      }
      
      public function set startY(param1:Number) : void
      {
         _start.y = param1;
         _length = _end.subtract(_start);
      }
      
      public function set end(param1:Point) : void
      {
         _end = param1;
         _length = _end.subtract(_start);
      }
      
      public function get startY() : Number
      {
         return _start.y;
      }
      
      public function set endX(param1:Number) : void
      {
         _end.x = param1;
         _length = _end.subtract(_start);
      }
      
      public function set endY(param1:Number) : void
      {
         _end.y = param1;
         _length = _end.subtract(_start);
      }
      
      public function get startX() : Number
      {
         return _start.x;
      }
   }
}
