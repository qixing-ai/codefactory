package com.heyi;


public class Table {
    /*时间*/
    private String  createTime;
    /*数据库*/
    private String  dataBase;
    /*作者*/
    private String author;
    /*表名称*/
    private String tableName;
    /*表注解*/
    private String tableComment;
    /*表名称小写*/
    private String tableNameLower;
    /*表名称小写驼峰*/
    private String tableNameLowerCamel;
    /*表名称大写驼峰*/
    private String tableNameUpperCamel;
    /*包名称*/
    private String tablePackage;
    /*项目路径*/
    private String projectPath;
    /*保存路径*/
    private String savetPath;

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getTableNameLower() {
        return tableNameLower;
    }

    public void setTableNameLower(String tableNameLower) {
        this.tableNameLower = tableNameLower;
    }

    public String getTableNameLowerCamel() {
        return tableNameLowerCamel;
    }

    public void setTableNameLowerCamel(String tableNameLowerCamel) {
        this.tableNameLowerCamel = tableNameLowerCamel;
    }

    public String getTableNameUpperCamel() {
        return tableNameUpperCamel;
    }

    public void setTableNameUpperCamel(String tableNameUpperCamel) {
        this.tableNameUpperCamel = tableNameUpperCamel;
    }

    public String getTablePackage() {
        return tablePackage;
    }

    public void setTablePackage(String tablePackage) {
        this.tablePackage = tablePackage;
    }

    public String getProjectPath() {
        return projectPath;
    }

    public void setProjectPath(String projectPath) {
        this.projectPath = projectPath;
    }

    public String getSavetPath() {
        return savetPath;
    }

    public void setSavetPath(String savetPath) {
        this.savetPath = savetPath;
    }

    public String getTableComment() {
        return tableComment;
    }

    public void setTableComment(String tableComment) {
        this.tableComment = tableComment;
    }

    public String getDataBase() {
        return dataBase;
    }

    public void setDataBase(String dataBase) {
        this.dataBase = dataBase;
    }
}
