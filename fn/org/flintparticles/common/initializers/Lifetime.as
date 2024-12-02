package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class Lifetime extends InitializerBase
   {
       
      
      private var _min:Number;
      
      private var _max:Number;
      
      public function Lifetime(param1:Number = 1.7976931348623157e+308, param2:Number = NaN)
      {
         super();
         _max = param2;
         _min = param1;
      }
      
      public function get lifetime() : Number
      {
         return _min == _max ? _min : (_max + _min) * 0.5;
      }
      
      public function get maxLifetime() : Number
      {
         return _max;
      }
      
      override public function initialize(param1:Emitter, param2:Particle) : void
      {
         if(isNaN(_max))
         {
            param2.lifetime = _min;
         }
         else
         {
            param2.lifetime = _min + Math.random() * (_max - _min);
         }
      }
      
      public function set lifetime(param1:Number) : void
      {
         _max = _min = param1;
      }
      
      public function set maxLifetime(param1:Number) : void
      {
         _max = param1;
      }
      
      public function set minLifetime(param1:Number) : void
      {
         _min = param1;
      }
      
      public function get minLifetime() : Number
      {
         return _min;
      }
   }
}
