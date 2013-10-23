package util.classes
{
	
	
	import Interface.Icontact;
	
	import flash.events.EventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import flashx.textLayout.elements.TextFlow;
	
	import mx.collections.ArrayList;
	import mx.events.CollectionEvent;
	import mx.events.PropertyChangeEvent;
	
	import org.igniterealtime.xiff.collections.events.CollectionEventKind;
	import org.swizframework.core.IDisposable;
	
	import util.vo.entities.UserVO;
	import util.vo.entities.WebVO;
	
    
	[Bindable]
	public class User extends EventDispatcher implements IDisposable,Icontact
	{
		
		
		///---------IContact
		
		private var _historyText:TextFlow;
		private var _contact:Contact;
		
		private var _lastAppendText:Boolean = false;
		//------------
		
		
		
		
		public var userVO:UserVO;
		
		public var arrayList_session:ArrayList = new ArrayList();
		
		
		
		public var secondConnect:Number = 0;
		
		
		public var createAt:Number = new Date().time;
		
		public function User()
		{
		 
			arrayList_session.addEventListener(CollectionEvent.COLLECTION_CHANGE,arrayList_session_changeHandler);
			
		
		   
			
		}
		
		
		

		/**
		 * si es true el usuario fue el ultimo que escribio, si es false fue el agente
		 * **/
		public function get lastAppendText():Boolean
		{
			return _lastAppendText;
		}

		
	
		public function set lastAppendText(value:Boolean):void
		{
			_lastAppendText = value;
		}

		public function get historyText():TextFlow
		{
			if(!_historyText)
				_historyText = new TextFlow();
				
			return _historyText;
		}

		public function set historyText(value:TextFlow):void
		{
			_historyText = value;
		}

		public function get contact():Contact
		{
			return _contact;
		}

		public function set contact(value:Contact):void
		{
			_contact = value;
		}

		private function arrayList_session_changeHandler(event:CollectionEvent):void
		{
			var dispatcherEvent:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
			this.dispatchEvent(dispatcherEvent);
		
		}
		
		
		
		
		
		
		public function destroy():void 
		{
			
			contact = null;
		
			arrayList_session.removeEventListener(CollectionEvent.COLLECTION_CHANGE,arrayList_session_changeHandler);
		
		}

		
		
		
	}
}