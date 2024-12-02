package org.flintparticles.twoD.initializers
{
   import flash.geom.Point;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.initializers.InitializerBase;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   import org.flintparticles.twoD.zones.Zone2D;
   
   public class Velocity extends InitializerBase
   {
       
      
      private var _zone:Zone2D;
      
      public function Velocity(param1:Zone2D = null)
      {
         super();
         this.zone = param1;
      }
      
      public function get zone() : Zone2D
      {
         return _zone;
      }
      
      override public function initialize(param1:Emitter, param2:Particle) : void
      {
         var _loc3_:Particle2D = null;
         var _loc4_:Point = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         _loc3_ = Particle2D(param2);
         _loc4_ = _zone.getLocation();
         if(_loc3_.rotation == 0)
         {
            _loc3_.velX = _loc4_.x;
            _loc3_.velY = _loc4_.y;
         }
         else
         {
            _loc5_ = Math.sin(_loc3_.rotation);
            _loc6_ = Math.cos(_loc3_.rotation);
            _loc3_.velX = _loc6_ * _loc4_.x - _loc5_ * _loc4_.y;
            _loc3_.velY = _loc6_ * _loc4_.y + _loc5_ * _loc4_.x;
         }
      }
      
      public function set zone(param1:Zone2D) : void
      {
         _zone = param1;
      }
   }
}
