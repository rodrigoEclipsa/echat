package util.Interface
{
	
	
	import flashx.textLayout.elements.TextFlow;
	
	import org.apache.flex.collections.ArrayList;
	import org.igniterealtime.xiff.core.UnescapedJID;
	
	

	[Bindable]
	public interface IContact
	{
		
		function get createAt():Number
		function set createAt(value:Number):void
			
			
	
		
		function get historyText():ArrayList;
		function set historyText(value:ArrayList):void;
		
		
		function get lastChatTimeStamp():Number;
		function set lastChatTimeStamp(value:Number):void;
		
	     function getNickChat():String
	
		 
			 
			 
		function get lastChatConatactId():int
	    function set lastChatConatactId(value:int):void
	
		
			
			
		function get jid():UnescapedJID
		function get show():String
		function get online():Boolean
		
			
			
			
		function getContactId():int
			
		function getContactName():String
		
	}
}