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
	
	public class PaintingCV extends Sprite{
		
		//set up the socket with localhost, using port 5204
		private var hostName:String = "localhost";
		//private var hostName:String = "192.168.10.1"; //hallway
        private var port:uint = 5204;
		//set up a cvManager to handle our CVEvents
		private var cvManager : CVManager;
		
		private var sound: Sound;
		
	
		//create a vector of paintblobs
		private var paintblobs : Vector.<Painting> = new Vector.<Painting>();
		
		/**
		* Constructor; just initializes the cvManager and adds an event listener to it.
		*/
		public function PaintingCV() : void {
			
			cvManager = new CVManager(hostName, port);
			cvManager.addEventListener(CVEvent.SHELL, getData);
			sound = new PaintSound;
		}
		
		/**
		* Gets data about a CVEvent and creates blobs based on that data.
		*/
		public function getData (e : CVEvent) : void {
			trace( "getting data " );
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
			
			//for every blob there is on the screen
			for (var i : int = 0; i <= numBlobs; i++) {
				
				currentblob = new Painting();
				currentStroke = new testStroke();
				
				//save the blob's x and y values
				blobX = e.getX(i);
				blobY = e.getY(i);
				
				//generate a random color for the blob
				color = Math.ceil(Math.random() * 6);
				
				//create a new blob with the chosen color by applying a color transform in every case 
				switch (color) {
					
					case 1:
						break;
						
					case 2:
						colorTransform = currentblob.transform.colorTransform;
						colorTransform.color = 0x66FF33;
						currentblob.transform.colorTransform = colorTransform;
						break;
						
					case 3:
						colorTransform = currentblob.transform.colorTransform;
						colorTransform.color = 0x14B1FF;
						currentblob.transform.colorTransform = colorTransform;
						break;
						
					case 4:
						colorTransform = currentblob.transform.colorTransform;
						colorTransform.color = 0x002EB8;
						currentblob.transform.colorTransform = colorTransform;
						break;
					
					case 5:
						colorTransform = currentblob.transform.colorTransform;
						colorTransform.color = 0xCC3366;
						currentblob.transform.colorTransform = colorTransform;
						break;
						
					
					case 6:
						colorTransform = currentblob.transform.colorTransform;
						colorTransform.color = 0xFF3366;
						currentblob.transform.colorTransform = colorTransform;
						break;
					
					default:
						break;
						
						
						
						
				}
				
				//add the new blob to the scene
				addChild(currentblob);
				addChild(currentStroke);
				//to permanently draw the blobs on the screen
				currentblob.graphics.beginFill(0xFFFFFF);
				//currentFirework.graphics.drawCircle(0, 0, 20);
				currentblob.graphics.drawRoundRect(0, 0, 10, 5, 10, 10);
				sound.play();
				currentblob.graphics.endFill();
								
				
				
			
				
				
				
				
				
				//generate the new blob's x and y based on the blob's x and y
				currentblob.x =blobX;
				currentblob.y = blobY;
				
				
				
			}

		}
		
	
		
		
			
		
	}
	
}
		
		