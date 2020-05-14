package building
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ManageWindow extends Sprite
	{
		private var manageWindow = new manageWindow_mc  ;
		private var existingBuildings:Array = [false,false,false];//0 is bar;1 is store;2 is colledge;

		private var buyArcherButton = new buyArcherButton_mc  ;
		private var buyDiamondButton = new buyDiamondButton_mc  ;
		private var buyMoneyButton = new buyMoneyButton_mc  ;
		private var buyWarButton = new buyWarButton_mc  ;

		private var tabloForManage = new tabloForManage_mc  ;

		private var CMgraf = new CM  ;
		private var SMgraf = new SM  ;
		private var BMgraf = new BM  ;

		private var priceArch = Main.da.priceArch_d;
		private var priceWar = Main.da.priceWar_d;
		private var priceBuyDiamond = Main.da.priceBuyDiamond_d;
		private var priceSellDiamond = Main.da.priceSellDiamond_d;

		public var buildedInThisDayBar:Boolean = false;
		private var side:int;

		public function ManageWindow(side_p)
		{
			side = side_p;

			buyArcherButton.x = 206.3;
			buyArcherButton.y = 45.7;
			buyDiamondButton.x = 155.8;
			buyDiamondButton.y = 101.9;
			buyMoneyButton.x = 206.3;
			buyMoneyButton.y = 101.9;
			buyWarButton.x = 155.8;
			buyWarButton.y = 45.7;

			BMgraf.x = 61.6;
			BMgraf.y = 42.9;
			SMgraf.x = 60.3;
			SMgraf.y = 100.6;
			CMgraf.x = 63.9;
			CMgraf.y = 173.2;
		}
		//вход в режим стройки
		public function addGoTo()
		{
			addChild(manageWindow);

			// если построена пивная
			if (existingBuildings[0])
			{
				addChild(BMgraf);
				addChild(buyArcherButton);
				addChild(buyWarButton);

				buyArcherButton.addEventListener(MouseEvent.CLICK,buyArch);
				buyArcherButton.addEventListener(MouseEvent.MOUSE_OVER,archOver);
				buyArcherButton.addEventListener(MouseEvent.MOUSE_OUT,archOut);

				buyWarButton.addEventListener(MouseEvent.CLICK,buyWar);
				buyWarButton.addEventListener(MouseEvent.MOUSE_OVER,warOver);
				buyWarButton.addEventListener(MouseEvent.MOUSE_OUT,warOut);
			}
			// если построен рынок;
			if (existingBuildings[1])
			{
				addChild(SMgraf);
				addChild(buyMoneyButton);
				addChild(buyDiamondButton);

				buyMoneyButton.addEventListener(MouseEvent.MOUSE_DOWN,buyMoney_d);
				buyMoneyButton.addEventListener(MouseEvent.MOUSE_UP,buyMoney_u);
				buyMoneyButton.addEventListener(MouseEvent.MOUSE_OVER,moneyOver);
				buyMoneyButton.addEventListener(MouseEvent.MOUSE_OUT,moneyOut);

				buyDiamondButton.addEventListener(MouseEvent.MOUSE_DOWN,buyDiamond_d);
				buyDiamondButton.addEventListener(MouseEvent.MOUSE_UP,buyDiamond_u);
				buyDiamondButton.addEventListener(MouseEvent.MOUSE_OVER,diamondOver);
				buyDiamondButton.addEventListener(MouseEvent.MOUSE_OUT,diamondOut);
			}
			//если построена академия;
			if (existingBuildings[2])
			{
				addChild(CMgraf);
			}
			setFrame();
		}
		//покупка лучника
		private function buyArch(e:MouseEvent)
		{
			var money = Main.game.castle[side].money;
			var space = Main.game.grid[Main.game.castle[side].positionX][Main.game.castle[side].positionY + 1];
			var a = Main.game.army.armySide[side];

			if (! buildedInThisDayBar && priceArch <= money && space.sideBusy == 2)
			{
				buildedInThisDayBar = true;
				Main.game.army.armySide[side].creatNewWarrior(1);
				Main.game.castle[side].minusMoney(-priceArch,0);
				setFrame();

				Main.game.bang.makeCertainBang(Main.place.mouseX,Main.place.mouseY,4,50,0xFE511B,0);
			}
		}
		//покупка мечника
		private function buyWar(e:MouseEvent)
		{
			var money = Main.game.castle[side].money;
			var space = Main.game.grid[Main.game.castle[side].positionX][Main.game.castle[side].positionY + 1];

			if (! buildedInThisDayBar && priceWar <= money && space.sideBusy == 2)
			{
				buildedInThisDayBar = true;
				Main.game.army.armySide[side].creatNewWarrior(0);
				Main.game.castle[side].minusMoney(-priceWar,0);
				setFrame();

				Main.game.bang.makeCertainBang(Main.place.mouseX,Main.place.mouseY,4,50,0x1B94FE,0);
			}
		}
		// покупка бриллианта
		private function buyDiamond_d(e:MouseEvent)
		{
			if (buyDiamondButton.currentFrame == 1)
			{
				buyDiamondButton.gotoAndStop(3);
			}
		}
		private function buyDiamond_u(e:MouseEvent)
		{
			if (Main.game.castle[side].money >= priceBuyDiamond)
			{
				Main.game.castle[side].minusMoney(-priceBuyDiamond,1);
				buyDiamondButton.gotoAndStop(1);
				setFrame();

				Main.game.bang.makeCertainBang(Main.place.mouseX,Main.place.mouseY,4,50,0x1BE5FE,0);
			}
		}
		// продажа бриллиантов
		private function buyMoney_d(e:MouseEvent)
		{
			if (buyMoneyButton.currentFrame == 1)
			{
				buyMoneyButton.gotoAndStop(3);
			}
		}
		private function buyMoney_u(e:MouseEvent)
		{
			if (Main.game.castle[side].dimonds != 0)
			{
				Main.game.castle[side].minusMoney(priceSellDiamond,-1);
				buyMoneyButton.gotoAndStop(1);
				setFrame();

				Main.game.bang.makeCertainBang(Main.place.mouseX,Main.place.mouseY,4,50,0xFFFF00,0);
			}
		}
		// выход из режима стройки
		public function removeOutFrom()
		{
			removeChild(manageWindow);
			if (existingBuildings[0])
			{
				buyArcherButton.removeEventListener(MouseEvent.CLICK,buyArch);
				buyArcherButton.removeEventListener(MouseEvent.MOUSE_OVER,archOver);
				buyArcherButton.removeEventListener(MouseEvent.MOUSE_OUT,archOut);

				buyWarButton.removeEventListener(MouseEvent.MOUSE_OVER,warOver);
				buyWarButton.removeEventListener(MouseEvent.MOUSE_OUT,warOut);
				buyWarButton.removeEventListener(MouseEvent.CLICK,buyWar);

				removeChild(BMgraf);
				removeChild(buyArcherButton);
				removeChild(buyWarButton);
			}
			if (existingBuildings[1])
			{
				buyMoneyButton.removeEventListener(MouseEvent.MOUSE_DOWN,buyMoney_d);
				buyMoneyButton.removeEventListener(MouseEvent.MOUSE_UP,buyMoney_u);
				buyMoneyButton.removeEventListener(MouseEvent.MOUSE_OVER,moneyOver);
				buyMoneyButton.removeEventListener(MouseEvent.MOUSE_OUT,moneyOut);

				buyDiamondButton.removeEventListener(MouseEvent.MOUSE_OVER,diamondOver);
				buyDiamondButton.removeEventListener(MouseEvent.MOUSE_OUT,diamondOut);
				buyDiamondButton.removeEventListener(MouseEvent.MOUSE_DOWN,buyDiamond_d);
				buyDiamondButton.removeEventListener(MouseEvent.MOUSE_UP,buyDiamond_u);

				removeChild(SMgraf);
				removeChild(buyMoneyButton);
				removeChild(buyDiamondButton);
			}
			if (existingBuildings[2])
			{
				removeChild(CMgraf);
			}
		}
		private function setFrame()
		{
			var money = Main.game.castle[side].money;
			var diamonds = Main.game.castle[side].dimonds;
			var space = Main.game.grid[Main.game.castle[side].positionX][Main.game.castle[side].positionY + 1];

			//то что касается пивной
			if (! buildedInThisDayBar && priceArch <= money && space.sideBusy == 2)
			{
				buyArcherButton.gotoAndStop(1);
			}
			else
			{
				buyArcherButton.gotoAndStop(2);
			}
			if (! buildedInThisDayBar && priceWar <= money && space.sideBusy == 2)
			{
				buyWarButton.gotoAndStop(1);
			}
			else
			{
				buyWarButton.gotoAndStop(2);
			}
			//то что касается рынка
			if (diamonds!=0)
			{
				buyMoneyButton.gotoAndStop(1);
			}
			else
			{
				buyMoneyButton.gotoAndStop(2);
			}
			if (money>=priceBuyDiamond)
			{
				buyDiamondButton.gotoAndStop(1);
			}
			else
			{
				buyDiamondButton.gotoAndStop(2);
			}
		}
		public function updateInfo(bar:Boolean,store:Boolean,colledge:Boolean)
		{
			removeOutFrom();
			existingBuildings = [bar,store,colledge];
			addGoTo();
		}
		private function warOver(e:MouseEvent)
		{
			tabloForManage.gotoAndStop(1);
			tabloForManage.money.text = priceWar;
			tabloForManage.x = mouseX;
			tabloForManage.y = mouseY;
			addChild(tabloForManage);
			
			buyWarButton.scaleX = 1.1
			buyWarButton.scaleY = 1.1
		}
		private function warOut(e:MouseEvent)
		{
			removeChild(tabloForManage);
			
			buyWarButton.scaleX = 1
			buyWarButton.scaleY = 1
		}
		private function archOver(e:MouseEvent)
		{
			tabloForManage.gotoAndStop(2);
			tabloForManage.money.text = priceArch;
			tabloForManage.x = mouseX;
			tabloForManage.y = mouseY;
			addChild(tabloForManage);
			
			buyArcherButton.scaleX = 1.1
			buyArcherButton.scaleY = 1.1
		}
		private function archOut(e:MouseEvent)
		{
			removeChild(tabloForManage);
			
			buyArcherButton.scaleX = 1
			buyArcherButton.scaleY = 1
		}
		private function diamondOver(e:MouseEvent)
		{
			tabloForManage.gotoAndStop(3);
			tabloForManage.money.text = priceBuyDiamond;
			tabloForManage.x = mouseX;
			tabloForManage.y = mouseY;
			addChild(tabloForManage);
			
			buyDiamondButton.scaleX = 1.1
			buyDiamondButton.scaleY = 1.1
		}
		private function diamondOut(e:MouseEvent)
		{
			removeChild(tabloForManage);
			if (buyDiamondButton.currentFrame == 3)
			{
				buyDiamondButton.gotoAndStop(1);
			}
			
			buyDiamondButton.scaleX = 1
			buyDiamondButton.scaleY = 1
		}
		private function moneyOver(e:MouseEvent)
		{
			tabloForManage.gotoAndStop(4);
			tabloForManage.money.text = priceSellDiamond;
			tabloForManage.x = mouseX;
			tabloForManage.y = mouseY;
			addChild(tabloForManage);
			
			buyMoneyButton.scaleX = 1.1
			buyMoneyButton.scaleY = 1.1
		}
		private function moneyOut(e:MouseEvent)
		{
			removeChild(tabloForManage);
			if (buyMoneyButton.currentFrame == 3)
			{
				buyMoneyButton.gotoAndStop(1);
			}
			
			buyMoneyButton.scaleX = 1
			buyMoneyButton.scaleY = 1
		}
		public function cleanManageWindow()
		{
			buyArcherButton = null;
			buyDiamondButton = null;
			buyMoneyButton = null;
			buyWarButton = null;

			SMgraf = null;
			BMgraf = null;
			CMgraf = null;

			tabloForManage = null;
		}
	}
}