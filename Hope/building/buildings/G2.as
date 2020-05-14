package building.buildings
{

	public class G2 extends CommonForBuildings
	{
		private var moneyPlus = Main.da.plusMoneyG2_d;

		public function G2()
		{
			nameB = "Ратуша";
			graf = new g2  ;
			graf.gotoAndStop(1);
			priceD = 0;
			numer = 2;
			descript = "Позволяет собирать больше налогов с граждан\nЕжедневный доход: +" + moneyPlus;
			beginFunction();
		}
		public function whenHaveBuilded()
		{
			Main.game.castle[side].dailyProfit = moneyPlus;
		}

	}

}