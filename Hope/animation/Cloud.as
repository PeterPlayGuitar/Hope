package animation
{
	import flash.display.Sprite;

	public class Cloud extends Sprite
	{
		private var cloud = new cloud_mc  ;
		public var v = Math.random()*2+1

		public function Cloud()
		{
			addChild(cloud);
			cloud.gotoAndStop(int(Math.random()*3+1));
		}
		public function cleanCloud()
		{
			removeChild(cloud);
			cloud = null;
		}

	}

}