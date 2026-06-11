package kr.or.ddit.hotel;

import java.util.Comparator;
import java.util.List;
import java.util.Scanner;

import kr.or.ddit.hotel.service.HotelServiceImpl;
import kr.or.ddit.hotel.service.IHotelService;
import kr.or.ddit.hotel.vo.HotelVO;

public class HotelInfoMain {
	
	private Scanner scan;
	private IHotelService hotelService;
	
	public HotelInfoMain() {
		hotelService = HotelServiceImpl.getInstance();
		scan = new Scanner(System.in);
	}
	
	public static void main(String[] args) {
		new HotelInfoMain().HotelStart();
	}
	
	public void HotelStart() {
		//테이블이 존재하는지 확인하는 메서드와 없다면 생성하는 메서드..
		boolean isExist = hotelService.cheakTable();
		hotelService.createTable(isExist);
		
		System.out.println("*******************************************");
		System.out.println("             호텔 문을 열었습니다.");
		System.out.println("*******************************************");
		int choice;
		do {
			System.out.println("어떤 업무를 하시겠습니까?");
			System.out.println("1.체크인 2.체크아웃 3.검색 4.객실상태확인 5.업무종료");
			choice = scan.nextInt();
			switch(choice){
			case 1:
				checkIn();
				break;
			case 2:
				checkOut();
				break;
			case 3:
				searchHotel();
				break;
			case 4:
				dispalyAll();
				break;
			case 5:

				System.out.println("*******************************************");
				System.out.println("             호텔 문을 닫았습니다.");
				System.out.println("*******************************************");
				break;
				
			default :
			System.out.println("잘못입력하셨습니다 다시 입력해주십시오.");
			}
		}while(choice!=5);
	}


	
	private void checkIn() {
		boolean isExist;
		String hotelId="";
		do {
		System.out.println("어느방에 체크인 하시겠습니까?");
		System.out.print("방번호 입력 >>");
		hotelId = scan.next();
		isExist = hotelService.checkHotle(hotelId);
		if(isExist) {
			System.out.println(hotelId+"는 이미 예약된 방입니다.");
			System.out.println("다시 입력해주세요");
		}
		}while(isExist);
		System.out.print("이름 입력 >>");
		String hotelName = scan.next();
		
		/////////////////////////////////////
		
		HotelVO hv = new HotelVO(hotelId,hotelName);
		
		int cnt = hotelService.registerHotel(hv);
		if(cnt>0) {
			System.out.println(hotelId + " 체크인 했습니다.");
		}else {
			System.out.println(hotelId + " 체크인 실패했습니다.");
		}
		
	}	
	
	private void checkOut() {
		
		System.out.println("어느방을 체크아웃 하시겠습니까?");
		System.out.print("방번호 입력 >>");
		String hotelId = scan.next();
		
		int cnt = hotelService.removeHotel(hotelId);
		if(cnt>0) {
			System.out.println(hotelId + " 체크아웃 했습니다.");
		}else {
			System.out.println(hotelId + " 체크아웃 실패했습니다.");
		}
	}

	private void searchHotel() {
		scan.nextLine();
		System.out.println();
		System.out.println("검색할 객실번호를 입력해주세요");
		System.out.print("객실번호 >>");
		String hotelId = scan.nextLine().trim();
		System.out.print("투숙객 이름 >>");
		String hotelName = scan.nextLine().trim();
		
		HotelVO hv = new HotelVO(hotelId,hotelName);
		
		List<HotelVO> hotelList = hotelService.searchHotel(hv);
		
		System.out.println();
		System.out.println("----------------------------");
		System.out.println(" 객실번호\t투숙객\t체크인날짜");
		System.out.println("----------------------------");
		
		if(hotelList.size()==0) {
			System.out.println("조회된 정보가 없습니다.");
		}else {
			for(HotelVO hv2 : hotelList) {
				System.out.println(hv2.getHotelId()+"\t"+hv2.getHotelName()+"\t"+hv2.getRegDt());
			}
		}
		System.out.println("-------------------------------");
		System.out.println("검색정보 조회완료");
	}
	
	private void dispalyAll() {
		System.out.println();
		System.out.println("----------------------------");
		System.out.println(" 객실번호\t투숙객\t체크인날짜");
		System.out.println("----------------------------");
		
		List<HotelVO> hotelList = hotelService.displayAllHotel();
		
		if(hotelList.size()==0) {
			System.out.println("조회된 객실정보가 없습니다...");
		}else {
			for(HotelVO hv : hotelList) {
				System.out.println(hv.getHotelId() + "\t" + hv.getHotelName() + "\t" + hv.getRegDt());
			}
		}
		System.out.println("---------------------------");
		System.out.println("전체 객실정보 조회완료....");
	}
}

class HotelDesc implements Comparator<Integer>{

	@Override
	public int compare(Integer o1, Integer o2) {
		
		return 0;
	}
	
}