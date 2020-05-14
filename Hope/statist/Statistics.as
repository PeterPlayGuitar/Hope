package statist
{
	public class Statistics
	{
		private var size:int = 9;
		public var stat:Array = new Array(2);
		public var dayGame:int = 0;

		public function Statistics()
		{
			stat[0] = new Array(size);
			stat[1] = new Array(size);
			for (var i = 0; i<2; i++)
			{
				for (var m = 0; m<size; m++)
				{
					stat[i][m] = 0;
				}
			}
		}
		public function addS(side:int,num:int,colvo:int)
		{
			stat[side][num] +=  colvo;
		}
		public function nextDay()
		{
			dayGame++;
		}
	}
}
//0 - колво убийств'done'
//1 - колво сделанных ходов'done'
//2 - колво отнятых жизней'done'
//3 - колво ударов мечников'done'
//4 - колво выстрелов'done'
//5 - колво умерших солдат'done'
//6 - колво построенных воинов'done'
//7 - колво построенных лучников'done'
//8 - колво заработанных денег на убийствах'done'
//9 - колво критических ударов'done'