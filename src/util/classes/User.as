package util.classes
{
	import flash.utils.setInterval;
	
	import mx.collections.ArrayList;
	import mx.events.CollectionEvent;
	
	import org.igniterealtime.xiff.collections.events.CollectionEventKind;
	
	import util.vo.entities.UserVO;
	import util.vo.entities.WebVO;
	
    
	[Bindable]
	public class User
	{
		
		
		public var userVO:UserVO;
		public var arrayList_webVO:ArrayList = new ArrayList();
		
		
		
		public var minuteConnect:Number = 0;
		public var textDisplayedWebs:String = "";
		
		
		
		private var interval:uint;
		
		private var stampTime:Number = new Date().time;
		
		
		
		public function User()
		{
		
			
		   interval = setInterval(interval_minuteHadler,60000);
		
		   //si se agrega una nueva web actualizo el label
		   arrayList_webVO.addEventListener(CollectionEvent.COLLECTION_CHANGE,arrayList_webVO_changeHandler);
		   
		   
		}
		
		
		private function arrayList_webVO_changeHandler(event:CollectionEvent):void
		{
		
				
				var webs:String= "";
				
		
				for each(var webVOItem:WebVO in arrayList_webVO.source)
				webs +="* "+webVOItem.title; 
				
				
				textDisplayedWebs = webs;
			
			
			
		}
		
	

		public function interval_minuteHadler():void
		{
			var date:Date = new Date();
			
			date.time = date.time - stampTime;
			
			minuteConnect = date.seconds;
			
		}
		
	}
}