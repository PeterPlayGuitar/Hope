package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class Tablo extends Sprite
	{

		public var tablo = new tablo_mc  ;
		private var buttonNo = new buttonNo_mc  ;
		private var buttonYes = new buttonYes_mc  ;
		private var type:String;

		public function Tablo(type_p)
		{
			type = type_p;
			tablo.x = 400 - tablo.width / 2;
			buttonNo.x = tablo.x + 175;
			buttonNo.y = 105;
			buttonYes.x = tablo.x + 70;
			buttonYes.y = 105;
			addChild(tablo);
			addChild(buttonNo);
			addChild(buttonYes);
			buttonNo.addEventListener(MouseEvent.CLICK,no);
			buttonYes.addEventListener(MouseEvent.CLICK,yes);
			setText(type);
		}
		public function cleanTablo()
		{
			buttonNo.removeEventListener(MouseEvent.CLICK,no);
			buttonYes.removeEventListener(MouseEvent.CLICK,yes);
			removeChild(tablo);
			removeChild(buttonNo);
			removeChild(buttonYes);
			tablo = null;
			buttonNo = null;
			buttonYes = null;
		}
		private function no(e:MouseEvent)
		{
			if (! Main.game.duringMoveTablo)
			{
				if (type == "outTheGame")
				{
				}
				if (type == "deleteWarrior")
				{
				}
				Main.game.beginDown();
			}
		}
		private function yes(e:MouseEvent)
		{
			if (! Main.game.duringMoveTablo)
			{
				if (type == "outTheGame")
				{
					Main.game.mayIdellGame = true;
				}
				if (type == "deleteWarrior")
				{
					Main.game.army.deleteWarriorSpecial()
				}
				Main.game.beginDown();
			}
		}
		private function setText(type)
		{
			var a:String;
			if (type == "outTheGame")
			{
				a = "Are you sure you want to quit?";
			}
			if (type == "deleteWarrior")
			{
				a = "Are you sure you want to disband the warrior?";
			}
			tablo.question.text = a;
		}
	}
}