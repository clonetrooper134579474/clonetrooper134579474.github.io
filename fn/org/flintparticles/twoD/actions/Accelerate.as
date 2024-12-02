package org.flintparticles.twoD.actions
{
   import org.flintparticles.common.actions.ActionBase;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class Accelerate extends ActionBase
   {
       
      
      private var _y:Number;
      
      private var _x:Number;
      
      public function Accelerate(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number) : void
      {
         var _loc4_:Particle2D = null;
         _loc4_ = Particle2D(param2);
         _loc4_.velX += _x * param3;
         _loc4_.velY += _y * param3;
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function get y() : Number
      {
         return _y;
      }
   }
}
