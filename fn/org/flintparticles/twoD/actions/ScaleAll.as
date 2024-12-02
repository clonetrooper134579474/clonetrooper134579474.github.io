package org.flintparticles.twoD.actions
{
   import org.flintparticles.common.actions.ActionBase;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class ScaleAll extends ActionBase
   {
       
      
      private var _diffScale:Number = 0;
      
      private var _endScale:Number = 1;
      
      public function ScaleAll(param1:Number = 1, param2:Number = 1)
      {
         _diffScale = 0;
         _endScale = 1;
         super();
         this.startScale = param1;
         this.endScale = param2;
      }
      
      public function set endScale(param1:Number) : void
      {
         _diffScale = _endScale + _diffScale - param1;
         _endScale = param1;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc5_ = (_loc4_ = _endScale + _diffScale * param2.energy) / param2.scale;
         param2.scale = _loc4_;
         param2.mass *= _loc5_ * _loc5_;
         param2.collisionRadius *= _loc5_;
      }
      
      public function get startScale() : Number
      {
         return _endScale + _diffScale;
      }
      
      public function get endScale() : Number
      {
         return _endScale;
      }
      
      public function set startScale(param1:Number) : void
      {
         _diffScale = param1 - _endScale;
      }
   }
}
