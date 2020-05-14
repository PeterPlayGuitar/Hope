package building.buildings
{

	public class G8 extends CommonForBuildings
	{
		private var healthPlus:int = Main.da.healthPlusG8_d;

		public function G8()
		{
			nameB = "Укрепления";
			graf = new g8  ;
			graf.gotoAndStop(1);
			priceD = 1;
			numer = 8;
			descript = "Более крепкие стены, которые затрудняют осаду замка врагом\nЗащита замка увеличивается до " + healthPlus;
			beginFunction();
		}
		public function whenHaveBuilded()
		{
			Main.game.castle[side].health = healthPlus;
		}

	}

}