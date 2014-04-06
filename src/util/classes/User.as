package util.classes
{
	
	
	import flash.events.EventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.TextFlow;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.events.CollectionEvent;
	import mx.events.PropertyChangeEvent;
	
	import org.igniterealtime.xiff.collections.events.CollectionEventKind;
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.swizframework.core.IDisposable;
	
	import util.Interface.IContact;
	import util.vo.entities.UserVO;
	import util.vo.entities.WebVO;
	
    
	[Bindable]
	public class User extends ContactBase implements IDisposable,IContact
	{
		
		
	
		
		public var userVO:UserVO;
		
		public var arrayList_session:ArrayList = new ArrayList();
		
		public var domainId:int;
		
		
		public var secondConnect:Number = 0;
		
		
		
		
		public function User()
		{
		 
			arrayList_session.addEventListener(CollectionEvent.COLLECTION_CHANGE,arrayList_session_changeHandler);
			
		
		   
			
		}
		
		public function getNickChat():String
		{
			
			return userVO.name;
			
		}

		
	

		public function getContactId():int
		{
			
			return userVO.id;
			
		}
		
		public function getContactName():String
		{
			
			return userVO.name;
			
		}
		
		

	

		

		private function arrayList_session_changeHandler(event:CollectionEvent):void
		{
		
		
		}
		
		
		
		
		
		
		public function destroy():void 
		{
			
		
			
			
		
		}

		
		
		
	}
}