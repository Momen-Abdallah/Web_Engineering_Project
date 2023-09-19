<%--
  Created by IntelliJ IDEA.
  User: momen
  Date: 5/19/2023
  Time: 11:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>City Information</title>
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
        .info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .info label {
            font-weight: bold;
            width: 100px;
        }
        .info span {
            font-weight: normal;
        }
        .info .icon {
            font-size: 24px;
            margin-right: 10px;
        }
        .info .icon.safe {
            color: #4CAF50;
        }
        .info .icon.clean {
            color: #2196F3;
        }
        .info .icon.sane {
            color: #f44336;
        }
    </style>
</head>
<body>
<jsp:useBean id="city" class="com.example.web_engineering_project.models.City" scope="request"/>

<div class="container">
    <h1>City Information</h1>
    <% if (city != null && city.getName() != null) { %>
    <div class="info">
        <label>Name:</label>
        <span><%= city.getName() %></span>
    </div>
    <div class="info">
        <label>Safety:</label>
        <span><i class="icon safe fa fa-check-circle"></i><%= city.isSafe() ? "Safe" : "Dangerous" %></span>
    </div>
    <div class="info">
        <label>Cleanliness:</label>
        <span><i class="icon clean fa fa-check-circle"></i><%= city.isClean() ? "Clean" : "Dirty" %></span>
    </div>
    <div class="info">
        <label>Sanity:</label>
        <span><i class="icon sane fa fa-check-circle"></i><%= city.isSane() ? "Sane" : "Insane" %></span>
    </div>
    <% } else { %>
    <h2>No city found with that name</h2>
    <% } %>
</div>
<script src="https://kit.fontawesome.com/your-font-awesome-kit.js" crossorigin="anonymous"></script>
</body>
</html>
