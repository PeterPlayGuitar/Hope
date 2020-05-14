package building.buildings
{

	public class G10 extends CommonForBuildings
	{
		private var critPlus = Main.da.critPlusG10_d;

		public function G10()
		{
			nameB = "Собор";
			graf = new g10  ;
			graf.gotoAndStop(1);
			priceD = 1;
			numer = 10;
			descript = "Собор воспитывает в воинах силу духа, и веру в победу\nПрибавляет " + critPlus + " к шансу критического удара каждого воина";
			beginFunction();
		}
		public function whenHaveBuilded()
		{
			var a = Main.game.army.armySide[side];
			a.critWar +=  critPlus;
			a.critArch +=  critPlus;
			for (var i = 0; i<a.war.length; i++)
			{
				a.war[i].crit +=  critPlus;
			}
			for (var m = 0; m<a.archer.length; m++)
			{
				a.archer[m].crit +=  critPlus;
			}
		}

	}

}