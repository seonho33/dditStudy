package 다형성게임실행기;

public class Game {
	public static void main(String[] args) {
		
		GameInterface game;
		
		switch(GameSetting.GameSelect()) {
		case 1:
			game = new OddEvenGame();
			game.GameBlock();
			game.GameExit();
			break;
		case 2:
			game = new DiceGame();
			game.GameBlock();
			game.GameExit();
			break;
		case 3:
			game = new RookPaperScissorsGame();
			game.GameBlock();
			game.GameExit();
		}
	}
}
