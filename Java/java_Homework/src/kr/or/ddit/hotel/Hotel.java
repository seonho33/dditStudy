package kr.or.ddit.hotel;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

public class Hotel {
	
	private Map<Integer, People> HotelMap;								//다른 메소드들도 사용할 수 있도록 HotelMap이라는 이름의 주소만 선언
	private Scanner scanner;
	
	public Hotel() {
		HotelMap = new HashMap<Integer, People>();						//생성자 단계에서 new HashMap 타입의 HotelMap 힙메모리 생성
		scanner = new Scanner(System.in);
	}
	
	public static void main(String[] args) {
		new Hotel().HotelStart();
	}
	
	public void HotelStart() {
		System.out.println("*******************************************");
		System.out.println("             호텔 문을 열었습니다.");
		System.out.println("*******************************************");
		while(true) {
			int i;
			System.out.println("어떤 업무를 하시겠습니까?");
			System.out.println("1.체크인 2.체크아웃 3.객실상태 4.업무종료");
			try{i = scanner.nextInt();
			}catch(Exception e) {
				System.out.println("숫자만 입력해주십시오");
				scanner.nextLine();
				continue;
			}
			switch(i){
			case 1:
				chackIn();
				break;
			case 2:
				chackOut();
				break;
			case 3:
				dispalyAll();
				break;
			case 4:
				System.out.println("*******************************************");
				System.out.println("             호텔 문을 닫았습니다.");
				System.out.println("*******************************************");
				return;
				
			default :
			System.out.println("잘못입력하셨습니다 다시 입력해주십시오.");
			continue;
			}
		}
	}


	
	
	private void chackIn() {
		System.out.println("어느방에 체크인 하시겠습니까?");
		System.out.print("방번호 입력 >>");
			try{Integer key  = scanner.nextInt();
				if(HotelMap.get(key) != null) {
					System.out.println("예약된 방입니다.");
					return;}
				System.out.print("이름 입력 >>");
				scanner.nextLine();
				String name = scanner.nextLine();
				People p = new People(key,name);
				HotelMap.put(key, p);
				System.out.println("체크인 되었습니다.");
			}catch(Exception e) {
				System.out.println("숫자만 입력해 주십시오.");
				scanner.nextLine();
				return;
			}
	}	
	
	private void chackOut() {
		System.out.println("어느방을 체크아웃 하시겠습니까?");
		System.out.print("방번호 입력 >>");
		Integer key = scanner.nextInt();
		try {
			if(HotelMap.remove(key)==null) {
				System.out.println(key+"번 방에는 체크인한 사람이 없습니다.");
				return;
				}
			System.out.println("체크아웃 되었습니다.");
			}
		catch(Exception e) {
			System.out.println("숫자만 입력해 주십시오.");
			scanner.nextLine();
			return;
			}
		}

	private void dispalyAll() {
		Set<Integer> keySet = HotelMap.keySet();
		Iterator<Integer> itHotel = keySet.iterator();
		
		if(HotelMap.size()==0) {
			System.out.println("체크인 된 사람이 없습니다.");
		}else {
			while(itHotel.hasNext()) {
				Integer hot = itHotel.next();
				System.out.println("방번호 : " + hot + ", 투숙객 : " + HotelMap.get(hot));
			}
		}
	}
}
class People{
		private Integer key;
		private String name;
		
		public People(Integer key,String name) {
			this.key = key;
			this.name = name;
		}

		public Integer getKey() {
			return key;
		}

		public void setKey(Integer key) {
			this.key = key;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		@Override
		public String toString() {
			return name;
		}
}