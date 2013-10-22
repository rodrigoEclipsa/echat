package Interface
{
	import util.classes.Contact;

	[Bindable]
	public interface Icontact
	{
		
		
		function get contact():Contact;
		function get historyText():String;
		function set historyText(value:String):void;
		
		
	}
}