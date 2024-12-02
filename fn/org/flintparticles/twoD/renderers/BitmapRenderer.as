package org.flintparticles.twoD.renderers
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.filters.BitmapFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.flintparticles.common.renderers.SpriteRendererBase;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class BitmapRenderer extends SpriteRendererBase
   {
      
      protected static var ZERO_POINT:Point = new Point(0,0);
       
      
      protected var _smoothing:Boolean;
      
      protected var _clearBetweenFrames:Boolean;
      
      protected var _bitmapData:BitmapData;
      
      protected var _colorMap:Array;
      
      protected var _bitmap:Bitmap;
      
      protected var _postFilters:Array;
      
      protected var _preFilters:Array;
      
      protected var _canvas:Rectangle;
      
      public function BitmapRenderer(param1:Rectangle, param2:Boolean = false)
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         _smoothing = param2;
         _preFilters = new Array();
         _postFilters = new Array();
         _canvas = param1;
         createBitmap();
         _clearBetweenFrames = true;
      }
      
      public function setPaletteMap(param1:Array = null, param2:Array = null, param3:Array = null, param4:Array = null) : void
      {
         _colorMap = new Array(4);
         _colorMap[0] = param4;
         _colorMap[1] = param1;
         _colorMap[2] = param2;
         _colorMap[3] = param3;
      }
      
      public function set clearBetweenFrames(param1:Boolean) : void
      {
         _clearBetweenFrames = param1;
      }
      
      public function clearPaletteMap() : void
      {
         _colorMap = null;
      }
      
      public function removeFilter(param1:BitmapFilter) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _preFilters.length)
         {
            if(_preFilters[_loc2_] == param1)
            {
               _preFilters.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _postFilters.length)
         {
            if(_postFilters[_loc2_] == param1)
            {
               _postFilters.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
      }
      
      public function get postFilters() : Array
      {
         return _postFilters.slice();
      }
      
      protected function createBitmap() : void
      {
         if(!_canvas)
         {
            return;
         }
         if(Boolean(_bitmap) && Boolean(_bitmapData))
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
         if(_bitmap)
         {
            removeChild(_bitmap);
            _bitmap = null;
         }
         _bitmap = new Bitmap(null,"auto",_smoothing);
         _bitmapData = new BitmapData(Math.ceil(_canvas.width),Math.ceil(_canvas.height),true,0);
         _bitmap.bitmapData = _bitmapData;
         addChild(_bitmap);
         _bitmap.x = _canvas.x;
         _bitmap.y = _canvas.y;
      }
      
      public function get canvas() : Rectangle
      {
         return _canvas;
      }
      
      public function set postFilters(param1:Array) : void
      {
         var _loc2_:BitmapFilter = null;
         for each(_loc2_ in _postFilters)
         {
            removeFilter(_loc2_);
         }
         for each(_loc2_ in param1)
         {
            addFilter(_loc2_,true);
         }
      }
      
      public function get smoothing() : Boolean
      {
         return _smoothing;
      }
      
      public function get clearBetweenFrames() : Boolean
      {
         return _clearBetweenFrames;
      }
      
      public function addFilter(param1:BitmapFilter, param2:Boolean = false) : void
      {
         if(param2)
         {
            _postFilters.push(param1);
         }
         else
         {
            _preFilters.push(param1);
         }
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
      
      override protected function renderParticles(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!_bitmap)
         {
            return;
         }
         _bitmapData.lock();
         _loc3_ = int(_preFilters.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _bitmapData.applyFilter(_bitmapData,_bitmapData.rect,BitmapRenderer.ZERO_POINT,_preFilters[_loc2_]);
            _loc2_++;
         }
         if(_clearBetweenFrames && _loc3_ == 0)
         {
            _bitmapData.fillRect(_bitmap.bitmapData.rect,0);
         }
         _loc3_ = int(param1.length);
         if(_loc3_)
         {
            _loc2_ = _loc3_;
            while(_loc2_--)
            {
               drawParticle(param1[_loc2_]);
            }
         }
         _loc3_ = int(_postFilters.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _bitmapData.applyFilter(_bitmapData,_bitmapData.rect,BitmapRenderer.ZERO_POINT,_postFilters[_loc2_]);
            _loc2_++;
         }
         if(_colorMap)
         {
            _bitmapData.paletteMap(_bitmapData,_bitmapData.rect,ZERO_POINT,_colorMap[1],_colorMap[2],_colorMap[3],_colorMap[0]);
         }
         _bitmapData.unlock();
      }
      
      public function set preFilters(param1:Array) : void
      {
         var _loc2_:BitmapFilter = null;
         for each(_loc2_ in _preFilters)
         {
            removeFilter(_loc2_);
         }
         for each(_loc2_ in param1)
         {
            addFilter(_loc2_,false);
         }
      }
      
      public function set canvas(param1:Rectangle) : void
      {
         _canvas = param1;
         createBitmap();
      }
      
      public function set smoothing(param1:Boolean) : void
      {
         _smoothing = param1;
         if(_bitmap)
         {
            _bitmap.smoothing = param1;
         }
      }
      
      protected function drawParticle(param1:Particle2D) : void
      {
         var _loc2_:Matrix = null;
         _loc2_ = param1.matrixTransform;
         _loc2_.translate(-_canvas.x,-_canvas.y);
         _bitmapData.draw(param1.image,_loc2_,param1.colorTransform,DisplayObject(param1.image).blendMode,null,_smoothing);
      }
      
      public function get preFilters() : Array
      {
         return _preFilters.slice();
      }
   }
}
