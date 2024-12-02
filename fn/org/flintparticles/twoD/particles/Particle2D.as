package org.flintparticles.twoD.particles
{
   import flash.geom.Matrix;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.particles.ParticleFactory;
   
   public class Particle2D extends Particle
   {
       
      
      private var _previousRadius:Number;
      
      public var sortID:int = -1;
      
      public var previousX:Number = 0;
      
      public var previousY:Number = 0;
      
      public var angVelocity:Number = 0;
      
      public var velX:Number = 0;
      
      private var _previousMass:Number;
      
      public var velY:Number = 0;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      private var _inertia:Number;
      
      public var rotation:Number = 0;
      
      public function Particle2D()
      {
         x = 0;
         y = 0;
         previousX = 0;
         previousY = 0;
         velX = 0;
         velY = 0;
         rotation = 0;
         angVelocity = 0;
         sortID = -1;
         super();
      }
      
      override public function initialize() : void
      {
         super.initialize();
         x = 0;
         y = 0;
         previousX = 0;
         previousY = 0;
         velX = 0;
         velY = 0;
         rotation = 0;
         angVelocity = 0;
         sortID = -1;
      }
      
      public function get matrixTransform() : Matrix
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         _loc1_ = scale * Math.cos(rotation);
         _loc2_ = scale * Math.sin(rotation);
         return new Matrix(_loc1_,_loc2_,-_loc2_,_loc1_,x,y);
      }
      
      public function get inertia() : Number
      {
         if(mass != _previousMass || collisionRadius != _previousRadius)
         {
            _inertia = mass * collisionRadius * collisionRadius * 0.5;
            _previousMass = mass;
            _previousRadius = collisionRadius;
         }
         return _inertia;
      }
      
      override public function clone(param1:ParticleFactory = null) : Particle
      {
         var _loc2_:Particle2D = null;
         if(param1)
         {
            _loc2_ = param1.createParticle() as Particle2D;
         }
         else
         {
            _loc2_ = new Particle2D();
         }
         cloneInto(_loc2_);
         _loc2_.x = x;
         _loc2_.y = y;
         _loc2_.velX = velX;
         _loc2_.velY = velY;
         _loc2_.rotation = rotation;
         _loc2_.angVelocity = angVelocity;
         return _loc2_;
      }
   }
}
