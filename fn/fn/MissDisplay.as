package fn
{
   import com.exileetiquette.loader.LoadManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class MissDisplay extends Sprite
   {
       
      
      internal var maxMissCount:* = 0;
      
      internal var missCount:* = 0;
      
      internal var msg:TextField;
      
      internal const SHAKE_AMOUNT:Number = 10;
      
      internal var crosses:Array;
      
      internal var shakeTimer:Number = 0;
      
      public function MissDisplay(param1:Number)
      {
         var _loc2_:TextFormat = null;
         var _loc3_:Number = NaN;
         var _loc4_:* = undefined;
         missCount = 0;
         maxMissCount = 0;
         shakeTimer = 0;
         super();
         msg = new TextField();
         msg.autoSize = TextFieldAutoSize.RIGHT;
         _loc2_ = new TextFormat();
         _loc2_.size = 24;
         _loc2_.font = "MSTK";
         _loc2_.color = 16761088;
         _loc2_.align = "right";
         msg.defaultTextFormat = _loc2_;
         msg.antiAliasType = AntiAliasType.ADVANCED;
         msg.text = "Misses:";
         msg.selectable = false;
         msg.embedFonts = true;
         addChild(msg);
         maxMissCount = param1;
         missCount = 0;
         crosses = new Array();
         _loc3_ = 0;
         while(_loc3_ < maxMissCount)
         {
            (_loc4_ = new Bitmap(BitmapData(LoadManager.getInstance().getFile("cross.png")))).x = msg.width + _loc3_ * _loc4_.width;
            _loc4_.y = 0;
            _loc4_.alpha = 0.5;
            crosses.push(_loc4_);
            addChild(_loc4_);
            _loc3_++;
         }
         x = 480 - width - 10;
         y = 10;
         addEventListener(Event.ENTER_FRAME,Update);
      }
      
      public function AddMiss() : *
      {
         shakeTimer = 60;
         if(crosses[missCount])
         {
            crosses[missCount].alpha = 1;
         }
         missCount = Math.min(missCount + 1,maxMissCount);
      }
      
      public function Reset() : *
      {
         var _loc1_:Number = NaN;
         missCount = 0;
         _loc1_ = 0;
         while(_loc1_ < maxMissCount)
         {
            crosses[_loc1_].alpha = 0.5;
            _loc1_++;
         }
      }
      
      private function Update(param1:Event) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Bitmap = null;
         _loc2_ = 0;
         while(_loc2_ < maxMissCount)
         {
            if(_loc2_ == missCount - 1 && shakeTimer > 0)
            {
               --shakeTimer;
               _loc3_ = crosses[_loc2_];
               _loc3_.x = msg.width + (missCount - 1) * _loc3_.width + Math.random() * SHAKE_AMOUNT - SHAKE_AMOUNT / 2;
               _loc3_.y = Math.random() * SHAKE_AMOUNT - SHAKE_AMOUNT / 2;
            }
            else
            {
               crosses[_loc2_].x = msg.width + _loc2_ * crosses[_loc2_].width;
               crosses[_loc2_].y = 0;
            }
            _loc2_++;
         }
      }
   }
}
