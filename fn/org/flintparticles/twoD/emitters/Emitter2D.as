package org.flintparticles.twoD.emitters
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.particles.ParticleFactory;
   import org.flintparticles.common.utils.Maths;
   import org.flintparticles.twoD.particles.Particle2D;
   import org.flintparticles.twoD.particles.ParticleCreator2D;
   
   public class Emitter2D extends Emitter
   {
      
      protected static var _creator:ParticleCreator2D = new ParticleCreator2D();
       
      
      protected var _y:Number = 0;
      
      protected var _x:Number = 0;
      
      public var spaceSort:Boolean = false;
      
      public var spaceSortedX:Array;
      
      protected var _rotation:Number = 0;
      
      public function Emitter2D()
      {
         _x = 0;
         _y = 0;
         _rotation = 0;
         spaceSort = false;
         super();
         _particleFactory = _creator;
      }
      
      public static function get defaultParticleFactory() : ParticleFactory
      {
         return _creator;
      }
      
      public function set rotation(param1:Number) : void
      {
         _rotation = Maths.asRadians(param1);
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
      }
      
      override protected function sortParticles() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(spaceSort)
         {
            spaceSortedX = _particles.sortOn("x",Array.NUMERIC | Array.RETURNINDEXEDARRAY);
            _loc1_ = int(_particles.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               Particle2D(_particles[spaceSortedX[_loc2_]]).sortID = _loc2_;
               _loc2_++;
            }
         }
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      override protected function initParticle(param1:Particle) : void
      {
         var _loc2_:Particle2D = null;
         _loc2_ = Particle2D(param1);
         _loc2_.x = _x;
         _loc2_.y = _y;
         _loc2_.previousX = _x;
         _loc2_.previousY = _y;
         _loc2_.rotation = _rotation;
      }
      
      public function set rotRadians(param1:Number) : void
      {
         _rotation = param1;
      }
      
      public function get rotRadians() : Number
      {
         return _rotation;
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
      }
      
      public function get rotation() : Number
      {
         return Maths.asDegrees(_rotation);
      }
   }
}
