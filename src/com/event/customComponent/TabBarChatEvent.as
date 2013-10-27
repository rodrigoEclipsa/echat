package com.event.customComponent
{
	
	
	import Interface.IContact;
	
	import flash.events.Event;
	
	import util.classes.User;
	
	public class TabBarChatEvent extends Event
	{
		
	
		public static const close:String = "close";
		
		
		public var contact:IContact;
		
		public function TabBarChatEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		
	}
}