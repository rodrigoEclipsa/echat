package util.classes
{
	import flashx.textLayout.elements.ParagraphElement;
	
	import mx.collections.ArrayCollection;
	
	import org.apache.flex.collections.ArrayList;
	import org.igniterealtime.xiff.core.UnescapedJID;
	

     [Bindable]
	public class ContactBase 
	{
		
		
		private var _historyText:ArrayList;
		
		
		
		private var _lastChatConatactId:int;
		
		private var _createAt:Number=new Date().time;
		
		private var _lastChatTimeStamp:Number;
		
		private var _online:Boolean =false;
		private var _show:String;
		private var _jid:UnescapedJID;
		
		
		
		
		
		
		
		
		public function get lastChatConatactId():int
		{
			return _lastChatConatactId;
		}

		public function set lastChatConatactId(value:int):void
		{
			_lastChatConatactId = value;
		}

		public function get historyText():ArrayList
		{
			
			if(!_historyText)
			{
				
				
				_historyText = new ArrayList();
				
				
				
				
			}
			
			
			return _historyText;
			
		}
		
		public function set historyText(value:ArrayList):void
		{
			_historyText=value;
		}
		

		
		
		public function get lastChatTimeStamp():Number
		{
			return _lastChatTimeStamp;
		}
		
		public function set lastChatTimeStamp(value:Number):void
		{
			_lastChatTimeStamp = value;
		}
		
	
		
		public function get jid():UnescapedJID
		{
			return _jid;
		}
		
		public function set jid(value:UnescapedJID):void
		{
			_jid = value;
		}
		
		public function get show():String
		{
			return _show;
		}
		
		public function set show(value:String):void
		{
			_show = value;
		}
		
		public function get online():Boolean
		{
			return _online;
		}
		
		public function set online(value:Boolean):void
		{
			_online = value;
		}
		
		public function get createAt():Number
		{
			return _createAt;
		}
		
		public function set createAt(value:Number):void
		{
			_createAt = value;
		}
		
		
		
		
		
		
		
	}
}