package com.example.web_engineering_project.servlets;

import java.io.*;
import java.sql.SQLException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.example.web_engineering_project.models.City;
import com.example.web_engineering_project.models.CityDAO;
import com.example.web_engineering_project.models.Report;
import com.example.web_engineering_project.models.ReportDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.jboss.weld.executor.FixedThreadPoolExecutorServices;

@MultipartConfig()
@WebServlet("/controller")
public class Controller extends HttpServlet {

    public void init() {

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");

        //1
        if (req.getParameter("button")!= null && req.getParameter("button").equals("Submit-City")) {

            try {
                City city = new CityDAO().getCityData(req.getParameter("city"));
                if (city != null) { // check if ResultSet has any rows
                    req.setAttribute("city",city);
                    RequestDispatcher requestDispatcher = req.getRequestDispatcher("cities.jsp");
                    requestDispatcher.include(req, resp);
                } else {
                    resp.getWriter().println("<h1>No city found with that name</h1>");
                }

            } catch (SQLException e) {
                resp.getWriter().println("<h1>Register is unSuccessful</h1>");
            }
        }


        //2
        if (req.getParameter("button")!= null && req.getParameter("button").equals("ReportPage")) {
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("Report.jsp");
            requestDispatcher.include(req, resp);
        }

        //3
        if (req.getParameter("button")!= null && req.getParameter("button").equals("submitReport")) {
            ExecutorService executor = Executors.newFixedThreadPool(2);
                try {

                    ReportDAO DAO = new ReportDAO();

                    if (DAO.isUserBlocked(req.getParameter("phone"))) {
                        resp.getWriter().println("You are blocked");
                        RequestDispatcher requestDispatcher = req.getRequestDispatcher("Report.jsp");
                        requestDispatcher.include(req, resp);

                    } else {

                        new ReportDAO().insertReport(new Report(0,"",req.getParameter("phone"),req.getParameter("city"),req.getParameter("violation"),req.getPart("media").getInputStream(),"inProgress"));
                        RequestDispatcher requestDispatcher = req.getRequestDispatcher("index.jsp");
                        requestDispatcher.forward(req, resp);
                    }

                } catch (SQLException e) {
                    resp.getWriter().println("error");
                }
            }


        //4
        if (req.getParameter("button")!= null && req.getParameter("button").equals("AdminLogin")) {
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("AdminLogin.jsp");
            requestDispatcher.forward(req, resp);
        }

        //5
        if (req.getParameter("button")!= null && req.getParameter("button").equals("AdminPage")) {
            if (req.getParameter("name").equals("admin") && req.getParameter("password").equals("1234")) {
                try {
                    req.setAttribute("reportList", new ReportDAO().getInProgressReports());
                    RequestDispatcher requestDispatcher = req.getRequestDispatcher("AdminPage.jsp");
                    requestDispatcher.include(req, resp);

                } catch (Exception e) {
                    resp.getWriter().println("<h1>unSuccessful</h1>");
                }


            } else {
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("AdminLogin.jsp");
                resp.getWriter().write("Invalid Login");
                requestDispatcher.include(req, resp);
            }
        }
        //6
        if (req.getParameter("button")!= null && req.getParameter("button").equals("Approve")) {
            try {
                new ReportDAO().setState(Integer.parseInt(req.getParameter("id")),"ApprovedActive");
                req.setAttribute("reportList", new ReportDAO().getInProgressReports());
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("AdminPage.jsp");
                requestDispatcher.forward(req, resp);

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        //7
        if (req.getParameter("button")!= null && req.getParameter("button").equals("Disapprove")) {
            try {
                new ReportDAO().setState(Integer.parseInt(req.getParameter("id")),"Disapproved");
                req.setAttribute("reportList", new ReportDAO().getInProgressReports());
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("AdminPage.jsp");
                requestDispatcher.forward(req, resp);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void destroy() {
    }
}