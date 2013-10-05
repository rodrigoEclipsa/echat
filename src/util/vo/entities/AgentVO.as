package util.vo.entities
{
	[Bindable]
	[RemoteClass(alias="AgentVO")]
	public class AgentVO
	{
		public function AgentVO()
		{
		}
		
		public var id:int;
		public var created_at:String;
		public var updated_at:String;
		public var email:String;
		public var name:String;
		public var password:String;

	}
}