package valey
{

	public class Lawn extends Common
	{

		public function Lawn(xPos:int,yPos:int)
		{
			//busy = false
			grafObject = new lawn_mc  ;
			protection = Main.da.protectLawn_d
			stepsForMove = Main.da.minusEnergyForReplaceLawn_d
			that = "lawn"
			commonCommand(xPos,yPos);
		}

	}

}