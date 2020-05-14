package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import building.Build;

	public class Castle extends Sprite
	{
		//окно состояния начало
		public var dailyProfit = Main.da.beginDailyProfit_d;
		public var money = Main.da.beginMoney_d - dailyProfit;
		public var dimonds = Main.da.beginDimonds_d;
		public var population = Main.da.beginPopulation_d;
		public var health = Main.da.beginHealth_d;
		//окно состояния конец

		public var castle = new castle_mc  ;
		public var positionX = 0;
		public var positionY = 0;
		public var side;

		public var scoreboard = new scoreboard_mc  ;
		private var infOfCastle = new infOfCastle_mc  ;

		private var onStage:Boolean = false;
		private var onStageScoreboard:Boolean = false;
		private var includedBuild:Boolean = false;

		public var build:*;

		public function Castle(side_p)
		{
			side = side_p;
			castle.gotoAndStop(side_p+1);
			addChild(castle);
			build = new Build(side);
			infOfCastle.x = 400 + infOfCastle.width / 2;
			infOfCastle.y = 600;
			castle.addEventListener(MouseEvent.MOUSE_OVER, guidance);
			castle.addEventListener(MouseEvent.MOUSE_OUT, outen);
			castle.addEventListener(MouseEvent.CLICK, mouseClick);
		}
		public function minusMoney(changeMoney,changeDiamonds)
		{
			money +=  changeMoney;
			dimonds +=  changeDiamonds;
			build.updateInf();
		}
		public function includeCastle()
		{
			includedBuild = true;
			build.addEvent();
			Main.plan1.addChild(build);
		}
		public function exitFromBuild()
		{
			includedBuild = false;
			Main.plan1.removeChild(build);
			Main.game.army.silense = true;
		}
		private function mouseClick(e:MouseEvent)
		{
			if (! onStage && side == Main.game.turn)
			{
				addInfCastle();
			}
			else
			{
				dellInfCastle();
			}
		}
		public function dellInfCastle()
		{
			if (onStage)
			{
				Main.plan1.removeChild(infOfCastle);
				onStage = false;
			}
		}
		public function addInfCastle()
		{
			if (! onStage)
			{
				updateInf();
				Main.plan1.addChild(infOfCastle);
				onStage = true;
			}
		}
		private function updateInf()
		{
			var a = Main.game.army.armySide[side];

			infOfCastle.money.text = money;
			infOfCastle.dimond.text = dimonds;
			infOfCastle.health.text = health;
			infOfCastle.moneyPlus.text = stringAboutMoneyPlus;
			infOfCastle.population.text = a.archer.length + a.war.length + "/" + population;
			infOfCastle.archer.text = a.archer.length;
			infOfCastle.war.text = a.war.length;
		}
		public function get stringAboutMoneyPlus()
		{
			var a = Main.game.army.armySide[side];
			if (a.archer.length + a.war.length > population)
			{
				return '+' + dailyProfit + '('+ (-(a.archer.length + a.war.length - population)*Main.da.expensesForOneExtraWarrior_d)+')';
			}
			else
			{
				return '+' + dailyProfit;
			}
		}
		private function guidance(e:MouseEvent)
		{
			if (Main.place.mouseX < 800 - scoreboard.width)
			{
				scoreboard.x = Main.place.mouseX;
				scoreboard.y = Main.place.mouseY;
			}
			else
			{
				scoreboard.x = Main.place.mouseX - scoreboard.width - 1;
				scoreboard.y = Main.place.mouseY;
			}
			Main.plan1.addChild(scoreboard);
			onStageScoreboard = true;
			scoreboard.money.text = money;
		}
		private function outen(e:MouseEvent)
		{
			Main.plan1.removeChild(scoreboard);
			onStageScoreboard = false;
		}
		public function nextToOtherTurn()
		{
			var a = Main.game.army.armySide[side];
			money +=  dailyProfit;
			if (a.archer.length + a.war.length > population)
			{
				money -= (a.archer.length + a.war.length - population)*Main.da.expensesForOneExtraWarrior_d;
			}
			build.opportunityToBuild = true;
			build.win2.buildedInThisDayBar = false;

			if (money < 0 )
			{
				trace("Сделай при отсутствии денег чтобы что-то менялось")
				money = 0;
			}
			else
			{
			}
		}
		public function cleanCastle()
		{
			castle.removeEventListener(MouseEvent.MOUSE_OVER, guidance);
			castle.removeEventListener(MouseEvent.MOUSE_OUT, outen);
			castle.removeEventListener(MouseEvent.CLICK, mouseClick);
			build.cleanBuild();
			if (includedBuild)
			{
				Main.plan1.removeChild(build);
			}
			build = null;
			removeChild(castle);
			castle = null;
			dellInfCastle();
			infOfCastle = null;
			if (onStageScoreboard)
			{
				Main.plan1.removeChild(scoreboard);
			}
			scoreboard = null;
		}
	}
}