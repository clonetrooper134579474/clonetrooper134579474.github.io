package org.flintparticles.twoD.actions
{
   import org.flintparticles.common.actions.ActionBase;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class LinearDrag extends ActionBase
   {
       
      
      private var _drag:Number;
      
      public function LinearDrag(param1:Number = 0)
      {
         super();
         this.drag = param1;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number) : void
      {
         var _loc4_:Particle2D = null;
         var _loc5_:Number = NaN;
         _loc4_ = Particle2D(param2);
         if((_loc5_ = 1 - _drag * param3 / _loc4_.mass) < 0)
         {
            _loc4_.velX = 0;
            _loc4_.velY = 0;
         }
         else
         {
            _loc4_.velX *= _loc5_;
            _loc4_.velY *= _loc5_;
         }
      }
      
      public function get drag() : Number
      {
         return _drag;
      }
      
      public function set drag(param1:Number) : void
      {
         _drag = param1;
      }
   }
}
