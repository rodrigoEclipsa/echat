package util.vo.entities
{
	[Bindable]
	[RemoteClass(alias="WebVO")]
	public class WebVO
	{
		public function WebVO()
		{
		}
		
		public var id:int;
		public var create_at:String;
		public var updated_at:String;
		public var url:String;
		public var title:String;
		public var user_id:int;

	}
}