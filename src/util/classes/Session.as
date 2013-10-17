package util.classes
{
	import flash.utils.setInterval;
	

	
	import util.vo.entities.WebVO;
	
	[Bindable]
	public class Session
	{
		
		public var resource:String;
		
		public var webVO:WebVO;
		
	
		
		public function Session(resource:String)
		{
			
			
			this.resource = resource;
		}
		
		
		
		
	}
}