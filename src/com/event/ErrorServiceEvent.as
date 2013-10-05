package com.event
{
	import flash.events.Event;
	
	public class ErrorServiceEvent extends Event
	{
		
		public static const timeOut:String="ErrorServiceEvent.timeOut";
		
		public static const fault:String="ErrorServiceEvent.fault";
		
		public var message:String;
		
		public function ErrorServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}