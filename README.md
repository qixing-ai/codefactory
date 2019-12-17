# 使用规范
## 第一步:引入pom依赖
    <dependency>
         <groupId>com.github.heyi-core</groupId>
         <artifactId>generator</artifactId>
         <version>4.1</version>
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
## 第三步:创建配置文件(generatorConfig.properties)
    ###数据库连接
    jdbc.url=jdbc:mysql://192.168.1.121:3306/database?useUnicode=true&characterEncoding=UTF-8&useSSL=false
    ###数据库
    jdbc.database=database
    ###数据库用户名
    jdbc.username=database
    ###数据库密码
    jdbc.password=database
    ###需要生成的表名
    (1.如果要写所有表 target.table=*
     2.如果要写以us开头的所有表   target.table=us*
     3.如果要生成多张表  target.table=user,role
    )
    target.table=user
    ###生成的主目录
    base.package=com.heyi.mypro
    ###mapper文件生成主目录
    mappers.file= /src/main/resources/mappers
    ###签名信息
    author=name
    ###配置
    template.file=template
    ###mapper配置
    mappers.file=/src/main/resources/mappers

                    
## 第四步:书写生成代码模板 
   存放代码模板 
    命名规则为后缀 以user为例 model模板为 .java.ftl  生成出的文件为 User.java 
                    controller模板为 Controller.java.ftl 生成出的文件为 UserController.java               
## 第五步:运行生成 
     运行生成代码,根据resource下template模板生成,创建了几份文件 生成几份代码
     如果你的模板外有一个指定生成位置 
        例如user.java文件要生成到user下面model文件夹下 
        那就在template创建一个model文件夹 将你的ftl模板放到这个model文件夹下 那生成出来的文件路径就是 XXXX/user/model/user.java 
     如果你的模板不需要指定生成位置
        那就将你的ftl生成模板全部放到template下即可
        生成的model,controller,service,dao的文件在一个文件夹内,例如 XXXX/user/user.java XXXX/user/userController.java
        生成的mapper文件在resource/mappers文件夹下
     配置文件mappers.file是你mapper文件的主目录
        如果你设定了指定mapper的生成位置
            例如你要讲user的mapper文件生成到user文件夹下,那就创建一个user文件夹,将mapper的ftl模板放到user文件夹下,
            那么他的生成文件路径为 mappers.file/user/userMapper.xml
        如果你不指定生成位置
            那就生成的所有mapper文件都是在mapper.file路径下
## 使用参数详解
    书写模板时按照freemarker的书写规范书写即可   
    引入数据库的表信息 例:表的注释(${table.tableComment})  
    1.数据库的全部表信息:  
        ${table.dataBase}  数据库
        ${table.author}  创建人
        ${table.createTime}  创建时间
        ${table.tableName}  表名称
        ${table.tableNameLower}  表名称全部小写
        ${table.tableNameLowerCamel}  表名称首字母小写其余驼峰
        ${table.tableNameUpperCamel}  表名称首字母大写其余驼峰
        ${table.tableComment}  表注释
        ${table.tablePackage}  包名称
        ${table.projectPath}  项目路径
        ${table.savetPath}  项目路径
    2.数据库表中字段信息 如需获取每个表字段信息 freemarker语法遍历colums即可  
        colum 为遍历后命名的每个表字段对象  
        ${colum.columComment}  字段注释
        ${colum.jdbcType}  数据库数据类型
        ${colum.sqlType}  sql类型
        ${colum.columName}  字段名称
        ${colum.columNameLower}  字段名称全小写不含下划线
        ${colum.columNameLowerCamel}  字段名称首字母小写其余驼峰
        ${colum.columNameUpperCamel} 字段名称首字母大写其余驼峰
    3.主键信息
        key为主键字段的对象
        ${key.columComment}  主键注释
        ${key.jdbcType}  数据库数据类型
        ${key.sqlType}  sql类型
        ${key.columName}  字段名称
        ${key.columNameLower}  字段名称全小写不含下划线
        ${key.columNameLowerCamel}  字段名称首字母小写其余驼峰
        ${key.columNameUpperCamel} 字段名称首字母大写其余驼峰
