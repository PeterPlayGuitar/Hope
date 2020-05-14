package 
{
	import flash.display.Sprite;

	public class Smoke extends Sprite
	{

		private var smoke = new smoke_mc  ;
		public var directionX;
		public var directionY;

		public function Smoke()
		{
			smoke.rotation = Math.random() * 360;
			addChild(smoke);
		}
		public function updateDirect(val)
		{
			directionX *=  val;
			directionY *=  val;
			directionY -= 0.01
			smoke.scaleX += 0.01;
			smoke.scaleY = smoke.scaleX;
		}
		public function cleanBit()
		{
			removeChild(smoke);
			smoke = null
		}

	}

}