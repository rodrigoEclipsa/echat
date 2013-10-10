package com.event.renderer
{
	import flash.events.Event;
	
	import util.classes.User;
	
	public class TabChatEvent extends Event
	{
		
		public static const close:String="TabChatEvent.close";
		public static const open:String="TabChatEvent.open";
		
		
		public var user:User;
		
		
		public function TabChatEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}