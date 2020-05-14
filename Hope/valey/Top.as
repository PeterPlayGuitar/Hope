package valey
{

	public class Top extends Common
	{

		public function Top(xPos:int,yPos:int)
		{
			//busy = false
			grafObject = new top_mc  ;
			protection = Main.da.protectTop_d
			stepsForMove = Main.da.minusEnergyForReplaceTop_d
			that = "top"
			commonCommand(xPos,yPos);
		}

	}

}