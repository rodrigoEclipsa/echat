package util.classes
{
	
	
	import Interface.Icontact;
	
	import flash.events.EventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
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
		
		private var _historyText:String = "";
		private var _contact:Contact;
		//------------
		
		
		
		
		public var userVO:UserVO;
		
		public var arrayList_session:ArrayList = new ArrayList();
		
		
		
		public var minuteConnect:Number = 0;
		
		
		public var createAt:Number = new Date().time;
		
		public function User()
		{
		 
			arrayList_session.addEventListener(CollectionEvent.COLLECTION_CHANGE,arrayList_session_changeHandler);
			
		
		   
			
		}
		
		
		

		public function get historyText():String
		{
			return _historyText;
		}

		public function set historyText(value:String):void
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