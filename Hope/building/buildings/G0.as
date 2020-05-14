package building.buildings
{

	public class G0 extends CommonForBuildings
	{
		private var healthPlus:int = Main.da.healthPlusG0_d;

		public function G0()
		{
			nameB = "Ров";
			graf = new g0  ;
			graf.gotoAndStop(1);
			priceD = 0;
			numer = 0;
			descript = "Глубокий ров вокруг замка. Врагам нужно потратить больше усилий чтобы разрушить крепость\nЗащита замка увеличивается до " + healthPlus;
			beginFunction();
		}
		public function whenHaveBuilded()
		{
			Main.game.castle[side].health = healthPlus;
		}

	}

}