package valey
{

	public class Cast extends Common
	{

		public function Cast(xPos:int,yPos:int)
		{
			//busy = false;
			grafObject = new cast_mc  ;
			protection = Main.da.protectCast_d
			stepsForMove = Main.da.minusEnergyForReplaceCast_d
			that = "cast";
			commonCommand(xPos,yPos);
			
		}

	}

}