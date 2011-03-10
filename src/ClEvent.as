package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author hua.qiuh, http://alibaba.cn
	 */
	public class ClEvent  extends Event
	{
		
		public var id:int;
		
		public function ClEvent(id:int) 
		{
			super("clickEvent");
			this.id = id;
		}
		
	}

}