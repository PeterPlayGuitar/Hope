package 
{
	import flash.display.Sprite;

	public class Bit extends Sprite
	{
		public var directionX;
		public var directionY;
		public var bit;
		private var direct = 90;
		private var oscillation = 20;
		private var v = Math.random() * 0.5 + 0.3;
		private var a = 0;

		public function Bit(X,Y,kindB)
		{
			if (kindB == 0)
			{
				bit = new bit_mc  ;
			}
			else
			{
				bit = new bitCross_mc  ;
			}

			bit.x = X;
			bit.y = Y;
			bit.rotation = Math.random() * 360;
			addChild(bit);
		}
		public function updateDirect(val)
		{
			directionX *=  val;
			directionY *=  val;
		}
		public function efBit()
		{
			direct +=  fun1() * Math.random() * oscillation / 2;

			bit.y += v * -Math.sin(direct*Math.PI/180);
			bit.x += v * Math.cos(direct*Math.PI/180);
			a +=  0.01;
			bit.alpha = Math.abs(Math.sin(a));
		}
		private function fun1()
		{
			if (direct>120)
			{
				return -1;
			}
			else if (direct<60)
			{
				return 1;
			}
			else
			{
				return int(Math.random()*4-2);
			}
		}
		public function cleanBit()
		{
			removeChild(bit);
			bit = null;
		}
	}
}