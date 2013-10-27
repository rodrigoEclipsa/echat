package util.vo.entities
{
	[Bindable]
	[RemoteClass(alias="PlanVO")]
	public class PlanVO
	{
		public function PlanVO()
		{
		}
		
		public var id:int;
		public var created_at:Number;
		public var updated_at:Number;
		public var name:String;
		public var num_agent:int;

	}
}