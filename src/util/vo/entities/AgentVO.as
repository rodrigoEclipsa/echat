package util.vo.entities
{
	[Bindable]
	[RemoteClass(alias="AgentVO")]
	public class AgentVO
	{
	
		
		public var id:int;
		public var created_at:Number;
		public var updated_at:Number;
		public var email:String;
		public var name:String;
		public var password:String;
		
		public var nick:String;
		public var surname:String;
		public var enabled:Boolean = true;
		
		public function AgentVO()
		{
		}
		
		

	}
}