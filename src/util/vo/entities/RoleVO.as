package util.vo.entities
{
	[Bindable]
	[RemoteClass(alias="RoleVO")]
	public class RoleVO
	{
		public function RoleVO()
		{
		}
		
		public var id:int;
		public var created_at:Number;
		public var updated_at:Number;
		public var name:String;

	}
}