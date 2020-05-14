package animation
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class AnimationCloud extends Sprite
	{
		private var beginSize = 50;
		private var arr:Array = new Array(beginSize);
		private var beginTime:int = Main.da.basicTime_d * 8;
		private var time:int = beginTime;
		public var duringAnimation:Boolean = false;

		public function playAnimationCloud()
		{
			if (! duringAnimation)
			{
				arr.length = beginSize;
				for (var i = 0; i<beginSize; i++)
				{
					arr[i] = new Cloud();
					Main.plan1.addChild(arr[i]);

					var X = Math.random() * 800;
					arr[i].x = X + 450;
					arr[i].y = X - 450;
				}
				duringAnimation = true;
				addEventListener(Event.ENTER_FRAME,ef);
			}
		}
		private function ef(e:Event)
		{
			time--;

			for (var m = 0; m<arr.length; m++)
			{
				var a = arr[m].v * 900 / beginTime;
				arr[m].x -=  a;
				arr[m].y +=  a;
				if (arr[m].x < -50 || arr[m].y > 650)
				{
					arr[m].cleanCloud();
					Main.plan1.removeChild(arr[m]);
					arr[m] = null;
					arr.splice(m,1);
				}
			}

			if (time <= 0)
			{
				removeEventListener(Event.ENTER_FRAME,ef);
				duringAnimation = false;
				for (var i = 0; i<arr.length; i++)
				{
					arr[i].cleanCloud();
					Main.plan1.removeChild(arr[i]);
					arr[i] = null;
				}
				arr.length = 0;
				time = beginTime;
			}
		}
	}
}