package java_Homework.src.태양계행성;

public enum PlanetRadius {
	수성(2439),
	금성(6052),
	지구(6371),
	화성(3390),
	목성(69911),
	토성(58232),
	천왕성(25362),
	해왕성(24622);

	private int radius;
	PlanetRadius(int radius){
		this.radius = radius;
	}
	public int getRadius() {
		return radius;
	}
}