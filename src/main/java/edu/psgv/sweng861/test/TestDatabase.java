package edu.psgv.sweng861.test;

import java.sql.Connection;
import java.sql.DriverManager;


public class TestDatabase {

	public static void main (String args[]) {
		
//		String link = "jdbc:mysql://localhost:3306/mydb";
		
		String link = "jdbc:sqlserver://localhost:1433;databaseName=SongDB";
		
		String name = "song";
		
		String pw = "song";
		
		try {
		
			Connection con = DriverManager.getConnection(link, name, pw);
			
			System.out.println("done");
			
			con.close();
			
		} catch(Exception e) {
			
			System.err.println("Error!!!");
			e.printStackTrace();
		}
	}
}
