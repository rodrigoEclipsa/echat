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
		public var created_at:String;
		public var updated_at:String;
		public var name:String;

	}
}