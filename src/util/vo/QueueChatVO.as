package util.vo
{
	import mx.collections.ArrayList;

	import org.igniterealtime.xiff.core.EscapedJID;

	[Bindable]
	public class QueueChatVO
	{



		//----------------info user
		public var ip:String;


		public var hostName:String;
		public var browser:String;
		public var is_popUp:Boolean=false;


		public var country:String;
		public var state:String;
		public var city:String;


		public var username:String;

		public var email:String;

      //---------------
		
		
		public var jid:EscapedJID;

		
		public var isWriting:int;

		public var inputChatText:String;

		public var online:Boolean=true;

		public var showAlarm:Boolean=false;



		public var arrayList_historyChat:ArrayList=new ArrayList();






	}



}