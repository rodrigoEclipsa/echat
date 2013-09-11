package  service
{
	import flash.events.Event;
	
	public class ErrorServiceEvent extends Event
	{
		
		
		public static const timeOut:String = "ErrorServiceEvent.timeOut";
		
		public static const error:String = "ErrorServiceEvent.error";
		
		
		
		public var message:String;
		
		public function ErrorServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}