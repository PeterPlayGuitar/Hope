package down_string
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class NextClass extends Sprite
	{
		public var nextB:Sprite = new nextRed_mc  ;

		public function NextClass()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			nextB.y = 575;
			if (Main.game.turn == 0)
			{
				nextB.x = 60;
			}
			else
			{
				nextB.x == 740;
			}

			addChild(nextB);
			nextB.addEventListener(MouseEvent.CLICK,MC);
			nextB.addEventListener(MouseEvent.MOUSE_OVER,m_over);
			nextB.addEventListener(MouseEvent.MOUSE_OUT,m_out);
		}
		private function m_over(e:MouseEvent)
		{
			nextB.scaleX = 1.1;
			nextB.scaleY = 1.1;
		}
		private function m_out(e:MouseEvent)
		{
			nextB.scaleX = 1;
			nextB.scaleY = 1;
		}
		public function changeTurnNC(nextTurn)
		{
			if (nextTurn == 0)
			{
				nextB.x = 60;
			}
			else
			{
				nextB.x = 740;
			}

		}
		private function MC(e:MouseEvent)
		{
			Main.game.pressNext();
		}
		public function cleanNextClass()
		{
			nextB.removeEventListener(MouseEvent.MOUSE_OVER,m_over);
			nextB.removeEventListener(MouseEvent.MOUSE_OUT,m_out);
			nextB.removeEventListener(MouseEvent.CLICK,MC);
			removeChild(nextB);
			nextB = null;
		}

	}

}
//if turn is 0, red do step, else - blue