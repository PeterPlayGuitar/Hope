package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class Help extends Sprite
	{
		private var returnButton = new returnButton_mc  ;
		private var upLimitScale = 1.05;

		public function Help()
		{
			returnButton.x = 54.8;
			returnButton.y = 600 - 54.8;
			addChild(returnButton);
			returnButton.addEventListener(MouseEvent.CLICK,M_CLICK);
			returnButton.addEventListener(MouseEvent.MOUSE_OVER,M_OVER);
			returnButton.addEventListener(MouseEvent.MOUSE_OUT,M_OUT);
		}
		private function M_CLICK(e:MouseEvent)
		{
			Main.removeClass(4);
			Main.addClass(2);
		}
		private function M_OVER(e:MouseEvent)
		{
			returnButton.scaleX = upLimitScale;
			returnButton.scaleY = returnButton.scaleX;
		}
		private function M_OUT(e:MouseEvent)
		{
			returnButton.scaleX = 1;
			returnButton.scaleY = 1;
		}
		public function cleanHelp()
		{
			returnButton.removeEventListener(MouseEvent.CLICK,M_CLICK);
			returnButton.removeEventListener(MouseEvent.MOUSE_OVER,M_OVER);
			returnButton.removeEventListener(MouseEvent.MOUSE_OUT,M_OUT);

			removeChild(returnButton);
			returnButton = null;
		}

	}

}