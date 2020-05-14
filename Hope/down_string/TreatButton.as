package down_string
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class TreatButton extends Sprite
	{
		private var treatButton = new treatButton_mc  ;

		public function TreatButton()
		{
			treatButton.y = 575;
			if (Main.game.turn == 0)
			{
				treatButton.x = 210;
			}
			else
			{
				treatButton.x == 590;
			}

			addChild(treatButton);
			treatButton.addEventListener(MouseEvent.CLICK,MC);
			treatButton.addEventListener(MouseEvent.MOUSE_OVER,m_over);
			treatButton.addEventListener(MouseEvent.MOUSE_OUT,m_out);
		}
		private function m_over(e:MouseEvent)
		{
			treatButton.scaleX = 1.1;
			treatButton.scaleY = 1.1;
		}
		private function m_out(e:MouseEvent)
		{
			treatButton.scaleX = 1;
			treatButton.scaleY = 1;
		}
		public function changeTurnTB(nextTurn)
		{
			if (nextTurn == 0)
			{
				treatButton.x = 210;
			}
			else
			{
				treatButton.x = 590;
			}
		}
		private function MC(e:MouseEvent)
		{
			Main.game.treatObject();
		}
		public function cleanTreatButton()
		{
			treatButton.removeEventListener(MouseEvent.MOUSE_OVER,m_over);
			treatButton.removeEventListener(MouseEvent.MOUSE_OUT,m_out);
			treatButton.removeEventListener(MouseEvent.CLICK,MC);
			removeChild(treatButton);
			treatButton = null;
		}

	}

}