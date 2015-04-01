/**FireworksCV.as
@author: Barsha Shrestha, Mariam, Nikita

This program reacts to motion and paints elliptical blobs whenever motion is detected

**/

package {
	
	/*next steps
	1. create instrucion screen that goes away on the first movement
	2. have a pop up every 30 seconds or so that gives you a color choice - if you swipe left, then one color shows up, and if you swipe right, another one shows up
	3. add sound
	*/
	import flash.geom.Vector3D;
	import flash.geom.ColorTransform;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import ihart.event.*;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	public class PaintingCV extends Sprite{
		
		//set up the socket with localhost, using port 5204
		private var hostName:String = "localhost";
		//private var hostName:String = "192.168.10.1"; //hallway
        private var port:uint = 5204;
		//set up a cvManager to handle our CVEvents
		private var cvManager : CVManager;
		
		private var sound: Sound;
		
		private var redpara: RedPara;
		//create a vector of paintblobs
		private var paintblobs : Vector.<Painting> = new Vector.<Painting>();
		
		
		private var WAIT_TIME: int = 150;
		private var userActive: Boolean;
		var newScreen: WhiteScreen;
		var timer : Timer;
		var cvTimer : Timer;
		public static var CV_DELAY : int = 500;
		var cvEventsAllowed: Boolean;
		var tick : int;
		var randomInt: int;
		
		
		/**
		* Constructor; just initializes the cvManager and adds an event listener to it.
		*/
		public function PaintingCV() : void {
			
			cvManager = new CVManager(hostName, port);
			cvManager.addEventListener(CVEvent.SHELL, getData);
			sound = new PaintSound;
			userActive = false;
			cvTimer = new Timer( CV_DELAY );
			cvTimer.addEventListener(TimerEvent.TIMER, allowCVEvents );
			cvEventsAllowed=true;
			tick=-1;
			randomInt = Math.random()*100;
			addEventListener( Event.ENTER_FRAME, tickFunction );
				
		}
		
		private function allowCVEvents( e : Event ) : void
		{
			cvEventsAllowed = true;
			
			cvTimer.stop();
			trace("Stop it!!");
		}
		
		public function tickFunction (e : Event) : void {	
			tick++;
			
			if ( tick > WAIT_TIME )
			{
		
				removeEventListener( Event.ENTER_FRAME, tickFunction );

				resetGame();
			}
		}
		/**
		* Gets data about a CVEvent and creates blobs based on that data.
		*/
		public function getData (e : CVEvent) : void {
			
			var numBlobs : int = e.getNumBlobs();
			var blobX : Number;
			var blobY : Number;
			fireworkX : Number;
			fireworkY : Number;
			var color : int;
			var shape : int;
			var rot :   Number;
			var currentblob : Painting;
			var currentStroke : testStroke;
			var colorTransform: ColorTransform;
		
			
			
			tick=0;
			trace("random int ", randomInt);
			//for every blob there is on the screen
			for (var i : int = 0; i <= numBlobs; i++) {
				
				currentblob = new Painting();
				currentStroke = new testStroke();
				//trace("NEW SERIES OF BLOOOOOOBSSS");
				//save the blob's x and y values
				blobX = e.getX(i);
				blobY = e.getY(i);
				//trace("X value is "+ blobX);
				//trace("Y value is "+ blobY);
					
				
				//color C in, C has 3 sections
				//if(blobX>=100 && blobX<=150 &&blobY>=200 &&blobY<=250)
				//{
				//	color = 2;
				//}
				//else if(blobX>=100 && blobX<=120 &&blobY>=250 &&blobY<=350)
				//{
				//	color=2;
				//}else if(blobX>=100 && blobX<150 &&blobY>350 &&blobY<=400)
				//{
				//	color=2;
				//}
				//
				//
				////color O, has 4 sections
				//else if(blobX>=250 && blobX<=350 &&blobY>=200 &&blobY<=250)
				//{
				//	color=3;
				//}
				//else if(blobX>=250 && blobX<350 &&blobY>=350 &&blobY<=400)
				//{
				//	color=3;
				//}
				//else if(blobX>=250 && blobX<=280 &&blobY>=250 &&blobY<=350)
				//{
				//	color=3;
				//}
				//else if(blobX>=320 && blobX<=350 &&blobY>=250 &&blobY<=350)
				//{
				//	color=3;
				//}
					//rothko painting blue, green and black
				
				
				/*if(	blobX>=500 && blobY>=250)
				{
					redpara= new RedPara();
					addChild(redpara);
				}*/
				
				
				if(randomInt<50)
			{
				//blue
				if(blobX>=50 && blobX<=750 &&blobY>=50 &&blobY<=285)
				{
					color=2;
				}
				
				//green
				else if(blobX>=50 && blobX<=750 &&blobY>=400 &&blobY<=450)
				{
					color=3;
				}
				
				//black
				else if(blobY>285 && blobY<400)
				{
					color=4;
				}
				
			}
			
				else
			{
				//blue
				if(blobX>=000 && blobX<200 &&blobY>=0 &&blobY<=500)
				{
					color=2;
				}
				//green
				else if(blobX>=200 && blobX<400 &&blobY>=0 &&blobY<=500)
				{
					color=3;
				}
				//yellow
				else if(blobX>=400 && blobX<600 && blobY>=0 &&blobY<=500 )
				{
					color=6;
				}
				//red
				else
				{
					color=5;
				}
			}
				
				//create a new blob with the chosen color by applying a color transform in every case 
				switch (color) {
					
					case 1:
						break;
						
					case 2:
						colorTransform = currentblob.transform.colorTransform;
						colorTransform.color = 0x3399FF;
						currentblob.transform.colorTransform = colorTransform;
						break;
						
					case 3:
						colorTransform = currentblob.transform.colorTransform;
						colorTransform.color = 0x33FF66;
						currentblob.transform.colorTransform = colorTransform;
						break;
						
					case 4:
						colorTransform = currentblob.transform.colorTransform;
						colorTransform.color = 0x000000;
						currentblob.transform.colorTransform = colorTransform;
						break;
					
					case 5:
						colorTransform = currentblob.transform.colorTransform;
						colorTransform.color = 0xFF3300;
						currentblob.transform.colorTransform = colorTransform;
						break;
					
					
					case 6:
						colorTransform = currentblob.transform.colorTransform;
						colorTransform.color = 0xFFFF00;
						currentblob.transform.colorTransform = colorTransform;
						break;
					
					default:
						break;
						
						
						
						
				}
				
				//add the new blob to the scene
				addChild(currentblob);
				addChild(currentStroke);
				//to permanently draw the blobs on the screen
				currentblob.graphics.beginFill(0x99FFFF);
				////currentFirework.graphics.drawCircle(0, 0, 20);
				currentblob.graphics.drawRoundRect(0, 0, 15, 5, 10, 10);
				//sound.play();
				currentblob.graphics.endFill();
				//timer.stop();
								
				
				
			
				
				
				
				
				
				//generate the new blob's x and y based on the blob's x and y
				currentblob.x =blobX;
				currentblob.y = blobY;
				
				
				
			}

		}
		
		
		 private function completeHandler(e:TimerEvent):void {
            trace("TIME'S UP HALLELUJAH!!!");  
			 newScreen = new WhiteScreen();
			addChild(newScreen);
			 timer.stop();
        }
		
		
		public function resetGame():void{
			tick=0;
			newScreen = new WhiteScreen();
			addChild(newScreen);
			randomInt = Math.random()*100;
			addEventListener( Event.ENTER_FRAME, tickFunction );
			randomInt = Math.random()*100;
		}
		
		/*public function tickFunction(e: CVEvent): void{
			
			if( tick> WAIT_TIME)
			{
				trace ("USER'S GONE YO!");
				resetGame();
			}
			
			
		}*/
		
		
	
		
	
		
		
			
		
	}
	
}
		
		