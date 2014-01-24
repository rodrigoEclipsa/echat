package util.classes
{
	
	
	import Interface.IContact;
	
	import flash.events.EventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.TextFlow;
	
	import mx.collections.ArrayList;
	import mx.events.CollectionEvent;
	import mx.events.PropertyChangeEvent;
	
	import org.igniterealtime.xiff.collections.events.CollectionEventKind;
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.swizframework.core.IDisposable;
	
	import util.vo.entities.UserVO;
	import util.vo.entities.WebVO;
	
    
	[Bindable]
	public class User extends EventDispatcher implements IDisposable,IContact
	{
		
		
		///---------IContact
		
		private var _historyText:TextFlow;
	
		
		private var _lastChatJid:UnescapedJID;
		
		private var _lastChatTimeStamp:Number;
		
		private var _createAt:Number = new Date().time;
		
		
		
		public var online:Boolean =false;
		public var show:String;
		public var jid:UnescapedJID;
		
		
		//------------
		
		
		
		
		public var userVO:UserVO;
		
		public var arrayList_session:ArrayList = new ArrayList();
		
		
		
		public var secondConnect:Number = 0;
		
		
		
		
		public function User()
		{
		 
			arrayList_session.addEventListener(CollectionEvent.COLLECTION_CHANGE,arrayList_session_changeHandler);
			
		
		   
			
		}
		
		
		
		public function get createAt():Number
		{
			return _createAt;
		}

		public function set createAt(value:Number):void
		{
			_createAt = value;
		}

		public function getContactId():int
		{
			
			return userVO.id;
			
		}
		
		public function getContactName():String
		{
			
			return userVO.name;
			
		}
		
		

		public function get lastChatTimeStamp():Number
		{
			return _lastChatTimeStamp;
		}

		public function set lastChatTimeStamp(value:Number):void
		{
			_lastChatTimeStamp = value;
		}

		
		public function get lastChatJid():UnescapedJID
		{
			return _lastChatJid;
		}

		
		public function set lastChatJid(value:UnescapedJID):void
		{
			_lastChatJid = value;
		}

		public function get historyText():TextFlow
		{
			
			
			if(!_historyText)
			{
				
				
				_historyText = new TextFlow();
				
				var p:ParagraphElement = new ParagraphElement();
				_historyText.addChild(p);
				
				
			}
			return _historyText;
		}
		
		public function set historyText(value:TextFlow):void
		{
			_historyText = value;
		}

		

		private function arrayList_session_changeHandler(event:CollectionEvent):void
		{
			var dispatcherEvent:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
			this.dispatchEvent(dispatcherEvent);
		
		}
		
		
		
		
		
		
		public function destroy():void 
		{
			
			_contact = null;
			
			arrayList_session.removeEventListener(CollectionEvent.COLLECTION_CHANGE,arrayList_session_changeHandler);
		
		}

		
		
		
	}
}