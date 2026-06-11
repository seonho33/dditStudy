package java_Homework.src.태양계행성;

import java.util.Scanner;

public class Planet {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
	while(true) {
		try {
		System.out.println("행성의 이름을 적어주십시오");
		System.out.println("수성,금성,지구,화성,목성,토성,천왕성,해왕성...종료");
		String str = scanner.nextLine();
		
		if(str.equals("종료")) {
			System.out.println("종료합니다...");
			return;
		}
		
		PlanetRadius planet;
		
		planet = PlanetRadius.valueOf(str);
		
		System.out.println("=================================");
		System.out.println("행성의 표면적 4*PI*r^2");
		System.out.println(planet.name() + " : " + mathodA(planet));
		System.out.println("=================================");
		}catch(Exception e) {
			System.out.println("주어진 행성이름 혹은 종료만 입력해 주십시오...");
			continue;
		}
	}
}
	

public static long mathodA(PlanetRadius planet) {
	long i;
	
	i = (long) ((Math.round(4*Math.PI*planet.getRadius()*planet.getRadius())));
	
	return i;
	}
}

