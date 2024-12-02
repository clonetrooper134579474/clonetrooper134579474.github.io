package org.flintparticles.common.counters
{
   import org.flintparticles.common.emitters.Emitter;
   
   public interface Counter
   {
       
      
      function stop() : void;
      
      function updateEmitter(param1:Emitter, param2:Number) : uint;
      
      function get complete() : Boolean;
      
      function startEmitter(param1:Emitter) : uint;
      
      function resume() : void;
   }
}
