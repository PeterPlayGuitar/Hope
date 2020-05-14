package down_string
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class DownString extends Sprite
	{

		public var nextClass:*;
		public var attackButton:*;
		private var choiseCastButton:*;
		private var treatButton:*
		private var deleteWarriorButton:*

		public function DownString()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			nextClass = new NextClass();
			attackButton = new AttackButton();
			choiseCastButton = new ChoiseCastButton();
			treatButton = new TreatButton()
			deleteWarriorButton = new DeleteWarriorButton()
			addChild(choiseCastButton);
			addChild(nextClass);
			addChild(attackButton);
			addChild(treatButton)
			addChild(deleteWarriorButton)
		}
		public function changeTurn(nextTurn)
		{
			nextClass.changeTurnNC(nextTurn);
			attackButton.changeTurnAB(nextTurn);
			choiseCastButton.changeTurnCCB(nextTurn)
			treatButton.changeTurnTB(nextTurn)
			deleteWarriorButton.changeTurnDWB(nextTurn)
		}
		public function cleanDownString()
		{
			choiseCastButton.cleanChoiseCastButton();
			removeChild(choiseCastButton);
			choiseCastButton = null;

			nextClass.cleanNextClass();
			removeChild(nextClass);
			nextClass = null;

			attackButton.cleanAttackButton();
			removeChild(attackButton);
			attackButton = null;
			
			treatButton.cleanTreatButton()
			removeChild(treatButton)
			treatButton = null
			
			deleteWarriorButton.cleanDeleteWarriorButton()
			removeChild(deleteWarriorButton)
			deleteWarriorButton = null
		}
	}
}