package 
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class ArmyE extends Sprite
	{
		public var beginColvoArcher = 1;
		public var beginColvoWar = 1;
		public var improvmentArch:int = 1;
		public var improvmentWar:int = 1;
		public var archer:Array = new Array();
		public var war:Array = new Array();
		public var side:int;
		public var valueTreat:Number = Main.da.plusTreatBegin_d;

		public var beginHealthArch = Main.da.archerHealth_d;
		public var critArch = Main.da.archerCrit_d;
		public var attackArch = Main.da.archerForce_d;

		public var beginHealthWar = Main.da.warHealth_d;
		public var critWar = Main.da.warCrit_d;
		public var attackWar = Main.da.warForce_d;

		public function ArmyE(side_p)
		{
			side = side_p;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);

			for (var w = 0; w<beginColvoWar; w++)
			{
				war[w] = new Warrior(0,side);
				addChild(war[w]);
				if (side == 0)
				{
					Main.game.army.setPosition(war[w],3,w+5);
				}
				else
				{
					Main.game.army.setPosition(war[w],12,w+5);
				}
			}
			for (var a = 0; a<beginColvoArcher; a++)
			{
				archer[a] = new Warrior(1,side);
				addChild(archer[a]);
				if (side == 0)
				{
					Main.game.army.setPosition(archer[a],4,a+5);
				}
				else
				{
					Main.game.army.setPosition(archer[a],11,a+5);
				}
			}
		}

		public function creatNewWarrior(kind_p)
		{
			var a = Main.game;
			var arr;
			if (kind_p == 0)
			{
				arr = war;
			}
			else
			{
				arr = archer;
			}
			arr.push(new Warrior(kind_p,side));
			addChild(arr[arr.length-1]);
			a.army.setPosition(arr[arr.length-1],a.castle[side].positionX,a.castle[side].positionY+1);
			arr[arr.length - 1].steps = 0;
			arr[arr.length - 1].fun1();
			
			Main.game.stat.addS(side,6 + kind_p,1);
		}
		public function cleanArmySide()
		{
			for (var w = 0; w<war.length; w++)
			{
				war[w].cleanWarrior();
				removeChild(war[w]);
			}
			war.splice(0,war.length);
			for (var a = 0; a<archer.length; a++)
			{
				archer[a].cleanWarrior();
				removeChild(archer[a]);
			}
			archer.splice(0,archer.length);
		}
	}
}