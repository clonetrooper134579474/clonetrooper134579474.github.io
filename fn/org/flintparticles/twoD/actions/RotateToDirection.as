package org.flintparticles.twoD.actions
{
   import org.flintparticles.common.actions.ActionBase;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class RotateToDirection extends ActionBase
   {
       
      
      public function RotateToDirection()
      {
         super();
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number) : void
      {
         var _loc4_:Particle2D = null;
         (_loc4_ = Particle2D(param2)).rotation = Math.atan2(_loc4_.velY,_loc4_.velX);
      }
   }
}
