package down_string
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class AttackButton extends Sprite
	{

		public var attackButton = new attackButton_mc  ;

		public function AttackButton()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			attackButton.y = 575;
			if (Main.game.turn == 0)
			{
				attackButton.x = 110;
			}
			else
			{
				attackButton.x = 690;
			}
			addChild(attackButton);
			attackButton.gotoAndStop(1);
			attackButton.addEventListener(MouseEvent.CLICK,MC);
			attackButton.addEventListener(MouseEvent.MOUSE_OVER,m_over);
			attackButton.addEventListener(MouseEvent.MOUSE_OUT,m_out);
		}
		private function m_over(e:MouseEvent)
		{
			attackButton.scaleX = 1.1;
			attackButton.scaleY = 1.1;
		}
		private function m_out(e:MouseEvent)
		{
			attackButton.scaleX = 1;
			attackButton.scaleY = 1;
		}
		private function MC(e:MouseEvent)
		{
			Main.game.army.clickAttack();
		}
		public function changeTurnAB(nextTurn)
		{
			if (nextTurn == 0)
			{
				attackButton.x = 110;
			}
			else
			{
				attackButton.x = 690;
			}
		}
		public function cleanAttackButton()
		{
			attackButton.removeEventListener(MouseEvent.CLICK,MC);
			attackButton.removeEventListener(MouseEvent.MOUSE_OVER,m_over);
			attackButton.removeEventListener(MouseEvent.MOUSE_OUT,m_out);
			removeChild(attackButton);
			attackButton = null
			;
		}

	}

}