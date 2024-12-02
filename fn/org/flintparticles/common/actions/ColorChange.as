package org.flintparticles.common.actions
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.utils.interpolateColors;
   
   public class ColorChange extends ActionBase
   {
       
      
      private var _startColor:uint;
      
      private var _endColor:uint;
      
      public function ColorChange(param1:uint = 16777215, param2:uint = 16777215)
      {
         super();
         _startColor = param1;
         _endColor = param2;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number) : void
      {
         param2.color = interpolateColors(_startColor,_endColor,param2.energy);
      }
      
      public function get endColor() : uint
      {
         return _endColor;
      }
      
      public function get startColor() : uint
      {
         return _startColor;
      }
      
      public function set startColor(param1:uint) : void
      {
         _startColor = param1;
      }
      
      public function set endColor(param1:uint) : void
      {
         _endColor = param1;
      }
   }
}
