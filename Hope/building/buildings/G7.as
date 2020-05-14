package building.buildings
{

	public class G7 extends CommonForBuildings
	{
		private var populationPlus = Main.da.populationPlusG7_d

		public function G7()
		{
			nameB = "Большая хижина";
			graf = new g7  ;
			graf.gotoAndStop(1);
 			priceD = 1;
			numer = 7;
			descript = "Добавляет в хижину этаж для заселения воинами\nУвеличивает максимально возможное количество воинов до " + populationPlus;
			beginFunction();
		}
		public function whenHaveBuilded()
		{
			Main.game.castle[side].population = populationPlus;
		}

	}

}