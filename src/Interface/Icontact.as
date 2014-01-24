package Interface
{
	import flashx.textLayout.elements.TextFlow;
	
	import org.igniterealtime.xiff.core.UnescapedJID;
	
	import util.classes.Contact;

	[Bindable]
	public interface IContact
	{
		
		function get createAt():Number
		function set createAt(value:Number):void
			
			
		function get contact():Contact;
		
		function get historyText():TextFlow;
		function set historyText(value:TextFlow):void;
		
		
		/**
		 * jid del ultimo contacto que realizo un chat
		 * **/
		function get lastChatJid():UnescapedJID;
		function set lastChatJid(value:UnescapedJID):void;
		
		
		
		function get lastChatTimeStamp():Number;
		function set lastChatTimeStamp(value:Number):void;
		
		
		function getContactId():int
			
		function getContactName():String
		
	}
}