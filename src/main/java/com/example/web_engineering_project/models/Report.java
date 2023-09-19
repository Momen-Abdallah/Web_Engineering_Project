package com.example.web_engineering_project.models;

import java.io.InputStream;
public class Report {
    private int id;
    private String date;



    private String phone;

    public Report(int id, String date, String phone, String city, String violation, InputStream media, String state) {
        this.id = id;
        this.date = date;
        this.phone = phone;
        this.city = city;
        this.violation = violation;
        this.media = media;
        this.state = state;
    }

    private String city;
    private String violation;

    private InputStream media;
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getViolation() {
        return violation;
    }

    public void setViolation(String violation) {
        this.violation = violation;
    }

    public InputStream getMedia() {
        return media;
    }

    public void setMedia(InputStream media) {
        this.media = media;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    private String state;
}
