package util.vo.entities
{
	[Bindable]
	[RemoteClass(alias="DomainVO")]
	public class DomainVO
	{
		public function DomainVO()
		{
		}
		
		public var id:int;
		public var plan_id:int;
		public var created_at:Number;
		public var updated_at:Number;
		public var description:String;
		public var name:String;

	}
}