package valey
{
	import flash.display.Sprite;

	public class Common extends Sprite
	{

		public var protection:Number;
		public var stepsForMove:Number;
		public var grafObject;
		public var that:String;
		public var sideBusy:int = 2;

		public function commonCommand(xPos:int,yPos:int)
		{
			grafObject.x = xPos * 50;
			grafObject.y = yPos * 50;
			setFrame();
			addChild(grafObject);
		}
		public function setGrafLawn()
		{
			var X = grafObject.x;
			var Y = grafObject.y;
			removeChild(grafObject);
			grafObject = null;
			grafObject = new lawn_mc  ;
			setFrame();
			grafObject.x = X;
			grafObject.y = Y;
			addChild(grafObject);
			protection = Main.da.protectLawn_d;
			stepsForMove = Main.da.minusEnergyForReplaceLawn_d;
			that = "lawn";
		}
		public function setFrame()
		{
			if (Main.game.style == 1)
			{
				grafObject.gotoAndStop(1);
			}
			if (Main.game.style == 2)
			{
				grafObject.gotoAndStop(int(Math.random()*2+2));
			}
			if (Main.game.style == 3)
			{
				if (that == "lawn")
				{
					grafObject.gotoAndStop(int(Math.random()*4+4));
				}
				else
				{
					grafObject.gotoAndStop(int(Math.random()*2+4));
				}
			}
		}
		public function cleanValey()
		{
			removeChild(grafObject);
			grafObject = null;
		}

	}

}