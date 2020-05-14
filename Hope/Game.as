package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import valey.*;
	import down_string.*;
	import flash.events.KeyboardEvent;
	import animation.AnimationCloud;
	import statist.Statistics;

	public class Game extends Sprite
	{
		public var grid:Array = new Array();
		public var castle:Array = new Array(2);
		public var army:*;
		private var bits:*;
		public var bang:*;
		public var figure:*;
		public var stat:*;
		private var animationCloud:*;
		public var turn = 1;
		public var basicTime = Main.da.basicTime_d;

		public var style:int = Main.da.style_d;
		public var downString:DownString = new DownString();
		private var background_downString = new background_downString_mc  ;
		private var tablo:*;
		public var mayIdellGame:Boolean = false;
		public var duringMoveTablo:Boolean = false;

		private var curtain = new curtain_mc  ;

		private var relative:Array = [0.12,0.12,0.08,0.24,0.02];//оригiнал
		//private var relative:Array = [0,0,0,0,0];//пустота
		//private var relative:Array = [0.02,0.06,0.15,0.54,0.02];//леса
		//0 - top;1 - hill;2 - sea;3 - wood;4 - cast

		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);

			bang = new Bang();
			animationCloud = new AnimationCloud();
			figure = new Figure();

			preobrazovat();

			for (var i = 0; i<16; i++)
			{
				grid[i] = new Array();
				for (var m = 0; m<11; m++)
				{
					var arr = Main.saveGrid[i][m];
					if (arr[1] != 0)
					{
						setSaveGrid(i,m);
					}
					else
					{
						addValley(i,m);
					}
					Main.plan4.addChild(grid[i][m]);
				}
			}

			army = new Army();
			Main.plan2.addChild(army);
			castle[0] = new Castle(0);
			castle[1] = new Castle(1);
			Main.plan3.addChild(castle[0]);
			Main.plan3.addChild(castle[1]);
			for (var g = 0; g<2; g++)
			{
				if (Main.placeOfCastle[g][0] == null)
				{
					army.setPosition(castle[g],g*9+3,4+2*g);
				}
				else
				{
					army.setPosition(castle[g],Main.placeOfCastle[g][0],Main.placeOfCastle[g][1]);
				}
				var X = castle[g].positionX;
				var Y = castle[g].positionY;
				for (var f = 0; f<2; f++)
				{
					grid[X][Y + f].setGrafLawn();
				}
			}

			Main.plan1.addChild(downString);
			background_downString.x = 800;
			background_downString.y = 600;
			Main.plan2.addChild(background_downString);
			Main.place.addEventListener(MouseEvent.CLICK,mouseClick);
			Main.place.addEventListener(KeyboardEvent.KEY_DOWN, kd);

			stat = new Statistics();

			pressNext();

		}
		private function kd(e:KeyboardEvent)
		{
			if (e.keyCode == 81 && army.silense && ! army.allowedAttack)
			{
				setTablo("outTheGame");
			}
			if (e.keyCode == 69)
			{
				trace(stat.dayGame);
				trace(stat.stat[0]);
				trace(stat.stat[1]);
			}
		}
		public function setTablo(a:String)
		{
			tablo = new Tablo(a);
			Main.plan1.addChild(tablo);
			tablo.y = 600;
			army.silense = false;
			duringMoveTablo = true;
			addEventListener(Event.ENTER_FRAME,upstairsTablo);
		}
		private function upstairsTablo(e:Event)
		{
			tablo.y -=  (300 - tablo.tablo.height / 2) / basicTime;
			if (tablo.y <= 300 - tablo.tablo.height / 2)
			{
				tablo.y = 300 - tablo.tablo.height / 2;
				duringMoveTablo = false;
				removeEventListener(Event.ENTER_FRAME,upstairsTablo);
			}
		}
		public function beginDown()
		{
			duringMoveTablo = true;
			addEventListener(Event.ENTER_FRAME,downTablo);
			if (mayIdellGame)
			{
				Main.plan1.addChild(curtain);
				curtain.alpha = 0;
			}
		}
		public function downTablo(e:Event)
		{
			tablo.y +=  300 / basicTime;
			if (tablo.y >= 600)
			{
				tablo.y = 600;
				duringMoveTablo = false;
				removeEventListener(Event.ENTER_FRAME,downTablo);
				dellTablo();
			}
			if (mayIdellGame)
			{
				curtain.alpha +=  1 / basicTime;
			}
		}
		public function dellTablo()
		{
			tablo.cleanTablo();
			Main.plan1.removeChild(tablo);
			tablo = null;
			army.silense = true;
			if (mayIdellGame)
			{
				curtain.alpha = 1;
				Main.plan1.removeChild(curtain);
				Main.removeClass(0);
				Main.addClass(2);
			}
		}
		private function addValley(i,m)
		{
			var a = Math.random();

			if (a <= relative[0])
			{
				grid[i][m] = new Top(i,m);
			}
			else if (a<=relative[1])
			{
				grid[i][m] = new Hill(i,m);
			}
			else if (a<=relative[2])
			{
				grid[i][m] = new Sea(i,m);
			}
			else if (a<=relative[3])
			{
				grid[i][m] = new Wood(i,m);
			}
			else if (a<=relative[4])
			{
				grid[i][m] = new Cast(i,m);
			}
			else
			{
				grid[i][m] = new Lawn(i,m);
			}
		}
		private function preobrazovat()
		{
			relative[1] +=  relative[0];
			relative[2] +=  relative[1];
			relative[3] +=  relative[2];
			relative[4] +=  relative[3];
			relative[5] +=  relative[4];
		}
		private function mouseClick(e:MouseEvent)
		{
			army.mouseClickOnArmy();
		}

		public function treatObject()
		{
			if (army.wakedObject != null)
			{
				if (castle[turn].money >= Main.da.wasteMoneyToTreat_d)
				{
					army.wakedObject.traatMyself();
				}
			}
		}

		public function pressNext()
		{
			//при вызове меняется ход
			if (army.silense && ! animationCloud.duringAnimation)
			{

				animationCloud.playAnimationCloud();

				army.deleteNoSteps(turn);
				castle[turn].dellInfCastle();

				if (turn == 0)
				{
					turn = 1;
				}
				else
				{
					turn = 0;
				}
				stat.nextDay();

				downString.changeTurn(turn);
				army.addSteps(turn);
				castle[turn].nextToOtherTurn();

				army.deleteTargets();
				army.allowedAttack = false;
				army.dellPlacesOfAttack();
				downString.attackButton.attackButton.gotoAndStop(1);
			}
		}
		public function dellBits()
		{
			removeChild(bits);
			bits = null;
		}
		public function otherSide(num)
		{
			if (num == 0)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		private function setSaveGrid(i,m)
		{
			var arr = Main.saveGrid[i][m];
			if (arr[1] == 1)
			{
				grid[i][m] = new Lawn(i,m);
			}
			if (arr[1] == 2)
			{
				grid[i][m] = new Wood(i,m);
			}
			if (arr[1] == 3)
			{
				grid[i][m] = new Hill(i,m);
			}
			if (arr[1] == 4)
			{
				grid[i][m] = new Sea(i,m);
			}
			if (arr[1] == 5)
			{
				grid[i][m] = new Top(i,m);
			}
			if (arr[1] == 6)
			{
				grid[i][m] = new Cast(i,m);
			}
		}
		public function cleanGame()
		{
			Main.place.removeEventListener(MouseEvent.CLICK,mouseClick);
			Main.place.removeEventListener(KeyboardEvent.KEY_DOWN, kd);
			for (var i = 0; i<16; i++)
			{
				for (var m = 0; m<11; m++)
				{
					grid[i][m].cleanValey();
					Main.plan4.removeChild(grid[i][m]);
					grid[i][m] = null;
				}
			}
			army.cleanArmy();
			Main.plan2.removeChild(army);
			army = null;

			castle[0].cleanCastle();
			castle[1].cleanCastle();
			Main.plan3.removeChild(castle[0]);
			Main.plan3.removeChild(castle[1]);
			castle[0] = null;
			castle[1] = null;

			downString.cleanDownString();
			Main.plan1.removeChild(downString);
			downString = null;

			Main.plan2.removeChild(background_downString);
			background_downString = null;

			bang = null;
			animationCloud = null;
			figure = null;
			stat = null;
		}
	}
}// size of grid is 16x11