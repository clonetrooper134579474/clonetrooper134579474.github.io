package fn
{
   public class GameState
   {
       
      
      public var UpdateState:Function;
      
      public var ExitState:Function;
      
      public var EnterState:Function;
      
      public var id:String;
      
      public function GameState(param1:String, param2:Function, param3:Function, param4:Function = null)
      {
         super();
         this.id = param1;
         EnterState = param2;
         ExitState = param4;
         UpdateState = param3;
      }
   }
}
