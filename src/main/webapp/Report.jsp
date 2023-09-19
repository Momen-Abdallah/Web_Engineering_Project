<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: momen
  Date: 5/19/2023
  Time: 11:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report a Violation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        h1 {
            text-align: center;
            margin-top: 0;
            margin-bottom: 30px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            font-weight: bold;
            margin-bottom: 10px;
        }
        input[type="text"],
        select {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: none;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        }
        input[type="file"] {
            margin-bottom: 20px;
        }
        button[type="submit"] {
            padding: 10px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color: #3e8e41;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Report a Violation</h1>

    <form  action="/Report.jsp" method="post">
        <label for="country">Select a country:</label>
        <select id="country" name="country2">
            <option value="">--Please choose a country--</option>

            <%
                // Connect to the database
                Class.forName("org.sqlite.JDBC").getDeclaredConstructor().newInstance();
                Connection conn = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\momen\\IdeaProjects\\Web_Engineering_Project\\db.sqlite");

                // Get the list of countries from the City table
                PreparedStatement stmt = conn.prepareStatement("SELECT DISTINCT country FROM City");
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    String country = rs.getString("country");
            %>
            <option value="<%= country %>" <% if (request.getParameter("country2") != null && request.getParameter("country2").equals(country)) { %>selected<% } %>><%= country %></option>
            <%
                }
                // Close the database connection
                conn.close();
            %>
        </select>
        <button type="submit" name="button" class="submit">Select Country</button>
        <br><br>
    </form>

    <%if (request.getParameter("country2") != null) { %>
    <form action="/controller" method="post" enctype="multipart/form-data">
        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phone" required>
        <%
                String selectedCountry = request.getParameter("country2");
                // Connect to the database
                Connection conn2 = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\momen\\IdeaProjects\\Web_Engineering_Project\\db.sqlite");
                // Get the list of cities for the selected country
                PreparedStatement stmt2 = conn2.prepareStatement("SELECT name FROM City WHERE country = ?");
                stmt2.setString(1, selectedCountry);
                ResultSet rs2 = stmt2.executeQuery();
        %>
        <label for="city">Select a city:</label>
        <select id="city" name="city">
            <option value="">--Please choose a city--</option>
            <% while (rs2.next()) { %>
            <option value="<%= rs2.getString("name") %>"><%= rs2.getString("name") %></option>
            <% } %>
        </select>

        <label for="violation">Type of Violation:</label>
        <select id="violation" name="violation" required>
            <option value="">Select a violation</option>
            <option value="Red light crossing">Red light crossing</option>
            <option value="Running a stop sign">Running a stop sign</option>
            <option value="Jaywalking">Jaywalking</option>
            <option value="Littering">Littering</option>
        </select>
        <label for="media">Upload a Picture/Video:</label>

        <input type="file" id="media" name="media" accept="image/*,video/*" required>
        <button type="submit" name="button" value="submitReport" >Submit Report</button>
    </form>

    <%
            conn2.close();
        }
    %>
</div>
</body>
</html>
