package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;

	public class Figure extends Sprite
	{
		private var grafH = new figureHealth_mc  ;
		private var grafM = new figureHealth_mc  ;
		private var duringHealth:Boolean = false;
		private var duringMoney:Boolean = false;
		private var time = 100;
		private var ct:ColorTransform = new ColorTransform();
		private var beginV:Number = 0.5;
		private var v:Number = beginV;

		public function seregaDavayM(X:int,Y:int,money:int)
		{
			if (! duringMoney)
			{
				grafM.x = X * 50 + 25;
				grafM.y = Y * 50 - 20;

				ct.color = 0xFFE738;
				grafM.health.transform.colorTransform = ct;

				grafM.health.text = "+" + money;
				Main.plan1.addChild(grafM);

				if (! duringHealth)
				{
					addEventListener(Event.ENTER_FRAME,ef);
				}
				duringMoney = true;
			}
		}

		public function seregaDavayH(X:int,Y:int,power:int)
		{
			if (! duringHealth)
			{
				if (power>0)
				{
					ct.color = 0x92FF00;
					grafH.health.text = "+" + power;
				}
				else
				{
					ct.color = 0xFF5700;
					grafH.health.text = power;
				}

				grafH.health.transform.colorTransform = ct;

				Main.plan1.addChild(grafH);
				grafH.x = X * 50 + 25;
				grafH.y = Y * 50 - 20;

				if (! duringMoney)
				{
					addEventListener(Event.ENTER_FRAME,ef);
				}
				duringHealth = true;
			}
		}
		private function ef(e:Event)
		{
			if (time > 0)
			{
				time--;
				if (duringHealth)
				{
					grafH.y -=  v;
					grafH.scaleX = Math.sin(Math.PI * (1 - time / 99)) * 0.2 + 0.8;
					grafH.scaleY = grafH.scaleX;
					if (time<=15)
					{
						grafH.alpha -=  1 / 14;
					}
				}
				if (duringMoney)
				{
					grafM.y -=  v;
					grafM.scaleX = Math.sin(Math.PI * (1 - time / 99)) * 0.2 + 0.8;
					grafM.scaleY = grafM.scaleX;
					if (time<=15)
					{
						grafM.alpha -=  1 / 15;
					}
				}
				v = beginV * time / 100;
			}
			else
			{
				if (duringHealth)
				{
					duringHealth = false;
					Main.plan1.removeChild(grafH);
				}
				if (duringMoney)
				{
					duringMoney = false;
					Main.plan1.removeChild(grafM);
				}
				if (duringHealth == false && duringMoney == false)
				{
					removeEventListener(Event.ENTER_FRAME,ef);
					v = beginV;
					time = 100;
					grafH.alpha = 1;
					grafM.alpha = 1;
					grafH.scaleX = 1;
					grafH.scaleY = 1;
					grafM.scaleX = 1;
					grafM.scaleY = 1;
				}
			}
		}
	}
}