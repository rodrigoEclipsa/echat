package util.Interface
{
	import flashx.textLayout.elements.TextFlow;
	
	import org.igniterealtime.xiff.core.UnescapedJID;
	
	

	[Bindable]
	public interface IContact
	{
		
		function get createAt():Number
		function set createAt(value:Number):void
			
			
	
		
		function get historyText():TextFlow;
		function set historyText(value:TextFlow):void;
		
		
		/**
		 * jid del ultimo contacto que realizo un chat
		 * **/
		function get lastChatJid():UnescapedJID;
		function set lastChatJid(value:UnescapedJID):void;
		
		
		
		function get lastChatTimeStamp():Number;
		function set lastChatTimeStamp(value:Number):void;
		
		
		
		
		
		function get jid():UnescapedJID
		function get show():String
		function get online():Boolean
		
			
			
			
		function getContactId():int
			
		function getContactName():String
		
	}
}