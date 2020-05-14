package building.buildings
{

	public class G4 extends CommonForBuildings
	{
		private var populationPlus = Main.da.populationPlusG4_d;

		public function G4()
		{
			nameB = "Хижина";
			graf = new g4  ;
			graf.gotoAndStop(1);
 			priceD = 0;
			numer = 4;
			descript = "Свободные для заселения воинами квартиры\nУвеличивает максимально возможное количество воинов до " + populationPlus;
			beginFunction();
		}
		public function whenHaveBuilded()
		{
			Main.game.castle[side].population = populationPlus;
		}

	}

}