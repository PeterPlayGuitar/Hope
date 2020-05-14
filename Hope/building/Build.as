package building
{
	import flash.events.MouseEvent;
	import building.buildings.*;
	import flash.display.Sprite;

	public class Build extends Sprite
	{
		private var size = 14;
		private var conection:Array = new Array(size);
		private var stateBuild:Array = new Array(size);
		private var graf:Array = new Array(size);
		private var grafTrueGraf:Array = new Array();

		private var side;
		public var opportunityToBuild:Boolean = true;
		private var cast:Castle;
		private var windowOfCast = new windowOfCast_mc  ;
		private var buyButton = new buyButton_mc  ;
		private var exitButton = new cross_mc  ;
		private var moneyGraf = new moneyGraf_mc  ;
		private var placeForBuildings = new placeForBuildings_mc  ;
		private var infOfCastleInsideCastle = new infOfCastleInsideCastle_mc  ;
		private var existingEvent:Boolean = false;
		private var buyButtonOnStage:Boolean = false;
		private var existingEventBuy:Boolean = false;
		private var connectionOfBuilding = new connectionOfBuilding_mc  ;

		public var win1 = new win1_mc  ;

		public var choisedNumer;

		public var win2:*;

		public function Build(side_p)
		{
			side = side_p;
			firstThing();
			exitButton.x = 764;
			exitButton.y = 35;
			win1.x = 80;
			win1.y = 60;
			buyButton.x = 379,7;
			buyButton.y = 135;
			moneyGraf.x = 121;
			moneyGraf.y = 187;
			infOfCastleInsideCastle.x = 80;
			infOfCastleInsideCastle.y = 550;
			connectionOfBuilding.x = 444.45;
			connectionOfBuilding.y = 40;
			placeForBuildings.x = 80;
			placeForBuildings.y = 230;
			win2 = new ManageWindow(side);
			win2.x = 505.35;
			win2.y = 332.4;
			secondThing();
			for (var i = 0; i<size; i++)
			{
				graf[i].side = side;
				graf[i].x = 20;
				graf[i].y = 60 + i * graf[i].height;
			}
		}

		public function addEvent()
		{
			//каждый раз при входе

			cast = Main.game.castle[side];

			Main.game.castle[side].dellInfCastle();

			addChild(windowOfCast);
			addChild(exitButton);
			addChild(win1);
			addChild(connectionOfBuilding);
			addChild(infOfCastleInsideCastle);
			win2.addGoTo();
			addChild(win2);
			win2.updateInfo(stateBuild[1],stateBuild[11],stateBuild[13]);
			addChild(placeForBuildings);
			addChild(grafTrueGraf[0]);
			for (var m = 0; m<size; m++)
			{
				if (stateBuild[m])
				{
					addChildToNeed(m,false);
				}
			}

			updateInf();
			for (var i = 0; i<size; i++)
			{
				graf[i].addEvents();
				addChild(graf[i]);
			}
			existingEvent = true;
			exitButton.addEventListener(MouseEvent.CLICK,mouseClickOnExitButton);
		}

		private function mouseClickOnExitButton(e:MouseEvent)
		{
			//выход из режима стройки

			win1.descript.text = "";
			win1.nameB.text = "";
			choisedNumer = 0;

			removeChild(exitButton);
			removeChild(windowOfCast);
			removeChild(win1);
			removeChild(connectionOfBuilding);
			removeChild(infOfCastleInsideCastle);
			win2.removeOutFrom();
			removeChild(win2);
			removeChild(placeForBuildings);
			removeChild(grafTrueGraf[0]);
			for (var m = 0; m<size; m++)
			{
				removeChildToNeed(m);
			}

			if (buyButtonOnStage)
			{
				buyButton.removeEventListener(MouseEvent.CLICK,clickBuy);
				existingEventBuy = false;
				buyButtonOnStage = false;
				removeChild(buyButton);
				removeChild(moneyGraf);
			}

			for (var i = 0; i<size; i++)
			{
				graf[i].dellEvents();
				removeChild(graf[i]);
			}
			existingEvent = false;
			exitButton.removeEventListener(MouseEvent.CLICK,mouseClickOnExitButton);
			Main.game.castle[side].exitFromBuild();
		}

		public function setChoise()
		{
			//выбор постройки

			buyButtonOnStage = true;
			addChild(buyButton);
			setFrameBuyButton();
			addChild(moneyGraf);
			moneyGraf.m.text = graf[choisedNumer].price;
			moneyGraf.d.text = graf[choisedNumer].priceD;

			if (! existingEventBuy)
			{
				buyButton.addEventListener(MouseEvent.CLICK,clickBuy);
			}
			existingEventBuy = true;
		}

		private function clickBuy(e:MouseEvent)
		{
			//нажатие покупка

			var a = graf[choisedNumer];
			if (opportunityToBuild && a.price <= cast.money && a.priceD <= cast.dimonds && readyPastBuildings(choisedNumer) && ! stateBuild[choisedNumer])
			{
				cast.money -=  a.price;
				cast.dimonds -=  a.priceD;
				a.graf.gotoAndStop(2);
				stateBuild[choisedNumer] = true;
				addChildToNeed(choisedNumer,true);
				a.whenHaveBuilded();
				opportunityToBuild = false;
				setFrameBuyButton();
				win2.updateInfo(stateBuild[1],stateBuild[11],stateBuild[13]);
				updateInf();

				Main.game.bang.makeSmokeBang(grafTrueGraf[determineGraf(choisedNumer)].x,grafTrueGraf[determineGraf(choisedNumer)].y,a.price/5,50);
			}
		}
		public function updateInf()
		{
			var a = Main.game.army.armySide[side];

			infOfCastleInsideCastle.money.text = cast.money;
			infOfCastleInsideCastle.dimond.text = cast.dimonds;
			infOfCastleInsideCastle.health.text = cast.health;
			infOfCastleInsideCastle.population.text = a.archer.length + a.war.length + "/" + cast.population;
			infOfCastleInsideCastle.moneyPlus.text = cast.stringAboutMoneyPlus;
		}
		private function readyPastBuildings(num)
		{
			for (var i = 0; i<conection[num].length; i++)
			{
				if (stateBuild[conection[num][i]] == false)
				{
					return false;
				}
			}
			return true;
		}
		private function setFrameBuyButton()
		{
			var a = graf[choisedNumer];
			if (opportunityToBuild && a.price <= cast.money && a.priceD <= cast.dimonds && readyPastBuildings(choisedNumer) && ! stateBuild[choisedNumer])
			{
				buyButton.gotoAndStop(1);
			}
			else
			{
				buyButton.gotoAndStop(2);
			}
		}

		private function addChildToNeed(num,build:Boolean)
		{
			if (num < 7 && num > 0)
			{
				addChild(grafTrueGraf[num]);
			}
			if (build)
			{
				if (num == 0)
				{
					grafTrueGraf[0].gotoAndStop(2);
				}
				if (num == 7)
				{
					grafTrueGraf[4].gotoAndStop(2);
				}
				if (num == 8)
				{
					grafTrueGraf[0].gotoAndStop(3);
				}
				if (num == 9)
				{
					grafTrueGraf[2].gotoAndStop(2);
				}
			}
			if (num > 9)
			{
				addChild(grafTrueGraf[num-3]);
			}
		}
		private function removeChildToNeed(num)
		{
			if (stateBuild[num])
			{
				if (num < 7 && num > 0)
				{
					removeChild(grafTrueGraf[num]);
				}
				if (num > 9)
				{
					removeChild(grafTrueGraf[num-3]);
				}
			}
		}

		private function determineGraf(num)
		{
			var trueNum;
			if (num < 7)
			{
				trueNum = num;
			}
			if (num == 7)
			{
				trueNum = 4;
			}
			if (num == 8)
			{
				trueNum = 0;
			}
			if (num == 9)
			{
				trueNum = 2;
			}
			if (num > 9)
			{
				trueNum = num - 3;
			}
			return trueNum;
		}

		public function cleanBuild()
		{
			if (existingEvent)
			{
				exitButton.removeEventListener(MouseEvent.CLICK,mouseClickOnExitButton);
				existingEvent = false;
			}

			if (buyButtonOnStage)
			{
				buyButton.removeEventListener(MouseEvent.CLICK,clickBuy);
				existingEventBuy = false;
				removeChild(buyButton);
				removeChild(moneyGraf);
				buyButtonOnStage = false;
			}
			moneyGraf = null;
			buyButton = null;

			for (var i = 0; i<size; i++)
			{
				graf[i].cleanBuilding();
				graf[i] = null;
			}
			for (var m = 0; m<grafTrueGraf.length; m++)
			{
				if (stateBuild[m])
				{
					grafTrueGraf[m] = null;
				}
			}

			infOfCastleInsideCastle = null;

			exitButton = null;

			windowOfCast = null;

			connectionOfBuilding = null;

			win1 = null;

			placeForBuildings = null;

			win2.cleanManageWindow();
			win2 = null;
		}

		private function firstThing()
		{
			for (var m = 0; m<size; m++)
			{
				stateBuild[m] = false;
			}

			conection[0] = [];
			conection[1] = [];
			conection[2] = [];
			conection[3] = [2];
			conection[4] = [2];
			conection[5] = [0,1];
			conection[6] = [1,3];
			conection[7] = [4];
			conection[8] = [5,6];
			conection[9] = [6,7];
			conection[10] = [4];
			conection[11] = [7];
			conection[12] = [9];
			conection[13] = [7,8,10];

			graf = [new G0(),new G1(),new G2(),new G3(),new G4(),new G5(side),new G6(),new G7(),new G8(),new G9(),new G10(),new G11(),new G12(),new G13()];
		}
		private function secondThing()
		{
			var X = placeForBuildings.x;
			var Y = placeForBuildings.y;

			grafTrueGraf = [new b0  ,new b1  ,new b2  ,new b3  ,new b4  ,new b5  ,new b6  ,new b10  ,new b11  ,new b12  ,new b13  ];

			grafTrueGraf[0].gotoAndStop(1);
			grafTrueGraf[0].x = X + 329;
			grafTrueGraf[0].y = Y + 132;
			grafTrueGraf[0].scaleX = 1.5;
			grafTrueGraf[0].scaleY = 1.5;

			grafTrueGraf[1].x = X + 208;
			grafTrueGraf[1].y = Y + 151;
			grafTrueGraf[1].scaleX = 0.78;
			grafTrueGraf[1].scaleY = 0.78;

			grafTrueGraf[2].gotoAndStop(1);
			grafTrueGraf[2].x = X + 104;
			grafTrueGraf[2].y = Y + 177;

			grafTrueGraf[3].x = X + 288;
			grafTrueGraf[3].y = Y + 247;
			grafTrueGraf[3].scaleX = -1;

			grafTrueGraf[4].gotoAndStop(1);
			grafTrueGraf[4].x = X + 330;
			grafTrueGraf[4].y = Y + 220;

			grafTrueGraf[5].x = X + 348;
			grafTrueGraf[5].y = Y + 153;

			grafTrueGraf[6].x = X + 252;
			grafTrueGraf[6].y = Y + 126;

			grafTrueGraf[7].x = X + 69;
			grafTrueGraf[7].y = Y + 220;
			grafTrueGraf[7].scaleX = -1;

			grafTrueGraf[8].x = X + 169;
			grafTrueGraf[8].y = Y + 185;
			grafTrueGraf[8].scaleX = -1;

			grafTrueGraf[9].x = X + 69;
			grafTrueGraf[9].y = Y + 182;
			grafTrueGraf[9].scaleX = -1;

			grafTrueGraf[10].x = X + 207;
			grafTrueGraf[10].y = Y + 244;
		}
	}
}