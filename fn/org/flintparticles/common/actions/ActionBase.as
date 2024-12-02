package org.flintparticles.common.actions
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class ActionBase implements Action
   {
       
      
      protected var _priority:int = 0;
      
      public function ActionBase()
      {
         _priority = 0;
         super();
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      public function update(param1:Emitter, param2:Particle, param3:Number) : void
      {
      }
      
      public function set priority(param1:int) : void
      {
         _priority = param1;
      }
      
      public function addedToEmitter(param1:Emitter) : void
      {
      }
      
      public function removedFromEmitter(param1:Emitter) : void
      {
      }
   }
}
