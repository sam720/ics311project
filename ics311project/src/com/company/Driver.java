package com.company;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Driver {
    public static void main(String args[]) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql//localhost/ics311project?user=root&password=ics311");
            System.out.println("Connection Object Created: " + con);
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from game");
            while (rs.next()) {
                System.out.println(rs.getString("game_id"));
            }
            st.close();
            rs.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }


    }
}
