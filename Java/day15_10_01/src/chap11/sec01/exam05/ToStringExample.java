package chap11.sec01.exam05;

import java.util.Date;

import chap11.sec01.exam02.Member;

public class ToStringExample {
	public static void main(String[] args) {
		Object obj1 = new Object();
		Date obj2 = new Date();
		
		Member member = new Member("도선호");
		
		System.out.println(obj1.toString());
		System.out.println(obj2.toString());
		System.out.println(member.toString());
	}
}