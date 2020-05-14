package building.buildings
{

	public class G9 extends CommonForBuildings
	{
		private var moneyPlus = Main.da.plusMoneyG9_d;

		public function G9()
		{
			nameB = "Большая ратуша";
			graf = new g9  ;
			graf.gotoAndStop(1);
			priceD = 1;
			numer = 9;
			descript = "Приносит больше денег от сбора налогов\nЕжедневный доход: +" + moneyPlus;
			beginFunction();
		}
		public function whenHaveBuilded()
		{
			Main.game.castle[side].dailyProfit = moneyPlus;
		}

	}

}