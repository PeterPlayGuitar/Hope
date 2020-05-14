package gemeSet
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ChoiseStyle extends Sprite
	{

		private var choiseStyle = new choiseStyle_mc  ;
		private var choisedNum:int = Main.da.style_d;
		private var changedScale:Boolean = false;

		public function ChoiseStyle()
		{
			choiseStyle.x = 100;
			choiseStyle.y = 100;
			choiseStyle.gotoAndStop(choisedNum);
			addChild(choiseStyle);
			choiseStyle.addEventListener(MouseEvent.CLICK,mc);
			choiseStyle.addEventListener(MouseEvent.MOUSE_DOWN,m_down);
			choiseStyle.addEventListener(MouseEvent.MOUSE_UP,m_up);
			choiseStyle.addEventListener(MouseEvent.MOUSE_OUT,m_out);
		}
		private function mc(e:MouseEvent)
		{
			choisedNum++;
			if (choisedNum>Main.da.colvoStyles_d)
			{
				choisedNum = 1;
			}
			choiseStyle.gotoAndStop(choisedNum);
		}
		private function m_down(e:MouseEvent)
		{
			choiseStyle.scaleX = 0.9;
			choiseStyle.scaleY = 0.9;
			changedScale = true;
		}
		private function m_up(e:MouseEvent)
		{
			choiseStyle.scaleX = 1;
			choiseStyle.scaleY = 1;
			changedScale = false;
		}
		private function m_out(e:MouseEvent)
		{
			if (changedScale)
			{
				choiseStyle.scaleX = 1;
				choiseStyle.scaleY = 1;
				changedScale = false;
			}
		}
		public function cleanChoiseStyle()
		{
			Main.da.style_d = choisedNum;

			choiseStyle.removeEventListener(MouseEvent.MOUSE_DOWN,m_down);
			choiseStyle.removeEventListener(MouseEvent.MOUSE_UP,m_up);
			choiseStyle.removeEventListener(MouseEvent.CLICK,mc);
			choiseStyle.removeEventListener(MouseEvent.MOUSE_OUT,m_out);
			removeChild(choiseStyle);
			choiseStyle = null;
		}
	}
}