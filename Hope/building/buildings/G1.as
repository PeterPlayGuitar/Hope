package building.buildings
{

	public class G1 extends CommonForBuildings
	{

		public function G1()
		{
			nameB = "Пивная";
			graf = new g1  ;
			graf.gotoAndStop(1);
			priceD = 0;
			numer = 1;
			descript = "Позволяет нанимать солдат";
			beginFunction();
		}
		public function whenHaveBuilded()
		{

		}

	}

}