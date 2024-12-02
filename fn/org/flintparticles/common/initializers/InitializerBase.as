package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class InitializerBase implements Initializer
   {
       
      
      protected var _priority:int = 0;
      
      public function InitializerBase()
      {
         _priority = 0;
         super();
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      public function set priority(param1:int) : void
      {
         _priority = param1;
      }
      
      public function initialize(param1:Emitter, param2:Particle) : void
      {
      }
      
      public function addedToEmitter(param1:Emitter) : void
      {
      }
      
      public function removedFromEmitter(param1:Emitter) : void
      {
      }
   }
}
