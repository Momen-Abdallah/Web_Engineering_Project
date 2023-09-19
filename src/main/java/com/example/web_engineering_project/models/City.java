package com.example.web_engineering_project.models;

public class City {
    private String name;
    private boolean safe;
    private boolean clean;
    private boolean sane;



    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isSafe() {
        return safe;
    }

    public void setSafe(boolean safe) {
        this.safe = safe;
    }

    public boolean isClean() {
        return clean;
    }

    public void setClean(boolean clean) {
        this.clean = clean;
    }

    public boolean isSane() {
        return sane;
    }

    public void setSane(boolean sane) {
        this.sane = sane;
    }


}
