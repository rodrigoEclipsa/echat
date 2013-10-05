package util.vo
{
	[Bindable]
	[RemoteClass(alias="ResultVO")]
	public class ResultVO
	{
		
	
		public var success:Boolean = false; 
		public var data:Object;
		public var errorMenssage:String;
		
		
	}
}