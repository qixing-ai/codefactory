# 使用规范
## 第一步:引入pom依赖
    <dependency>
         <groupId>com.github.heyi-core</groupId>
         <artifactId>generator</artifactId>
         <version>3.0</version>
         <scope>test</scope>
    </dependency>
    scope方式为test,代码不会被打包进去
## 第二步:创建文件与目录
    所有文件皆在项目的test目录下
    1.启动文件 
        随意命名 执行下main方法即可
         public static void main(String[] args) {
                GService cgm = new GService();
                cgm.run();
            }
    2.配置文件
        必须以generatorConfig.properties命名,将文件生成到resource下
    3.在resource目录下生成文件夹,随意命名,用于存放生成所属的ftl模板
## 第三步:创建配置文件
    1. 数据库连接
        1.数据库连接
            jdbc.url=jdbc:mysql://localhost:3306/database?useUnicode=true&characterEncoding=UTF-8&useSSL=false
        2.数据库
            jdbc.database=database
        3.用户名
            jdbc.username=database
        4.密码    
            jdbc.password=database
    2.需要生成的表
        target.table=user
    3.生成目录
         base.package=com.heyi.test.platform
    4.生成文件用户签名
         author=zhang
    5.模板存放文件夹名称
         template.file=template (你创建的文件夹叫什么名字就填写什么名字)                     
## 第四步:书写生成代码模板 
   存放代码模板 
    命名规则为后缀 以user为例 model模板为 .java.ftl  生成出的文件为 User.java 
                    controller模板为 Controller.java.ftl 生成出的文件为 UserController.java
## 第五步:运行生成 
     运行生成代码,根据resource下template模板生成,创建了几份文件 生成几份代码
     生成的model,controller,service,dao的文件在一个文件夹内
     生成的mapper文件在resource/mappers文件夹下
## 使用参数详解
    书写模板时按照freemarker的书写规范书写即可   
    引入数据库的表信息 例:表的注释(${table.tableComment})  
    1.数据库的全部表信息:  
        1.数据库 ${table.dataBase}  
        2.创建人 ${table.author}  
        3. 创建时间 ${table.createTime}  
        4. 表名称 ${table.tableName}  
        5. 表名称全部小写 ${table.tableNameLower}  
        6. 表名称首字母小写其余驼峰 ${table.tableNameLowerCamel}  
        7. 表名称首字母大写其余驼峰 ${table.tableNameUpperCamel}  
        8. 表注释 ${table.tableComment}  
        9. 包名称 ${table.tablePackage}  
        10. 项目路径 ${table.projectPath}  
        11. 项目路径 ${table.savetPath}  
    2.数据库表中字段信息 如需获取每个表字段信息 freemarker语法遍历colums即可  
        colum 为遍历后命名的每个表字段对象  
        1. 字段注释 ${colum.columComment}  
        2. 数据库数据类型  ${colum.jdbcType}  
        3. sql类型 ${colum.sqlType}  
        4. 字段名称 ${colum.columName}  
        5. 字段名称全小写不含下划线   ${colum.columNameLower}  
        6. 字段名称首字母小写其余驼峰 ${colum.columNameLowerCamel}  
        7. 字段名称首字母大写其余驼峰 ${colum.columNameUpperCamel} 
    3.主键信息
        key为主键字段的对象
        1. 主键注释 ${key.columComment}  
        2. 数据库数据类型  ${key.jdbcType}  
        3. sql类型 ${key.sqlType}  
        4. 字段名称 ${key.columName}  
        5. 字段名称全小写不含下划线   ${key.columNameLower}  
        6. 字段名称首字母小写其余驼峰 ${key.columNameLowerCamel}  
        7. 字段名称首字母大写其余驼峰 ${key.columNameUpperCamel} 
