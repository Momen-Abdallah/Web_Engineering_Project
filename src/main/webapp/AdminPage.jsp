<%@ page import="com.example.web_engineering_project.models.Report" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.print.attribute.standard.Media" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.Base64" %>
<%@ page import="org.apache.tika.Tika" %><%--
  Created by IntelliJ IDEA.
  User: momen
  Date: 5/20/2023
  Time: 11:32 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        .report {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .media {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 20px;
        }

        .info {
            flex: 1;
        }

        .info h1 {
            font-size: 18px;
            margin: 0 0 10px;
        }

        .info p {
            margin: 0;
        }

        .button-container {
            margin-top: 20px;
        }

        .button-container input[type="submit"] {
            margin-right: 10px;
            padding: 10px 20px;
            font-size: 16px;
        }

        .large {
            width: 80%;
            height: 80%;
        }
    </style>
</head>
<jsp:useBean id="reportList" type="java.util.ArrayList" scope="request"/>
<body>

<%
    ArrayList<Report> list = reportList;
  if (!list.isEmpty()){
    for (int i = 0; i < list.size(); i++) {
        InputStream inputStream = list.get(i).getMedia();
        byte[] bytes = inputStream.readAllBytes();

        Tika tika = new Tika();
        String contentType = tika.detect(bytes);

        String base64 = Base64.getEncoder().encodeToString(bytes);
        String dataUri = "data:" + contentType + ";base64," + base64;
%>
<form action="/controller" method="post">
    <div class="report">
        <% if (contentType.startsWith("image/")) { %>
        <img class="media" src="<%=dataUri%>">
        <% } else //if (contentType.startsWith("video/"))
        { %>
        <video class="media" width="320" height="240" controls>
            <source src="<%=dataUri%>" type="<%=contentType%>">
        </video>
        <% } %>

        <div class="info">
            <h1>Date: <%=list.get(i).getDate()%>
            </h1>
            <p>Phone: <%=list.get(i).getPhone()%>
            </p>
            <p>City: <%=list.get(i).getCity()%>
            </p>
            <p>Violation: <%=list.get(i).getViolation()%>
            </p>
            <p>State: <%=list.get(i).getState()%>
            </p>
            <div class="button-container">
                <input type="hidden" name="id" value="<%=list.get(i).getId()%>">
                <input type="submit" name="button" value="Approve">
                <input type="submit" name="button" value="Disapprove">
            </div>
        </div>

    </div>


</form>
<% }
} else{
%>
<h1>No Reports</h1>
<%
}
%>


<script>
    // Get all media elements on the page
    const mediaElements = document.querySelectorAll('.media');

    // Add a click event listener to each media element
    mediaElements.forEach(media => {
        media.addEventListener('click', () => {
            // Toggle the size of the media element
            if (media.classList.contains('large')) {
                media.classList.remove('large');
            } else {
                media.classList.add('large');
            }
        });

        // Add a transitionend event listener to each media element
        media.addEventListener('transitionend', () => {
            // Remove the large class after the transition ends
            media.classList.remove('large');
        });
    });
</script>
</body>
</html>
