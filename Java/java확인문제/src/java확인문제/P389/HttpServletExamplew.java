package java확인문제.P389;

public class HttpServletExamplew {
	public static void main(String[] args) {
		method(new LoginServlet());
		method(new FileDownloadServlet());
	}
	public static void method(HttpServlet servlet) {
		servlet.service();
	}
}
