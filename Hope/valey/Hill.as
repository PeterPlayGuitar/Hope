package valey
{

	public class Hill extends Common
	{

		public function Hill(xPos:int,yPos:int)
		{
			//busy = false
			grafObject = new hill_mc  ;
			protection = Main.da.protectHill_d
			stepsForMove = Main.da.minusEnergyForReplaceHill_d
			that = "hill";
			commonCommand(xPos,yPos);
		}

	}

}