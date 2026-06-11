package aaaa;
import java.util.Random;
import java.util.Scanner;

public class aaa {
	    public static void main(String[] args) {
	        Scanner scanner = new Scanner(System.in);
	        Random random = new Random();

	        String[] choices = {"가위", "바위", "보"};

	        System.out.println("=== 숫자로 하는 가위바위보 게임 ===");
	        System.out.println("1: 가위 | 2: 바위 | 3: 보");
	        System.out.println("종료하려면 0을 입력하세요.");

	        while (true) {
	            System.out.print("선택 (1~3): ");
	            int userInput = scanner.nextInt();

	            // 종료 조건
	            if (userInput == 0) {
	                System.out.println("게임을 종료합니다.");
	                break;
	            }

	            // 입력 체크
	            if (userInput < 1 || userInput > 3) {
	                System.out.println("잘못된 입력입니다. 1~3 사이의 숫자를 입력하세요.");
	                continue;
	            }

	            // 컴퓨터 선택
	            int computerInput = random.nextInt(3) + 1;

	            System.out.println("당신 선택: " + choices[userInput - 1]);
	            System.out.println("컴퓨터 선택: " + choices[computerInput - 1]);

	            // 승패 판단
	            if (userInput == computerInput) {
	                System.out.println("무승부!");
	            } else if (
	                (userInput == 1 && computerInput == 3) || // 가위 > 보
	                (userInput == 2 && computerInput == 1) || // 바위 > 가위
	                (userInput == 3 && computerInput == 2)    // 보 > 바위
	            ) {
	                System.out.println("당신이 이겼습니다!");
	            } else {
	                System.out.println("컴퓨터가 이겼습니다!");
	            }

	            System.out.println("----------------------");
	        }

	        scanner.close();
	    }
	}

