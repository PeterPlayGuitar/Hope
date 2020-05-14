package building.buildings
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class CommonForBuildings extends Sprite
	{
		public var numer;
		public var nameB:String;
		public var graf;
		public var descript;
		public var price;
		public var priceD;
		private var infOfBuild = new infOfBuild_mc  ;
		private var infOfBuildOnStage:Boolean = false;
		private var existEvents = false;
		public var side;

		private var usingCast:*;

		public function beginFunction()
		{
			addChild(graf);
			price = Main.da.price_d[numer];
		}
		private function mover(e:MouseEvent)
		{
			infOfBuild.x = Main.plan1.mouseX;
			infOfBuild.y = Main.plan1.mouseY;
			infOfBuild.nameB.text = nameB;
			infOfBuildOnStage = true;
			Main.plan1.addChild(infOfBuild);
		}
		private function mout(e:MouseEvent)
		{
			infOfBuildOnStage = false;
			Main.plan1.removeChild(infOfBuild);
		}
		private function mc(e:MouseEvent)
		{
			// вклучение инфы о зданиях
			var a = Main.game.castle[side].build;
			a.win1.descript.text = descript;
			a.win1.nameB.text = nameB;
			a.choisedNumer = numer;
			a.setChoise();
		}
		public function addEvents()
		{
			//при входе

			existEvents = true;
			graf.addEventListener(MouseEvent.MOUSE_OVER,mover);
			graf.addEventListener(MouseEvent.MOUSE_OUT,mout);
			graf.addEventListener(MouseEvent.CLICK,mc);
		}
		public function dellEvents()
		{
			//при выходе из замка

			existEvents = false;
			graf.removeEventListener(MouseEvent.MOUSE_OVER,mover);
			graf.removeEventListener(MouseEvent.MOUSE_OUT,mout);
			graf.removeEventListener(MouseEvent.CLICK,mc);
		}
		public function cleanBuilding()
		{
			if (infOfBuildOnStage)
			{
				Main.plan1.removeChild(infOfBuild);
			}
			infOfBuild = null;
			if (existEvents)
			{
				graf.removeEventListener(MouseEvent.MOUSE_OVER,mover);
				graf.removeEventListener(MouseEvent.MOUSE_OUT,mout);
				graf.removeEventListener(MouseEvent.CLICK,mc);
			}
			removeChild(graf);
			graf = null;
		}

	}

}