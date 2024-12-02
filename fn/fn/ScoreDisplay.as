package fn
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class ScoreDisplay extends Sprite
   {
       
      
      internal var scale:Number = 1;
      
      internal const MAX_SCORE_SHAKE:Number = 7;
      
      internal var targetScore:* = 0;
      
      internal var currentScore:* = 0;
      
      internal var score:TextField;
      
      internal const SCORE_SHAKE:Number = 0.01;
      
      public function ScoreDisplay()
      {
         var _loc1_:TextFormat = null;
         currentScore = 0;
         targetScore = 0;
         scale = 1;
         super();
         score = new TextField();
         score.autoSize = TextFieldAutoSize.RIGHT;
         score.text = "";
         _loc1_ = new TextFormat();
         _loc1_.size = 24;
         _loc1_.font = "MSTK";
         _loc1_.color = 16761088;
         _loc1_.align = "right";
         score.defaultTextFormat = _loc1_;
         score.antiAliasType = AntiAliasType.ADVANCED;
         score.selectable = false;
         score.embedFonts = true;
         addChild(score);
         addEventListener(Event.ENTER_FRAME,Update);
      }
      
      public function SetScore(param1:Number) : *
      {
         targetScore = param1;
      }
      
      public function SnapToScore(param1:Number) : *
      {
         currentScore = targetScore = param1;
      }
      
      private function Update(param1:Event) : *
      {
         var _loc2_:* = undefined;
         if(targetScore != currentScore)
         {
            _loc2_ = Math.min(MAX_SCORE_SHAKE,(currentScore - targetScore) * SCORE_SHAKE);
            score.x = Math.random() * _loc2_ - _loc2_ / 2;
            score.y = Math.random() * _loc2_ - _loc2_ / 2;
            score.scaleX = 1 + Math.abs(currentScore - targetScore) / 50;
            score.scaleY = score.scaleX;
            if(targetScore > currentScore)
            {
               ++currentScore;
            }
            else
            {
               --currentScore;
            }
         }
         else
         {
            score.x = 0;
            score.y = 0;
         }
         score.text = currentScore + " Pts!";
         if(scale > 1)
         {
         }
         x = 10;
         y = 10;
      }
   }
}
