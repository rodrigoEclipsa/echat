package util.classes
{
	import flash.utils.setInterval;
	
	import mx.collections.ArrayList;
	
	import util.vo.entities.UserVO;
	
    
	[Bindable]
	public class User
	{
		
		
		public var userVO:UserVO;
		public var arrayList_webVO:ArrayList = new ArrayList();
		
		
		public var minuteConnect:uint;
		
		
		public var interval:uint;
		
		public function User()
		{
			
		   interval = setInterval(interval_minuteHadler,1000);
			
		}
		
		
		
		
	

		public function interval_minuteHadler():void
		{
			minuteConnect++;
			
		}
		
	}
}