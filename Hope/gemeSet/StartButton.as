package gemeSet
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class StartButton extends Sprite
	{

		private var startButton = new startButton_mc  ;
		private var overButtin:Boolean = false;
		private var upLimitScale = 1.1;
		private var mayAnimat:Boolean = true;

		public function StartButton()
		{
			startButton.x = 400;
			startButton.y = 300;
			addChild(startButton);
			startButton.addEventListener(MouseEvent.CLICK,M_CLICK);
			startButton.addEventListener(MouseEvent.MOUSE_OVER,M_OVER);
			startButton.addEventListener(MouseEvent.MOUSE_OUT,M_OUT);
		}
		public function M_CLICK(e:MouseEvent)
		{
			Main.removeClass(3);
			Main.addClass(0);
		}
		public function M_OVER(e:MouseEvent)
		{
			overButtin = true;
			mayAnimat = true;
		}
		public function M_OUT(e:MouseEvent)
		{
			overButtin = false;
			mayAnimat = true;
		}
		public function ef()//анимация изменения размера кнопки
		{
			if (mayAnimat)
			{
				if (overButtin)
				{
					if (startButton.scaleX >= upLimitScale)
					{
						startButton.scaleX = upLimitScale;
						startButton.scaleY = upLimitScale;
						mayAnimat = false;
					}
					else
					{
						startButton.scaleX +=  0.01;
						startButton.scaleY = startButton.scaleX;
					}
				}
				else
				{
					if (startButton.scaleX <= 1)
					{
						startButton.scaleX = 1;
						startButton.scaleY = 1;
						mayAnimat = false;
					}
					else
					{
						startButton.scaleX -=  0.01;
						startButton.scaleY = startButton.scaleX;
					}
				}
			}
		}
		public function cleanStartButton()
		{
			startButton.removeEventListener(MouseEvent.CLICK,M_CLICK);
			startButton.removeEventListener(MouseEvent.MOUSE_OVER,M_OVER);
			startButton.removeEventListener(MouseEvent.MOUSE_OUT,M_OUT);

			startButton = null;
		}

	}

}