package org.flintparticles.common.initializers
{
   import flash.display.DisplayObject;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class SharedImage extends InitializerBase
   {
       
      
      private var _image:DisplayObject;
      
      public function SharedImage(param1:DisplayObject = null)
      {
         super();
         _image = param1;
      }
      
      override public function initialize(param1:Emitter, param2:Particle) : void
      {
         param2.image = _image;
      }
      
      public function get image() : DisplayObject
      {
         return _image;
      }
      
      public function set image(param1:DisplayObject) : void
      {
         _image = param1;
      }
   }
}
