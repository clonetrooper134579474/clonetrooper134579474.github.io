package com.exileetiquette.loader.formats
{
   import flash.net.URLLoaderDataFormat;
   import flash.utils.ByteArray;
   
   public class BinaryHandler extends GenericHandler
   {
       
      
      private var _data:ByteArray;
      
      public function BinaryHandler()
      {
         super();
         _loader.dataFormat = URLLoaderDataFormat.BINARY;
      }
      
      override public function getContent() : *
      {
         if(!loaded)
         {
            return null;
         }
         if(!_data)
         {
            _data = ByteArray(_loader.data);
         }
         return _data;
      }
      
      override public function destroy() : void
      {
         _data = null;
         super.destroy();
      }
   }
}
