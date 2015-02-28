package util.vo.entities
{
	[Bindable]
	
	public class UserVO
	{
		public function UserVO()
		{
		}
		
		public var id:int;
		public var domain_id:uint;
		public var created_at:Number;
		public var updated_at:Number;
		public var password:String;
		public var name:String;
		public var surname:String;
		public var email:String;

	}
}