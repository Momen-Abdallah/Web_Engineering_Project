<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List of Countries and Cities</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        h1 {
            text-align: center;
            margin-top: 50px;
            margin-bottom: 30px;
        }

        .main {
            max-width: 500px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        select {
            display: block;
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: none;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            background-color: #f2f2f2;
            color: #333;
            font-size: 16px;
            font-weight: bold;
        }

        option {
            font-weight: normal;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .button-container button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .button-container button.submit {
            background-color: #4CAF50;
            color: #fff;
        }

        button.submit {
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button.submit:hover {
            background-color: #3e8e41;
        }
    </style>
</head>
<body>
<h1>List of Countries and Cities</h1>

<div class="main">

    <form action="/controller" method="post">
        <div class="button-container">
            <button class="report" type="submit" name="button" value="ReportPage">Report</button>
            <button class="admin" type="submit" name="button" value="AdminLogin">Admin Login</button>
        </div>
    </form>

    <form action="index.jsp">
        <label for="country">Select a country:</label>
        <select id="country" name="country">
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
            <option value="<%= country %>"
                    <% if (request.getParameter("country") != null && request.getParameter("country").equals(country)) { %>selected<% } %>><%= country %>
            </option>
            <%
                }
                // Close the database connection
                conn.close();
            %>
        </select>
        <button type="submit" name="button" value="Submit-Country" class="submit">Select Country</button>
        <br><br>
    </form>

    <% if (request.getParameter("country") != null) {%>
    <form action="/controller" method="post">


        <%
            String selectedCountry = request.getParameter("country");
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
            <option value="<%= rs2.getString("name") %>"><%= rs2.getString("name") %>
            </option>
            <% } %>
        </select>
        <button type="submit" name="button" value="Submit-City" class="submit">Submit City</button>
    </form>
    <%
            // Close the database connection
            conn2.close();
        }
    %>
</div>
</body>
</html>