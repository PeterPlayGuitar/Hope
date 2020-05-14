package valey
{

	public class Wood extends Common
	{

		public function Wood(xPos:int,yPos:int)
		{
			//busy = false;
			grafObject = new wood_mc  ;
			protection = Main.da.protectWood_d
			stepsForMove = Main.da.minusEnergyForReplaceWood_d
			that = "wood";
			commonCommand(xPos,yPos);
		}

	}

}