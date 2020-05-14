package building.buildings
{
	public class G5 extends CommonForBuildings
	{
		private var attackPlus = Main.da.attackPlusG5_d;

		public function G5(side_p)
		{
			side = side_p
			nameB = "Стрельбище";
			graf = new g5  ;
			graf.gotoAndStop(1);
			priceD = 0;
			numer = 5;
			var needToSay:String;
			if (side == 0)
			{
				needToSay = "стрел";
			}
			else
			{
				needToSay = "ядер";
			}
			descript = "Отличная тренеровачная площадка для дальнобойных отрядов\nУрон от " + needToSay + " увеличивается до " + attackPlus;
			beginFunction();
		}
		public function whenHaveBuilded()
		{
			var a = Main.game.army.armySide[side];
			a.attackArch = attackPlus;
			a.improvmentArch = 2;
			for (var i = 0; i<a.archer.length; i++)
			{
				a.archer[i].improving(attackPlus);
			}
		}
	}
}