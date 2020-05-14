package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;

	public class Bang extends Sprite
	{
		private var arr:Array = new Array();
		private var timer:Number;
		private var ct:ColorTransform = new ColorTransform();
		private var duringBang:Boolean = false;

		public function makeCertainBang(X:Number,Y:Number,power:Number,colvoBits:int,color,kindB:int)
		{
			if (! duringBang)
			{
				arr.length = colvoBits;
				timer = power * 10;
				ct.color = color;
				for (var i = 0; i<arr.length; i++)
				{
					arr[i] = new Bit(0,0,kindB);
					arr[i].x = X;
					arr[i].y = Y;
					if (kindB != 1)
					{
						arr[i].transform.colorTransform = ct;
					}
					var angle = Math.random() * Math.PI * 2;
					arr[i].directionX = power * Math.cos(angle)*(Math.random()*0.5+0.5);
					arr[i].directionY = power * Math.sin(angle)*(Math.random()*0.5+0.5);
					Main.plan1.addChild(arr[i]);
				}
				addEventListener(Event.ENTER_FRAME,ef);
				duringBang = true;
			}
		}
		public function makeSmokeBang(X:Number,Y:Number,power:Number,colvoBits:int)
		{
			if (! duringBang)
			{
				if (power > 5)
				{
					power = 5;
				}
				timer = power * 10;
				arr.length = colvoBits;
				for (var i = 0; i<arr.length; i++)
				{
					arr[i] = new Smoke();
					arr[i].x = X;
					arr[i].y = Y;
					var angle;
					if (Math.random() < 0.5)
					{
						angle = Math.random() * Math.PI / 2 - Math.PI / 4;
					}
					else
					{
						angle = Math.random() * Math.PI / 2 + 3 * Math.PI / 4;
					}
					arr[i].directionX = power * Math.cos(angle)*(Math.random()*0.5+0.5);
					arr[i].directionY = power * Math.sin(angle)*(Math.random()*0.5+0.5);
					Main.plan1.addChild(arr[i]);
				}
				addEventListener(Event.ENTER_FRAME,ef);
				duringBang = true;
			}
		}
		private function ef(e:Event)
		{
			timer--;
			for (var i = 0; i<arr.length; i++)
			{
				if (timer <= 0 )
				{
					arr[i].alpha -=  0.05;
				}
				arr[i].updateDirect(0.92);
				arr[i].x +=  arr[i].directionX;
				arr[i].y +=  arr[i].directionY;
			}
			if (arr[0].alpha <= 0)
			{
				for (var m = 0; m<arr.length; m++)
				{
					arr[m].alpha = 0;
					arr[m].cleanBit();
					Main.plan1.removeChild(arr[m]);
					arr[m] = null;
				}
				arr.length = 0;
				timer = 0;
				duringBang = false;
				removeEventListener(Event.ENTER_FRAME,ef);
			}
		}
	}
}