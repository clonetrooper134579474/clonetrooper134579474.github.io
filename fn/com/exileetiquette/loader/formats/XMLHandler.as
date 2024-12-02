package com.exileetiquette.loader.formats
{
   public class XMLHandler extends GenericHandler
   {
       
      
      private var _data:XML;
      
      public function XMLHandler()
      {
         super();
      }
      
      override public function getContent() : *
      {
         if(!loaded)
         {
            return null;
         }
         if(!_data)
         {
            _data = new XML(_loader.data);
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
