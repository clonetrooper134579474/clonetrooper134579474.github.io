package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.utils.interpolateColors;
   
   public class ColorInit extends InitializerBase
   {
       
      
      private var _min:uint;
      
      private var _max:uint;
      
      public function ColorInit(param1:uint = 16777215, param2:uint = 16777215)
      {
         super();
         _min = param1;
         _max = param2;
      }
      
      public function set color(param1:uint) : void
      {
         _max = _min = param1;
      }
      
      override public function initialize(param1:Emitter, param2:Particle) : void
      {
         if(_max == _min)
         {
            param2.color = _min;
         }
         else
         {
            param2.color = interpolateColors(_min,_max,Math.random());
         }
      }
      
      public function get maxColor() : uint
      {
         return _max;
      }
      
      public function set minColor(param1:uint) : void
      {
         _min = param1;
      }
      
      public function get color() : uint
      {
         return _min == _max ? _min : interpolateColors(_max,_min,0.5);
      }
      
      public function get minColor() : uint
      {
         return _min;
      }
      
      public function set maxColor(param1:uint) : void
      {
         _max = param1;
      }
   }
}
