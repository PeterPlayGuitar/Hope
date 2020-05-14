package building.buildings
{

	public class G6 extends CommonForBuildings
	{
		private var attackPlus = Main.da.attackPlusG6_d;

		public function G6()
		{
			nameB = "Казарма";
			graf = new g6  ;
			graf.gotoAndStop(1);
			priceD = 0;
			numer = 6;
			descript = "Место где любой твой преданный солдат ближнего боя может улучшить свои навыки владения мечём\nСила удара от меча увеличивается до " + attackPlus;
			beginFunction();
		}
		public function whenHaveBuilded()
		{
			var a = Main.game.army.armySide[side];
			a.attackWar = attackPlus;
			a.improvmentWar = 2
			for (var i = 0; i<a.war.length; i++)
			{
				a.war[i].improving(attackPlus)
			}
		}

	}

}