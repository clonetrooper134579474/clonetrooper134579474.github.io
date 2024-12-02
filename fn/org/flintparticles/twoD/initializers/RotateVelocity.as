package org.flintparticles.twoD.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.initializers.InitializerBase;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class RotateVelocity extends InitializerBase
   {
       
      
      private var _min:Number;
      
      private var _max:Number;
      
      public function RotateVelocity(param1:Number = 0, param2:Number = NaN)
      {
         super();
         this.minAngVelocity = param1;
         this.maxAngVelocity = param2;
      }
      
      override public function initialize(param1:Emitter, param2:Particle) : void
      {
         var _loc3_:Particle2D = null;
         _loc3_ = Particle2D(param2);
         if(isNaN(_max))
         {
            _loc3_.angVelocity = _min;
         }
         else
         {
            _loc3_.angVelocity = _min + Math.random() * (_max - _min);
         }
      }
      
      public function set minAngVelocity(param1:Number) : void
      {
         _min = param1;
      }
      
      public function get maxAngVelocity() : Number
      {
         return _max;
      }
      
      public function get angVelocity() : Number
      {
         return _min == _max ? _min : (_max + _min) / 2;
      }
      
      public function get minAngVelocity() : Number
      {
         return _min;
      }
      
      public function set maxAngVelocity(param1:Number) : void
      {
         _max = param1;
      }
      
      public function set angVelocity(param1:Number) : void
      {
         _max = _min = param1;
      }
   }
}
