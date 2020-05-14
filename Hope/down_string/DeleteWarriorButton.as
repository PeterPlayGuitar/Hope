package down_string
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class DeleteWarriorButton extends Sprite
	{

		private var deleteWarriorButton = new deleteWarriorButton_mc  ;

		public function DeleteWarriorButton()
		{
			deleteWarriorButton.y = 575;
			if (Main.game.turn == 0)
			{
				deleteWarriorButton.x = 260;
			}
			else
			{
				deleteWarriorButton.x == 540;
			}
			addChild(deleteWarriorButton);
			deleteWarriorButton.addEventListener(MouseEvent.CLICK,MC);
			deleteWarriorButton.addEventListener(MouseEvent.MOUSE_OVER,m_over);
			deleteWarriorButton.addEventListener(MouseEvent.MOUSE_OUT,m_out);
		}
		private function m_over(e:MouseEvent)
		{
			deleteWarriorButton.scaleX = 1.1;
			deleteWarriorButton.scaleY = 1.1;
		}
		private function m_out(e:MouseEvent)
		{
			deleteWarriorButton.scaleX = 1;
			deleteWarriorButton.scaleY = 1;
		}
		private function MC(e:MouseEvent)
		{
			Main.game.army.fromButtonToDellWarrior();
		}
		public function changeTurnDWB(nextTurn)
		{
			if (nextTurn == 0)
			{
				deleteWarriorButton.x = 260;
			}
			else
			{
				deleteWarriorButton.x = 540;
			}
		}
		public function cleanDeleteWarriorButton()
		{
			deleteWarriorButton.removeEventListener(MouseEvent.MOUSE_OVER,m_over);
			deleteWarriorButton.removeEventListener(MouseEvent.MOUSE_OUT,m_out);
			deleteWarriorButton.removeEventListener(MouseEvent.CLICK,MC);
			removeChild(deleteWarriorButton);
			deleteWarriorButton = null;
		}

	}

}