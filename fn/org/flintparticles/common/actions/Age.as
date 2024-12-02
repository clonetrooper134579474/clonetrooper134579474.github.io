package org.flintparticles.common.actions
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.energyEasing.Linear;
   import org.flintparticles.common.particles.Particle;
   
   public class Age extends ActionBase
   {
       
      
      private var _easing:Function;
      
      public function Age(param1:Function = null)
      {
         super();
         if(param1 == null)
         {
            _easing = Linear.easeNone;
         }
         else
         {
            _easing = param1;
         }
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number) : void
      {
         param2.age += param3;
         if(param2.age >= param2.lifetime)
         {
            param2.energy = 0;
            param2.isDead = true;
         }
         else
         {
            param2.energy = _easing(param2.age,param2.lifetime);
         }
      }
      
      public function get easing() : Function
      {
         return _easing;
      }
      
      public function set easing(param1:Function) : void
      {
         _easing = param1;
      }
   }
}
