package kr.or.ddit.basic;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.StringTokenizer;

public class MultiChatServer {
	private Map<String, Socket> clients;
	
	public MultiChatServer() {
		//동기화 처리가 가능하도록 Map객체 생성하기
		clients = Collections.synchronizedMap(new HashMap<String, Socket>());
	}
	
	public void start() throws IOException {

		Socket socket = null;
		try(ServerSocket server = new ServerSocket(7777);){
			while(true) {
				//클라이언트의 접속을 대기한다.
				socket = server.accept();
				
				System.out.println("[" + socket.getInetAddress() + ":" + socket.getPort()+
									"] 에서 접속했습니다.");
				//사용자가 보내준 메시지를 받아 처리하기 위한 스레드 생성 및 실행
				ServerReceiver thread = new ServerReceiver(socket);
				thread.start();
			}
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 서버에서 클라이언트로부터 수신한 메시지를 처리하기 위한 스레드
	// 중첩클래스로 정의(내부 클래스에서는 바깥클래스의 멤버들을 직접 접근할 수 있음)
	class ServerReceiver extends Thread {
		private Socket socket;
		private DataInputStream dis;
		private String name;
		
		public ServerReceiver(Socket socket) {
			this.socket = socket;
			
			try {
				dis = new DataInputStream(socket.getInputStream());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		@Override
		public void run() {

			try {
				//서버에서는 클라이언트가 보내주는 최초의 메시지 즉, 대화명을
				//수신해야 한다.
				name = dis.readUTF();
				
				//대화명을 받아서 다른 모든 접속한 클라이언트에게 대화방 참여
				//메시지를 보낸다.
				sendMessage("#" + name + "님이 입장했습니다.");
				
				// 대화명과 소켓정보를 Map에 저장한다.
				clients.put(name, socket);
				
				System.out.println("현재 서버 접속자 수는 " + clients.size() + "명 입니다.");
				
				//이 이후의 메시지는 채팅 메시지로 처리한다.
				while(dis != null) {
					//채팅 메시지 보내기
					sendMessage(dis.readUTF(),name);
				}
				
			}catch (IOException e) {
				e.printStackTrace();
			}finally{
				// 이 부분이 실행되는 경우는 클라이언트의 접속에 문제가 발생한
				// 경우이므로 Map에서 제거한다...
				sendMessage("#" + name + "님이 나가셨습니다.");
				
				//Map에서 해당 사용자 제거하기
				clients.remove(name);
				
				System.out.println("[" + socket.getInetAddress() + ":" + socket.getPort()+
						"] 에서 종료했습니다.");
				
				System.out.println("현재 서버 접속자 수는 " + clients.size() + "명 입니다.");
			}
		}
		
		
		/**
		 * 대화방 즉, Map에 저장된 모든 사용자에게 채팅메시지를 전송한다
		 * @param msg 채팅메시지
		 * @param from 보내는 사람 대화명
		 */
		private void sendMessage(String msg, String from) {

			  if(msg.toLowerCase().startsWith("/w ")) {
				  StringTokenizer msgToken = new StringTokenizer(msg," ");
				  msgToken.nextToken();
				  String nameToken = msgToken.nextToken();
				  String contentToken= "";
				  while(msgToken.hasMoreTokens()) {
					  contentToken += msgToken.nextToken()+" " ;
				  }
				  Socket socket = clients.get(nameToken);
				  if(socket == null) {
					  socket = clients.get(from);
					  try {
					  DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
						dos.writeUTF("존재하지 않는 사용자입니다.");
						return;
					} catch (IOException e) {
						e.printStackTrace();
					}
				  }
				  String str = ("["+from+"]>>["+ nameToken +"] : "+contentToken);
			  try {
			  DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
			  dos.writeUTF(str);
			  socket = clients.get(from);
			  dos = new DataOutputStream(socket.getOutputStream());
			  dos.writeUTF(str);
			  } catch (IOException e) { 
				  e.printStackTrace(); 
				}
			  }else {
			sendMessage("[" + from + "]" + msg);
			}
		}
		/**
		 * 대화방 즉, Map에 저장된 모든 사용자에게 안내 메시지를 전송한다.
		 * @param msg 전송할 안내 메시지
		 */
		private void sendMessage(String msg) {
			Iterator<String> it = clients.keySet().iterator();
			while(it.hasNext()) {
				String name = it.next();	//대화명(key값) 가져오기
				Socket socket = clients.get(name);
				
				try {
					DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
					
					dos.writeUTF(msg);	//안내메시지 전송하기...
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
//		private void sendMessage()
	}
	
	public static void main(String[] args) throws IOException {
		new MultiChatServer().start();
	}
}
