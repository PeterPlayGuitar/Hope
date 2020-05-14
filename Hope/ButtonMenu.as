package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class ButtonMenu extends Sprite
	{

		private var grafObj:Sprite;
		private var numer;
		private var maxScale = 1.05;
		private var speedOfChangeSize = 0.01;
		private var upsize:Boolean = false;

		private var timeOfAppear = 0;
		private var appearB:Boolean = true;

		public function ButtonMenu(num)
		{
			numer = num;
			addGrafObject(numer);
			grafObj.alpha = 0;
			addChild(grafObj);
			grafObj.addEventListener(MouseEvent.CLICK,onClick);
			grafObj.addEventListener(MouseEvent.MOUSE_OVER,m_over);
			grafObj.addEventListener(MouseEvent.MOUSE_OUT,m_out);
		}
		private function onClick(e:MouseEvent)
		{
			Main.removeClass(2);
			Main.addClass(numer);
		}
		private function m_over(e:MouseEvent)
		{
			upsize = true;
		}
		private function m_out(e:MouseEvent)
		{
			upsize = false;
		}
		public function ef()
		{
			if (upsize)
			{
				if (grafObj.scaleX < maxScale)
				{
					grafObj.scaleX +=  speedOfChangeSize;
					grafObj.scaleY = grafObj.scaleX;
				}
			}
			else
			{
				if (grafObj.scaleX > 1)
				{
					grafObj.scaleX -=  speedOfChangeSize;
					grafObj.scaleY = grafObj.scaleX;
				}
			}
			//********** APPEAR**************_begin
			if (appearB)
			{
				grafObj.alpha = Math.sin(timeOfAppear);

				timeOfAppear +=  0.01;
				if (timeOfAppear >= Math.PI/2)
				{
					timeOfAppear = 0;
					grafObj.alpha = 1;
					appearB = false;
				}
			}
			//********** APPEAR**************_end
		}
		private function addGrafObject(num)
		{
			if (num == 3)
			{
				grafObj = new button1_mc  ;
			}
			else if (num == 1)
			{
				grafObj = new button2_mc  ;
			}
			else if (num == 4)
			{
				grafObj = new button3_mc  ;
			}
		}
		public function dellEvents()
		{
			grafObj.removeEventListener(MouseEvent.CLICK,onClick);
			grafObj.removeEventListener(MouseEvent.MOUSE_OVER,m_over);
			grafObj.removeEventListener(MouseEvent.MOUSE_OUT,m_out);
		}
	}
}