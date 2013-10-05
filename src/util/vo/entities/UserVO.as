package util.vo.entities
{
	[Bindable]
	[RemoteClass(alias="UserVO")]
	public class UserVO
	{
		public function UserVO()
		{
		}
		
		public var id:int;
		public var domain_id:int;
		public var created_at:String;
		public var updated_at:String;
		public var password:String;
		public var name:String;
		public var surname:String;
		public var email:String;

	}
}