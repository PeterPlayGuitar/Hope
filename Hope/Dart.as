package 
{
	import flash.display.Sprite;

	public class Dart extends Sprite
	{
		private var dart = new dart_mc  ;

		public function Dart(turn)
		{
			if (turn == 0)
			{
				dart.gotoAndStop(1);
			}
			else
			{
				dart.gotoAndStop(2);
			}
			addChild(dart);
		}
		public function setRotate(X)
		{
			dart.rotation = (X + 130) * 0.8;
		}

	}

}