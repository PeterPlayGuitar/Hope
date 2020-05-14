package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;

	public class Editor extends Sprite
	{
		private var exel = new editExel_mc  ;
		private var graf = new allLands_mc  ;
		private var background_downString = new background_downString_mc  ;
		private var numGraf = 1;
		private var e_eraser = new e_eraser_mc  ;
		private var comeBackButton = new nextRed_mc  ;
		private var grafOfCastle:Array = [new castle_mc  ,new castle_mc  ];

		private var up:Sprite = new Sprite  ();
		private var middle:Sprite = new Sprite();
		private var down:Sprite = new Sprite  ();

		public function Editor()
		{
			addChild(down);
			addChild(middle);
			addChild(up);

			for (var i = 0; i < 16; i++)
			{
				for (var m = 0; m < 11; m++)
				{
					if (Main.saveGrid[i][m][1] != 0)
					{
						addValey(i,m,Main.saveGrid[i][m][1]);
					}
				}
			}
			for (var v = 0; v<2; v++)
			{
				if (Main.placeOfCastle[v][0] != null)
				{
					grafOfCastle[v].x = Main.placeOfCastle[v][0] * 50;
					grafOfCastle[v].y = Main.placeOfCastle[v][1] * 50;
					middle.addChild(grafOfCastle[v]);
				}
			}
			grafOfCastle[0].gotoAndStop(1);
			grafOfCastle[1].gotoAndStop(2);

			up.addChild(exel);
			comeBackButton.x = 50;
			comeBackButton.y = 574;
			comeBackButton.scaleX = -1;
			graf.x = 375;
			graf.y = 550;
			graf.scaleX = 0.8;
			graf.scaleY = graf.scaleX;
			graf.x +=  5;
			graf.y +=  5;
			graf.gotoAndStop(numGraf);
			background_downString.x = 800;
			background_downString.y = 600;
			e_eraser.x = 300;
			e_eraser.y = 600;
			up.addChild(background_downString);
			up.addChild(graf);
			up.addChild(comeBackButton);
			up.addChild(e_eraser);
			comeBackButton.addEventListener(MouseEvent.CLICK,clickComeBackButton);
			Main.place.addEventListener(MouseEvent.MOUSE_MOVE,mm);
			addEventListener(MouseEvent.MOUSE_WHEEL,mw);
			addEventListener(MouseEvent.MOUSE_DOWN,md);
			Main.place.addEventListener(KeyboardEvent.KEY_DOWN,kd);
		}
		private function kd(e:KeyboardEvent)
		{
			if (mouseX>0&&mouseX<800&&mouseY>0&&mouseY<550)
			{
				if (e.keyCode == 69)
				{
					if (Main.saveGrid[int(mouseX / 50)][int(mouseY / 50)][1] != 0)
					{
						removeValey(int(mouseX / 50),int(mouseY / 50));
					}
					for (var i = 0; i<2; i++)
					{
						if (Main.placeOfCastle[i][0] == int(mouseX / 50) && Main.placeOfCastle[i][1] == int(mouseY / 50))
						{
							Main.placeOfCastle[i][0] = null;
							Main.placeOfCastle[i][1] = null;
							middle.removeChild(grafOfCastle[i]);
						}
					}
				}
				else if (e.keyCode == 82 && Main.saveGrid[int(mouseX / 50)][int(mouseY / 50)][1] == 0)
				{
					addValey(int(mouseX / 50),int(mouseY / 50),numGraf);
				}
				else if (e.keyCode == 87 && mouseY < 500)
				{
					addCastle(1);
				}
				else if (e.keyCode == 81 && mouseY < 500)
				{
					addCastle(0);
				}
			}
		}
		private function addValey(X,Y,num)
		{
			var a = Main.saveGrid[X][Y];
			a[0] = new allLands_mc  ;
			a[0].gotoAndStop(num);
			a[1] = num;
			a[0].x = X * 50;
			a[0].y = Y * 50;
			down.addChild(a[0]);
		}
		private function removeValey(X,Y)
		{
			var a = Main.saveGrid[X][Y];
			a[1] = 0;
			down.removeChild(a[0]);
			a[0] = null;
		}
		private function addCastle(side)
		{
			if (!(Main.placeOfCastle[otherSide(side)][0] == int(mouseX / 50) && Main.placeOfCastle[otherSide(side)][1] == int(mouseY / 50)))
			{
				Main.placeOfCastle[side][0] = int(mouseX / 50);
				Main.placeOfCastle[side][1] = int(mouseY / 50);
				grafOfCastle[side].x = int(mouseX / 50)*50;
				grafOfCastle[side].y = int(mouseY / 50)*50;
				middle.addChild(grafOfCastle[side]);
			}
		}
		private function otherSide(side)
		{
			if (side == 1)
			{
				return 0;
			}
			else
			{
				return 1;
			}
		}
		private function mm(e:MouseEvent)
		{
			exel.x = int(mouseX / 50) * 50;
			exel.y = int(mouseY / 50) * 50;
		}
		private function mw(e:MouseEvent)
		{
			numGraf +=   -  e.delta / 3;
			if (numGraf > 6)
			{
				numGraf = 1;
			}
			if (numGraf < 1)
			{
				numGraf = 6;
			}
			graf.gotoAndStop(numGraf);
		}
		private function md(e:MouseEvent)
		{
			if (mouseX>0&&mouseX<800&&mouseY>0&&mouseY<550&&Main.saveGrid[int(mouseX / 50)][int(mouseY / 50)][1] == 0)
			{
				addValey(int(mouseX / 50),int(mouseY / 50),numGraf);
			}
		}
		private function clickComeBackButton(e:MouseEvent)
		{
			Main.removeClass(1);
			Main.addClass(2);
		}
		public function cleanEditor()
		{
			up.removeChild(background_downString);
			up.removeChild(graf);
			up.removeChild(comeBackButton);
			up.removeChild(e_eraser);

			if (Main.placeOfCastle[0][0] != null)
			{
				middle.removeChild(grafOfCastle[0]);
			}
			if (Main.placeOfCastle[1][0] != null)
			{
				middle.removeChild(grafOfCastle[1]);
			}

			for (var i = 0; i < 16; i++)
			{
				for (var m = 0; m < 11; m++)
				{
					if (Main.saveGrid[i][m][1] != 0)
					{
						down.removeChild(Main.saveGrid[i][m][0]);
						Main.saveGrid[i][m][0] = null;
					}
				}
			}

			up.removeChild(exel);

			removeChild(down);
			removeChild(middle);
			removeChild(up);

			down = null;
			middle = null;
			up = null;

			comeBackButton.removeEventListener(MouseEvent.CLICK,clickComeBackButton);
			Main.place.removeEventListener(MouseEvent.MOUSE_MOVE,mm);
			removeEventListener(MouseEvent.MOUSE_WHEEL,mw);
			removeEventListener(MouseEvent.MOUSE_DOWN,md);
			Main.place.removeEventListener(KeyboardEvent.KEY_DOWN,kd);
		}
	}
}