package org.flintparticles.common.actions
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class Fade extends ActionBase
   {
       
      
      private var _endAlpha:Number;
      
      private var _diffAlpha:Number;
      
      public function Fade(param1:Number = 1, param2:Number = 0)
      {
         super();
         priority = -5;
         _diffAlpha = param1 - param2;
         _endAlpha = param2;
      }
      
      public function get endAlpha() : Number
      {
         return _endAlpha;
      }
      
      public function set endAlpha(param1:Number) : void
      {
         _diffAlpha = _endAlpha + _diffAlpha - param1;
         _endAlpha = param1;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number) : void
      {
         var _loc4_:Number = NaN;
         _loc4_ = _endAlpha + _diffAlpha * param2.energy;
         param2.color = param2.color & 16777215 | Math.round(_loc4_ * 255) << 24;
      }
      
      public function set startAlpha(param1:Number) : void
      {
         _diffAlpha = param1 - _endAlpha;
      }
      
      public function get startAlpha() : Number
      {
         return _endAlpha + _diffAlpha;
      }
   }
}
