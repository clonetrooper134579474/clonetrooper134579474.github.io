package org.flintparticles.common.renderers
{
   import flash.display.Sprite;
   import flash.events.Event;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.events.EmitterEvent;
   import org.flintparticles.common.events.ParticleEvent;
   import org.flintparticles.common.particles.Particle;
   
   public class SpriteRendererBase extends Sprite implements Renderer
   {
       
      
      protected var _emitters:Array;
      
      public function SpriteRendererBase()
      {
         super();
         _emitters = new Array();
         mouseEnabled = false;
         mouseChildren = false;
         addEventListener(Event.ADDED_TO_STAGE,addedToStage,false,0,true);
      }
      
      private function particleAdded(param1:ParticleEvent) : void
      {
         addParticle(param1.particle);
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      private function addedToStage(param1:Event) : void
      {
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      protected function removeParticle(param1:Particle) : void
      {
      }
      
      protected function addParticle(param1:Particle) : void
      {
      }
      
      public function removeEmitter(param1:Emitter) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Particle = null;
         _loc2_ = 0;
         while(_loc2_ < _emitters.length)
         {
            if(_emitters[_loc2_] == param1)
            {
               _emitters.splice(_loc2_,1);
               param1.removeEventListener(EmitterEvent.EMITTER_UPDATED,emitterUpdated);
               param1.removeEventListener(ParticleEvent.PARTICLE_CREATED,particleAdded);
               param1.removeEventListener(ParticleEvent.PARTICLE_ADDED,particleAdded);
               param1.removeEventListener(ParticleEvent.PARTICLE_DEAD,particleRemoved);
               for each(_loc3_ in param1.particles)
               {
                  removeParticle(_loc3_);
               }
               if(_emitters.length == 0)
               {
                  removeEventListener(Event.RENDER,updateParticles);
                  renderParticles([]);
               }
               else if(stage)
               {
                  stage.invalidate();
               }
               return;
            }
            _loc2_++;
         }
      }
      
      protected function emitterUpdated(param1:EmitterEvent) : void
      {
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      public function set emitters(param1:Array) : void
      {
         var _loc2_:Emitter = null;
         for each(_loc2_ in _emitters)
         {
            removeEmitter(_loc2_);
         }
         for each(_loc2_ in param1)
         {
            addEmitter(_loc2_);
         }
      }
      
      public function addEmitter(param1:Emitter) : void
      {
         var _loc2_:Particle = null;
         _emitters.push(param1);
         if(stage)
         {
            stage.invalidate();
         }
         param1.addEventListener(EmitterEvent.EMITTER_UPDATED,emitterUpdated,false,0,true);
         param1.addEventListener(ParticleEvent.PARTICLE_CREATED,particleAdded,false,0,true);
         param1.addEventListener(ParticleEvent.PARTICLE_ADDED,particleAdded,false,0,true);
         param1.addEventListener(ParticleEvent.PARTICLE_DEAD,particleRemoved,false,0,true);
         for each(_loc2_ in param1.particles)
         {
            addParticle(_loc2_);
         }
         if(_emitters.length == 1)
         {
            addEventListener(Event.RENDER,updateParticles,false,0,true);
         }
      }
      
      protected function renderParticles(param1:Array) : void
      {
      }
      
      public function get emitters() : Array
      {
         return _emitters;
      }
      
      protected function updateParticles(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         _loc2_ = new Array();
         _loc3_ = 0;
         while(_loc3_ < _emitters.length)
         {
            _loc2_ = _loc2_.concat(Emitter(_emitters[_loc3_]).particles);
            _loc3_++;
         }
         renderParticles(_loc2_);
      }
      
      private function particleRemoved(param1:ParticleEvent) : void
      {
         removeParticle(param1.particle);
         if(stage)
         {
            stage.invalidate();
         }
      }
   }
}
