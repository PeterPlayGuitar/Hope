package 
{
	import flash.display.Sprite;

	public class PlaceOfAttack extends Sprite
	{

		private var placeOfAttack:Sprite = new placeOfAttack_mc  ;
		private var placeOfShot:Sprite = new placeOfShot_mc  ;
		private var cell:Sprite;

		public function PlaceOfAttack(kindW)
		{
			if (kindW == 0)
			{
				cell = placeOfAttack;
			}
			else
			{
				cell = placeOfShot;
			}
			addChild(cell)

		}

	}

}