package  
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author qhwa, http://china.alibaba.com
	 */
	public class Image extends Loader
	{
		
		public var w:Number;
		public var h:Number;
		public var boxW:Number;
		public var boxH:Number;
		public var src:String;
		public var id:int;
		
		/**
		 * 
		 * @param	src		图片地址
		 * @param	width	图片最大宽度
		 * @param	height	图片最大高度
		 * @param	boxWidth	容器宽度
		 * @param	boxHeight	容器高度
		 */
		public function Image(src:String="", width:Number=-1, height:Number=-1, boxWidth:Number=0, boxHeight:Number=0) 
		{
			w = width;
			h = height;
			boxW = boxWidth;
			boxH = boxHeight;
			
			var req:URLRequest = new URLRequest(src);
			
			if (w > 0 || h > 0) 
			{
				this.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
			}
			if (src) {
				this.src = src;
				this.load(req);
			}
		}
		
		private function onImageLoaded(e:Event):void 
		{
			var sx:Number = w > 0 ? w / contentLoaderInfo.width : 1;
			var sy:Number = h > 0 ? h / contentLoaderInfo.height :1;
			var scale:Number = Math.min(Math.min(sx, sy), 1);
			this.scaleX = this.scaleY = scale;
			if (boxW) this.x = (boxW - this.width) / 2;
			if (boxH) this.y = (boxH - this.height) / 2;
		}
		
		
		
	}

}