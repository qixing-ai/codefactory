package com.heyi;

public class Colum {
    /*注解*/
    private String columComment;
    /*sqlType*/
    private String sqlType;
    /*jdbcType*/
    private String jdbcType;
    /*javaType*/
    private String javaType;
    /*字段名称*/
    private String columName;
    /*小写没有下划线*/
    private String columNameLower;
    /*小写驼峰*/
    private String columNameLowerCamel;
    /*大写驼峰*/
    private String columNameUpperCamel;


    public String getColumComment() {
        return columComment;
    }

    public void setColumComment(String columComment) {
        this.columComment = columComment;
    }

    public String getJdbcType() {
        return jdbcType;
    }

    public void setJdbcType(String jdbcType) {
        this.jdbcType = jdbcType;
    }

    public String getJavaType() {
        return javaType;
    }

    public void setJavaType(String javaType) {
        this.javaType = javaType;
    }

    public String getColumName() {
        return columName;
    }

    public void setColumName(String columName) {
        this.columName = columName;
    }

    public String getColumNameLower() {
        return columNameLower;
    }

    public void setColumNameLower(String columNameLower) {
        this.columNameLower = columNameLower;
    }

    public String getColumNameLowerCamel() {
        return columNameLowerCamel;
    }

    public void setColumNameLowerCamel(String columNameLowerCamel) {
        this.columNameLowerCamel = columNameLowerCamel;
    }

    public String getColumNameUpperCamel() {
        return columNameUpperCamel;
    }

    public void setColumNameUpperCamel(String columNameUpperCamel) {
        this.columNameUpperCamel = columNameUpperCamel;
    }

    public String getSqlType() {
        return sqlType;
    }

    public void setSqlType(String sqlType) {
        this.sqlType = sqlType;
    }
}

