package gemeSet
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class GameSettings extends Sprite
	{
		private var startButton:*;
		private var returnButton:*
		private var choiseStyle:*

		public function GameSettings()
		{
			startButton = new StartButton();
			addChild(startButton);
			
			returnButton = new ReturnButton()
			addChild(returnButton)
			
			choiseStyle = new ChoiseStyle()
			addChild(choiseStyle)

			addEventListener(Event.ENTER_FRAME,ef);
		}
		private function ef(e:Event)
		{
			startButton.ef();
		}
		public function cleanGameSettings()
		{
			removeEventListener(Event.ENTER_FRAME,ef);
			
			returnButton.cleanReturnButton()
			removeChild(returnButton)
			returnButton = null
			
			startButton.cleanStartButton();
			removeChild(startButton);
			startButton = null;
			
			choiseStyle.cleanChoiseStyle()
			removeChild(choiseStyle)
			choiseStyle = null
		}

	}

}