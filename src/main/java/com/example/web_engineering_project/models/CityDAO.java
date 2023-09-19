package com.example.web_engineering_project.models;

import jakarta.servlet.RequestDispatcher;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class CityDAO {
    public CityDAO() {
        try {
            Class.forName("org.sqlite.JDBC").getDeclaredConstructor().newInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public City getCityData(String name) throws SQLException {
        try {
            Class.forName("org.sqlite.JDBC").getDeclaredConstructor().newInstance();
            Connection connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\momen\\IdeaProjects\\Web_Engineering_Project\\db.sqlite");
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\momen\\IdeaProjects\\Web_Engineering_Project\\db.sqlite");
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * from City where name = ?");
            preparedStatement.setString(1, name);
            var cursor = preparedStatement.executeQuery();
            City city = new City();
            city.setName(name);
            city.setSafe(cursor.getBoolean("safe"));
            city.setClean(cursor.getBoolean("clean"));
            city.setSane(cursor.getBoolean("sane"));
            connection.close();
            return city;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public void getAllCountries() throws SQLException {
        try {
            Class.forName("org.sqlite.JDBC").getDeclaredConstructor().newInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Connection connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\momen\\IdeaProjects\\Web_Engineering_Project\\db.sqlite");
        connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\momen\\IdeaProjects\\Web_Engineering_Project\\db.sqlite");
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT country from City");
//        preparedStatement.setString(1, name);

        var cursor = preparedStatement.executeQuery();

        connection.close();
    }

}
