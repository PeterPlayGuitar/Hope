package building.buildings
{

	public class G3 extends CommonForBuildings
	{

		private var moneyPlus = Main.da.plusMoneyG3_d;

		public function G3()
		{
			nameB = "Мельница";
			graf = new g3  ;
			graf.gotoAndStop(1);
 			priceD = 0;
			numer = 3;
			descript = "Приносит замку дополнительный доход\nЕжедневный доход: +" + moneyPlus;
			beginFunction();
		}
		public function whenHaveBuilded()
		{
			Main.game.castle[side].dailyProfit = moneyPlus;
		}

	}

}