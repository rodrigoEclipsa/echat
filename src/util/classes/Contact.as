package util.classes
{
	import org.igniterealtime.xiff.core.UnescapedJID;

	[Bindable]
	public class Contact
	{
		
		
		public var online:Boolean =false;
		public var show:String;
		public var jid:UnescapedJID;
		
		public function Contact(jid:UnescapedJID)
		{
			this.jid = jid;
		}
	}
}