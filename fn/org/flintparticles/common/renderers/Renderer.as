package org.flintparticles.common.renderers
{
   import org.flintparticles.common.emitters.Emitter;
   
   public interface Renderer
   {
       
      
      function removeEmitter(param1:Emitter) : void;
      
      function addEmitter(param1:Emitter) : void;
   }
}
