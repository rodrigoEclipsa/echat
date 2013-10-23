package Interface
{
	import flashx.textLayout.elements.TextFlow;
	
	import util.classes.Contact;

	[Bindable]
	public interface Icontact
	{
		
		
		function get contact():Contact;
		
		function get historyText():TextFlow;
		function set historyText(value:TextFlow):void;
		
		
		/**
		 * si es true el usuario fue el ultimo que escribio, si es false fue el agente
		 * **/
		function get lastAppendText():Boolean;
		function set lastAppendText(value:Boolean):void;
		
		
	}
}