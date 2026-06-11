package kr.or.ddit.basic;

import java.util.Scanner;

public class cc {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String a = sc.next();
	        
	        char[] c = a.toCharArray();

	        for(int i=0;i<c.length;i++){
	            if(Character.isUpperCase(c[i])){
	            	System.out.println(c[0]);
	            }else{
	        }
	    }
	}
}
