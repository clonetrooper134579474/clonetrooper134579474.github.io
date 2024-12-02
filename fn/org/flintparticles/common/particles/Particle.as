package org.flintparticles.common.particles
{
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   
   public class Particle
   {
       
      
      public var lifetime:Number = 0;
      
      public var scale:Number = 1;
      
      public var energy:Number = 1;
      
      public var image:* = null;
      
      public var color:uint = 4294967295;
      
      public var collisionRadius:Number = 1;
      
      private var _colorTransform:ColorTransform = null;
      
      private var _previousColor:uint;
      
      public var isDead:Boolean = false;
      
      public var mass:Number = 1;
      
      private var _dictionary:Dictionary = null;
      
      public var age:Number = 0;
      
      public function Particle()
      {
         color = 4294967295;
         _colorTransform = null;
         scale = 1;
         mass = 1;
         collisionRadius = 1;
         image = null;
         lifetime = 0;
         age = 0;
         energy = 1;
         isDead = false;
         _dictionary = null;
         super();
      }
      
      public function get dictionary() : Dictionary
      {
         if(_dictionary == null)
         {
            _dictionary = new Dictionary(true);
         }
         return _dictionary;
      }
      
      public function get colorTransform() : ColorTransform
      {
         if(!_colorTransform || _previousColor != color)
         {
            _colorTransform = new ColorTransform((color >>> 16 & 255) / 255,(color >>> 8 & 255) / 255,(color & 255) / 255,(color >>> 24 & 255) / 255,0,0,0,0);
            _previousColor = color;
         }
         return _colorTransform;
      }
      
      protected function cloneInto(param1:Particle) : Particle
      {
         var _loc2_:Object = null;
         param1.color = color;
         param1.scale = scale;
         param1.mass = mass;
         param1.collisionRadius = collisionRadius;
         param1.lifetime = lifetime;
         param1.age = age;
         param1.energy = energy;
         param1.isDead = isDead;
         param1.image = image;
         if(_dictionary)
         {
            param1._dictionary = new Dictionary(true);
            for(_loc2_ in _dictionary)
            {
               param1._dictionary[_loc2_] = _dictionary[_loc2_];
            }
         }
         return param1;
      }
      
      public function get alpha() : Number
      {
         return ((color & 4278190080) >>> 24) / 255;
      }
      
      public function clone(param1:ParticleFactory = null) : Particle
      {
         var _loc2_:Particle = null;
         if(param1)
         {
            _loc2_ = param1.createParticle();
         }
         else
         {
            _loc2_ = new Particle();
         }
         return cloneInto(_loc2_);
      }
      
      public function initialize() : void
      {
         color = 4294967295;
         scale = 1;
         mass = 1;
         collisionRadius = 1;
         lifetime = 0;
         age = 0;
         energy = 1;
         isDead = false;
         image = null;
         _dictionary = null;
         _colorTransform = null;
      }
   }
}
