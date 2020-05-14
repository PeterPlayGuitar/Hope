package down_string
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ChoiseCastButton extends Sprite
	{
		private var choiseCastButton = new choiseCastButton_mc  ;

		public function ChoiseCastButton()
		{
			choiseCastButton.y = 575;
			if (Main.game.turn == 0)
			{
				choiseCastButton.x = 160;
			}
			else
			{
				choiseCastButton.x = 640;
			}
			addChild(choiseCastButton);
			choiseCastButton.addEventListener(MouseEvent.CLICK,mc);
			choiseCastButton.addEventListener(MouseEvent.MOUSE_OVER,m_over);
			choiseCastButton.addEventListener(MouseEvent.MOUSE_OUT,m_out);
		}
		private function m_over(e:MouseEvent)
		{
			choiseCastButton.scaleX = 1.1;
			choiseCastButton.scaleY = 1.1;
		}
		private function m_out(e:MouseEvent)
		{
			choiseCastButton.scaleX = 1;
			choiseCastButton.scaleY = 1;
		}
		private function mc(e:MouseEvent)
		{
			if (Main.game.army.silense)
			{
				Main.game.army.silense = false;
				Main.game.castle[Main.game.turn].includeCastle();
				choiseCastButton.scaleX = 1;
				choiseCastButton.scaleY = 1;
			}
		}
		public function changeTurnCCB(nextTurn)
		{
			if (nextTurn == 0)
			{
				choiseCastButton.x = 160;
			}
			else
			{
				choiseCastButton.x = 640;
			}
		}
		public function cleanChoiseCastButton()
		{
			choiseCastButton.removeEventListener(MouseEvent.CLICK,mc);
			choiseCastButton.removeEventListener(MouseEvent.MOUSE_OVER,m_over);
			choiseCastButton.removeEventListener(MouseEvent.MOUSE_OUT,m_out);
			removeChild(choiseCastButton);
			choiseCastButton = null;
		}

	}

}