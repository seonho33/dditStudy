package 숫자야구;

import java.util.Arrays;
import java.util.Scanner;

public class NumberBaseball {
	public static void main(String[] args) {
	
	Scanner scanner = new Scanner(System.in);	
	int t = 0; 						//시도 횟수
	int[] comNum = new int[4]; 		//컴퓨터가 정한 숫자
	int[] playerNum = new int[4]; 	//플레이어가 적는 숫자
	
	for(int i=0;i<comNum.length;i++) {   	//컴퓨터가 중복된 숫자를 입력했나 확인하는 단계
		comNum[i]=(int)(Math.random()*10);
		for(int j=0;j<i;j++) {
			while(true) {
				if(comNum[j]==comNum[i]) {
					comNum[j]=(int)(Math.random()*10); //0~9까지의 숫자...중복되면 다시뽑기
				}else{
					break;}
			}
		}
	}
	

	Outter : while(true) {		//게임 시작(게임 끝날때까지 반복)
		int b= 0;
		int s= 0;
	try {
	System.out.println(" 중복되지 않은 숫자 4자리를 입력하십시오.(0~9)");
	playerNum[0]=scanner.nextInt();
	playerNum[1]=scanner.nextInt();
	playerNum[2]=scanner.nextInt();
	playerNum[3]=scanner.nextInt();
		}catch(Exception e) {
		scanner.nextLine();
		continue;
	}
	for(int i=0;i<playerNum.length;i++) {
		for(int j=0;j<i;j++) {
			if(playerNum[j]==playerNum[i]||playerNum[j]>9||playerNum[j]<0) {
				System.out.println("다시 입력하십시오."); //플레이어가 중복된 숫자를 입력했나 확인하는 단계
				continue Outter;
			}
		}
	}
	
	for(int i=0;i<playerNum.length;i++) {
		for(int j=0;j<comNum.length;j++) {
			if(playerNum[i]==comNum[j]) {
				b++;								//정답과 같은 숫자가 있으면 b++
				if(playerNum[j]==comNum[j]) {
					s++;
												//위치까지 같으면 s++
				}
			}
		}
	}
	
	System.out.println(s+"스트라이크, "+(b-s)+"볼");
	
	if(s==4) {
		break;
	}
	t++;
		}
	System.out.println("===정답입니다===");
	System.out.println(Arrays.toString(comNum));
	System.out.println((t+1)+"번만에 성공하셨습니다.");
	scanner.close();
	}
}