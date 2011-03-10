package 
{
	import flash.display.*; 
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.FileReference;
	import flash.geom.Matrix;

	/**
	 * ...
	 * @author chuanhong
	 */
	public class Main extends Sprite 
	{
		public var MAIN_IMAGE_WIDTH:Number 		= 800;
		public var MAIN_IMAGE_HEIGHT:Number 	= 600;

		private var images:Array 				= new Array();

		private var div_imageContainer:Sprite 	= new Sprite();
		private var bitmap_container:Sprite = new Sprite();
		private var img_mainImage:Image 		= new Image("http://img.alibaba.com/images/cms/upload/banners/201103/550x210_rfq_110225.jpg", MAIN_IMAGE_WIDTH, MAIN_IMAGE_HEIGHT);
		private var singleFile:FileReference;
		private var loader:Loader;
		private var fr:FileReference;
		public function Main():void 
		{
			this.init();
		}
		private function initUI():void
		{
			this.stage.scaleMode = "noScale";
			this.stage.align 	= "TL";
			
			this.img_mainImage.boxW = this.stage.stageWidth;
			this.img_mainImage.boxH = this.stage.stageHeight;
			this.div_imageContainer.addChild(img_mainImage);
			this.addChild(div_imageContainer);		

		}	
		private function init(e:Event = null):void 
		{
			//this.initUI();
			trace("this");
			this.bindUI();
			var square_commands:Vector.<int> = new Vector.<int>(5,true); 
			square_commands[0] = 1;//moveTo 
			square_commands[1] = 2;//lineTo 
			square_commands[2] = 2; 
			square_commands[3] = 2; 
			square_commands[4] = 2; 

			var square_coord:Vector.<Number> = new Vector.<Number>(10,true); 
			square_coord[0] = 20; //x 
			square_coord[1] = 10; //y 
			square_coord[2] = 50; 
			square_coord[3] = 10; 
			square_coord[4] = 50; 
			square_coord[5] = 40; 
			square_coord[6] = 20; 
			square_coord[7] = 40; 
			square_coord[8] = 20; 
			square_coord[9] = 10; 

			graphics.beginFill(0x442266);//set the color 
			graphics.drawPath(square_commands, square_coord);
		}
		private function bindUI(e:Event = null):void 
		{
			addEventListener(MouseEvent.CLICK, clickHandler);
		}
		private function clickHandler(e:Event = null):void 
		{
			singleFile = new FileReference();
			singleFile.browse();
			singleFile.addEventListener(Event.SELECT, singleFileSelected);
		}
		private function singleFileSelected(event:Event):void
		{
			fr = event.target as FileReference;
			
			//this.clearFileList();
			//addFile(event.target as FileReference);
			//processSelection();
			fr.addEventListener(Event.COMPLETE, fileLoadComplete);
			fr.load();
			trace('load1');
		}
		private function fileLoadComplete(event:Event):void
		{
			trace('load2');
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, fileDataLoad );
			loader.loadBytes(event.target.data);

		}
		private function fileDataLoad(e:Event):void 
		{
			var loaderData:Loader = Loader(e.target.loader);
			var image:Bitmap = Bitmap(loaderData.content);
			
			var myMatrix:Matrix = new Matrix(1,0,0,1,0,0);
			
			//获取当前加载对象的高和宽
			var w:int = image.bitmapData.width;
			var h:int = image.bitmapData.height;
			
			//计算压缩到设定高宽的比例
			var rate:Number = Math.min(1, Math.min( 600 / w, 600 / h ));
			var nW:int = int(w * rate);
			var nH:int = int(h * rate);
			myMatrix.scale(rate,rate);
			var myBitmapData:BitmapData = new BitmapData(nW, nH);
			myBitmapData.draw(image.bitmapData,myMatrix,null,null,null,true);
			var newImage:Bitmap = new Bitmap(myBitmapData);
			
			this.div_imageContainer.addChild(newImage);
			trace('load3');
			
		}
		
	}
	
}