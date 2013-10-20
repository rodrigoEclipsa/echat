package util.classes
{
	
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import mx.collections.ArrayList;
	import mx.events.CollectionEvent;
	import mx.events.PropertyChangeEvent;
	
	import org.igniterealtime.xiff.collections.events.CollectionEventKind;
	
	import util.vo.entities.UserVO;
	import util.vo.entities.WebVO;
	
    
	[Bindable]
	public class User 
	{
		
		public var type:String="user";

		public var contact:Contact;
		
		public var userVO:UserVO;
		
		public var arrayList_session:ArrayList = new ArrayList();
		
		
		
		public var minuteConnect:Number = 0;
		private var interval:uint;
		
		private var stampTime:Number = new Date().time;
		
		public function User()
		{
		 
			arrayList_session.addEventListener(CollectionEvent.COLLECTION_CHANGE,arrayList_session_changeHandler);
			
			interval = setInterval(interval_minuteHadler,60000);
		   
			
		}
		
		
	
		
		
		

		private function arrayList_session_changeHandler(event:CollectionEvent):void
		{
			var dispatcherEvent:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
			this.dispatchEvent(dispatcherEvent);
			
		}
		
		
		public function interval_minuteHadler():void
		{
			
			
			var date:Date = new Date();
			
			date.time = date.time - stampTime;
			
			minuteConnect = date.seconds;
			
		}
		
		
		
		public function stopInterval():void
		{
			
			clearInterval(interval);
		}
		
		public function startInterval():void
		{
			interval = setInterval(interval_minuteHadler,60000);
		}
		
		
		public function clearClass():void
		{
			
			arrayList_session.removeEventListener(CollectionEvent.COLLECTION_CHANGE,arrayList_session_changeHandler);
			stopInterval();
		}
		
		
		
	}
}