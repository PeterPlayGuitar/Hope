package valey
{

	public class Sea extends Common
	{

		public function Sea(xPos:int,yPos:int)
		{
			//busy = false;
			grafObject = new sea_mc  ;
			protection = Main.da.protectSea_d
			stepsForMove = Main.da.minusEnergyForReplaceSea_d
			that = "sea";
			commonCommand(xPos,yPos);
		}

	}

}