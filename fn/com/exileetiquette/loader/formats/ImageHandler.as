package com.exileetiquette.loader.formats
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class ImageHandler extends SWFHandler
   {
       
      
      private var _bitmapData:BitmapData;
      
      public function ImageHandler()
      {
         super();
      }
      
      override public function getContent() : *
      {
         if(!loaded)
         {
            return null;
         }
         if(!_bitmapData)
         {
            _bitmapData = Bitmap(_loader.content).bitmapData;
         }
         return _bitmapData;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(_bitmapData)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
      }
   }
}
