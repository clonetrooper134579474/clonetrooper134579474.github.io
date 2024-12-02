package org.flintparticles.common.behaviours
{
   import org.flintparticles.common.emitters.Emitter;
   
   public interface Behaviour
   {
       
      
      function addedToEmitter(param1:Emitter) : void;
      
      function get priority() : int;
      
      function set priority(param1:int) : void;
      
      function removedFromEmitter(param1:Emitter) : void;
   }
}
