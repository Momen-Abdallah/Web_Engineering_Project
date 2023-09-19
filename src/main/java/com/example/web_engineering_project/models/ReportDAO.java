package com.example.web_engineering_project.models;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

public class ReportDAO {
    public ArrayList<Report> getInProgressReports() {

        ArrayList<Report> reports = new ArrayList<>();
        try {
            Class.forName("org.sqlite.JDBC").getDeclaredConstructor().newInstance();
            Connection connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\momen\\IdeaProjects\\Web_Engineering_Project\\db.sqlite");
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * from Report where state = ?");
            preparedStatement.setString(1, "inProgress");
            var cursor = preparedStatement.executeQuery();
            while (cursor.next()) {
                reports.add(new Report(cursor.getInt("id"), cursor.getString("date"), cursor.getString("phone"), cursor.getString("city"), cursor.getString("violation"), cursor.getBinaryStream("media"), cursor.getString("state")));
            }
            cursor.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }


        return reports;
    }

    public void setState(int id, String state) throws SQLException {
        try {
            Class.forName("org.sqlite.JDBC").getDeclaredConstructor().newInstance();
            Connection connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\momen\\IdeaProjects\\Web_Engineering_Project\\db.sqlite");
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE Report SET state = ? WHERE id = ?;");
            preparedStatement.setString(1, state);
            preparedStatement.setInt(2, id);
            preparedStatement.executeUpdate();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    public void insertReport(Report report) {
        try {
            Class.forName("org.sqlite.JDBC").getDeclaredConstructor().newInstance();
            Connection connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\momen\\IdeaProjects\\Web_Engineering_Project\\db.sqlite");
            PreparedStatement preparedStatement2 = connection.prepareStatement("INSERT INTO Report VALUES (?,?,?,?,?,?,?)");
            preparedStatement2.setString(2, LocalDate.now().toString());
            preparedStatement2.setString(3, report.getPhone());
            preparedStatement2.setString(4, report.getCity());
            preparedStatement2.setString(5, report.getViolation());
            InputStream inputStream = report.getMedia();
            preparedStatement2.setBinaryStream(6, inputStream, inputStream.available());
            preparedStatement2.setString(7, "inProgress");
            preparedStatement2.executeUpdate();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Boolean isUserBlocked(String phone) throws SQLException {
        try {
            Class.forName("org.sqlite.JDBC").getDeclaredConstructor().newInstance();
            Connection connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\momen\\IdeaProjects\\Web_Engineering_Project\\db.sqlite");

            connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\momen\\IdeaProjects\\Web_Engineering_Project\\db.sqlite");

            PreparedStatement preparedStatement = connection.prepareStatement("select * from BlockedUser where phone = ?");
            preparedStatement.setString(1, phone);

            var cursor = preparedStatement.executeQuery();

            connection.close();

            return cursor.next();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
