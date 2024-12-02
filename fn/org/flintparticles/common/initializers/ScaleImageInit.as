package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class ScaleImageInit extends InitializerBase
   {
       
      
      private var _min:Number;
      
      private var _max:Number;
      
      public function ScaleImageInit(param1:Number = 1, param2:Number = NaN)
      {
         super();
         _min = param1;
         if(isNaN(param2))
         {
            _max = _min;
         }
         else
         {
            _max = param2;
         }
      }
      
      public function set maxScale(param1:Number) : void
      {
         _max = param1;
      }
      
      public function get maxScale() : Number
      {
         return _max;
      }
      
      override public function initialize(param1:Emitter, param2:Particle) : void
      {
         if(_max == _min)
         {
            param2.scale = _min;
         }
         else
         {
            param2.scale = _min + Math.random() * (_max - _min);
         }
      }
      
      public function get scale() : Number
      {
         return _min == _max ? _min : (_max + _min) / 2;
      }
      
      public function set scale(param1:Number) : void
      {
         _max = _min = param1;
      }
      
      public function get minScale() : Number
      {
         return _min;
      }
      
      public function set minScale(param1:Number) : void
      {
         _min = param1;
      }
   }
}
