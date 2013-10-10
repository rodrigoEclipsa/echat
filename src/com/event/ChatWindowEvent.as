package com.event
{
	import flash.events.Event;
	
	public class ChatWindowEvent extends Event
	{
		public function ChatWindowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}