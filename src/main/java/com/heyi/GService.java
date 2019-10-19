package com.heyi;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.resource.ClassPathResource;
import freemarker.template.Configuration;
import freemarker.template.TemplateExceptionHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileWriter;
import java.sql.*;
import java.util.*;

import static com.heyi.GUtils.*;

/**
 * Created by codefactory on 2018/3/5.
 */
public class GService {

    private static final Logger logger = LoggerFactory.getLogger(GService.class);
    private Configuration configuration = null;
    private String TEMPLATE_FILE;
    private String JDBC_URL;
    private String JDBC_USERNAME;
    private String JDBC_PASSWORD;
    private String BASE_PACKAGE;
    private String BASE_PACKAGE_PATH;
    private String PROJECT_PATH;
    private String JAVA_PATH = "/src/main/java/";
    private String MAPPER_PATH = "/src/main/resources/mappers";
    private Table table;
    private Map<String, Object> model = new HashMap<String, Object>();

    public static void main(String[] args) {
        GService cgm = new GService();
        cgm.run();
    }

    //1初始化
    public void run() {
        try {
            table = gettableinfo();
            configuration = new Configuration(Configuration.VERSION_2_3_23);
            String configPath = ClassLoader.getSystemResource("").getPath() + TEMPLATE_FILE;
            configuration.setDirectoryForTemplateLoading(new File(configPath));
            configuration.setDefaultEncoding("UTF-8");
            configuration.setTemplateExceptionHandler(TemplateExceptionHandler.IGNORE_HANDLER);
            model.put("table", table);
            getcoluminfo(table.getTableName());
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }

    /*2加载配置文件*/
    private Table gettableinfo() throws Exception {
        ClassPathResource resource = new ClassPathResource("generatorConfig.properties");
        Properties properties = new Properties();
        properties.load(resource.getStream());
        Table table = new Table();
        table.setAuthor(properties.getProperty("author"));
        table.setCreateTime(DateUtil.today());
        table.setTableName(properties.getProperty("target.table"));
        table.setDataBase(properties.getProperty("jdbc.database"));
        table.setTableNameLowerCamel(toCamel(table.getTableName()));
        table.setTableNameLower(toLower(table.getTableNameLowerCamel()));
        table.setTableNameUpperCamel(toUpperFirst(table.getTableNameLowerCamel()));

        BASE_PACKAGE = properties.getProperty("base.package") + "." + table.getTableNameLower();
        model.put("basePackage", BASE_PACKAGE);
        BASE_PACKAGE_PATH = BASE_PACKAGE.replace(".", "/");
        PROJECT_PATH = properties.getProperty("project.path") == null ? "" : properties.getProperty("project.path");
        JDBC_URL = properties.getProperty("jdbc.url");
        JDBC_USERNAME = properties.getProperty("jdbc.username");
        JDBC_PASSWORD = properties.getProperty("jdbc.password");
        TEMPLATE_FILE = properties.getProperty("template.file");
        return table;

    }

    //3获取表xx
    private void getcoluminfo(String tableName) throws Exception {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch (ClassNotFoundException e){
            Class.forName("com.mysql.jdbc.Driver");
        }
        Properties props = new Properties();
        props.put("remarksReporting", "true");
        props.put("user", JDBC_USERNAME);
        props.put("password", JDBC_PASSWORD);
        //设置可以获取remarks信息
        props.setProperty("remarks", "true");
        //设置可以获取tables remarks信息
        props.setProperty("useInformationSchema", "true");

        String sql = "SELECT table_comment FROM information_schema.TABLES WHERE table_schema = '" + table.getDataBase() + "' and TABLE_NAME ='" + tableName + "'";
        Connection conn = DriverManager.getConnection(JDBC_URL, props);
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet result = ps.executeQuery();
        while (result.next()) {
          table.setTableComment(result.getString("table_comment"));
        }
        DatabaseMetaData dbmd = conn.getMetaData();
        ResultSet rs = dbmd.getColumns(null, "%", tableName, "%");
        List<Colum> colums = new ArrayList<Colum>();
        while (rs.next()) {
            colums.add(getcolum(rs));
        }
        model.put("key", colums.get(0));
        ResultSet rs2 = dbmd.getPrimaryKeys(table.getDataBase(), null, tableName);
        while (rs2.next()) {
            Colum colum = new Colum();
            colum.setColumName(rs2.getString("COLUMN_NAME"));
            for (Colum colum1 : colums) {
                if (colum1.getColumName().equals(colum.getColumName())) {
                    colum = colum1;
                    break;
                }
            }
            model.put("key", colum);
        }
        model.put("colums", colums);
        getFile();
    }

    /**
     * 获取所有template下的模板路径,有文件夹带文件夹
     * @param resource
     * @return
     */
    private List<String> returnftlPathList(ClassPathResource resource ){
        File[] ls = FileUtil.ls(resource.getPath());
        List<String> list = new ArrayList<String>();
        for (File l : ls) {
            if(l.isDirectory()){
                File[] ls1 = FileUtil.ls(l.getPath());
                for (File file : ls1) {
                    list.add(l.getPath().substring(l.getPath().lastIndexOf("\\")+1)+"/"+file.getPath().substring(file.getPath().lastIndexOf("\\")+1));
                }
            }else{
                list.add(l.getPath().substring(l.getPath().lastIndexOf("\\")+1));
            }
        }
        return list;
    }
    /*4生成File*/
    private void getFile() throws Exception {
        /*所有模板*/
        ClassPathResource resource = new ClassPathResource(TEMPLATE_FILE);
        List<String> list = returnftlPathList(resource);
        /*循环生成*/
        for (String filename : list) {
            /*目标文件生成*/
            targetFileGenerate(filename);
        }
        /*end*/
        logger.info(table.getTableNameLowerCamel() + "生成成功!");
    }

    /*5生成文件生成*/
    private void targetFileGenerate(String template) throws Exception {
        //文件夹
        String Folder = template.split("/")[0];
        //文件
        String file = template.split("/")[1];
        /*生成*/
        configuration.getTemplate(template).getCustomLookupCondition();
        String filepath = System.getProperty("user.dir") + PROJECT_PATH;
        if (template.contains("Mapper")) {
            filepath = filepath + MAPPER_PATH + "/" + table.getTableNameUpperCamel() + template.replace(".ftl", "");
        } else {
            if(template.contains("/")){
                filepath = filepath + JAVA_PATH + BASE_PACKAGE_PATH + "/" + Folder +"/"+table.getTableNameUpperCamel() + file.replace(".ftl", "");
            }else{
                filepath = filepath + JAVA_PATH + BASE_PACKAGE_PATH + "/" + table.getTableNameUpperCamel() + template.replace(".ftl", "");
            }

        }
        File newfile = new File(filepath);
        if (!newfile.getParentFile().exists()) {
            newfile.getParentFile().mkdirs();
        }
        if (newfile.exists()) {
            newfile.delete();//删除文件
        }
        /*先生成后转移*/
        configuration.getTemplate(template).process(model, new FileWriter(newfile));
    }


    /*表字段对应*/
    private Colum getcolum(ResultSet resultSet) throws Exception {
        Colum colum = new Colum();
        colum.setColumComment(resultSet.getString("REMARKS"));
        colum.setColumName(resultSet.getString("COLUMN_NAME"));
        colum.setColumNameLowerCamel(toCamel(colum.getColumName()));
        colum.setColumNameLower(toLower(colum.getColumNameLowerCamel()));
        colum.setColumNameUpperCamel(toUpperFirst(colum.getColumNameLowerCamel()));
        colum.setSqlType(resultSet.getString("TYPE_NAME"));
        setType(colum, resultSet.getInt("COLUMN_SIZE"));
        return colum;
    }

    /*获取类型*/
    private void setType(Colum colum, int size) {
        String type = colum.getSqlType().toLowerCase();
        String a = "";
        String b = "";
        if (type.equals("integer") || type.equals("int")) {
            a = "Integer";
            b = "INTEGER";
        } else if (type.equals("long") || type.equals("bigint")) {
            a = "Long";
            b = "BIGINT";
        } else if (type.equals("float") || type.equals("float precision")) {
            a = "float";
            b = "REAL";
        } else if (type.equals("double") || type.equals("double precision")) {
            a = "Double";
            b = "DOUBLE";
        } else if (type.equals("decimal")) {
            a = "BigDecimal";
            b = "DECIMAL";
        } else if (type.equals("number") || type.equals("numeric") || type.equals("real")) {
            if (size == 0) {
                a = "BigDecimal";
                b = "DECIMAL";
            }
            if (size < 10) {
                a = "Integer";
                b = "INTEGER";
            }
            if (size >= 10) {
                a = "Long";
                b = "BIGINT";
            }
        } else if (type.equals("varchar") || type.equals("varchar2")
                || type.equals("char") || type.equals("nvarchar")
                || type.equals("nchar") || type.equals("text")) {
            a = "String";
            b = "VARCHAR";
        } else if (type.equals("datetime") || type.equals("date")
                || type.equals("timestamp(6)") || type.equals("timestamp")) {
            a = "Date";
            b = "TIMESTAMP";
        } else if (type.equals("clob")) {
            a = "Clob";
            b = "CLOB";
        } else if (type.equals("tinyint")) {
            a = "Integer";
            b = "TINYINT";
        } else if (type.equals("bit")) {
            a = "Boolean";
            b = "BIT";
        }
        colum.setJavaType(a);
        colum.setJdbcType(b);
    }


}
