package util.vo.entities
{
	[Bindable]
	public class WebVO
	{
		public function WebVO()
		{
		}
		
		public var id:int;
		public var create_at:Number;
		public var updated_at:Number;
		public var url:String;
		public var title:String;
		public var user_id:int;

	}
}