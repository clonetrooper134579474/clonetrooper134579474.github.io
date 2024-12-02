package org.flintparticles.twoD.actions
{
   import org.flintparticles.common.actions.ActionBase;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class Rotate extends ActionBase
   {
       
      
      public function Rotate()
      {
         super();
         priority = -10;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number) : void
      {
         var _loc4_:Particle2D = null;
         _loc4_ = Particle2D(param2);
         _loc4_.rotation += _loc4_.angVelocity * param3;
      }
   }
}
