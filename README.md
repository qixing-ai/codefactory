# codefactory
根据数据库表自动生成代码，需要自己定义模板
#generator 
运行生成代码,根据resource下template模板生成,创建了几份文件 生成几份代码
#template 
存放代码模板 
命名规则为后缀 以user为例 model模板为 .java.ftl  生成出的文件为 User.java 
                    controller模板为 Controller.java.ftl 生成出的文件为 UserController.java
#generatorConfig.properties
数据库连接信息与配置
#模板规范
书写模板时按照freemarker的书写规范书写即可 
引入数据库的表信息 例:表的注释(${table.tableComment})
数据库的全部表信息:
    - 数据库 ${table.dataBase}
    - 创建人 ${table.author}
    - 创建时间 ${table.createTime}
    - 表名称 ${table.tableName}
    - 表名称全部小写 ${table.tableNameLower}
    - 表名称首字母小写其余驼峰 ${table.tableNameLowerCamel}
    - 表名称首字母大写其余驼峰 ${table.tableNameUpperCamel}
    - 表注释 ${table.tableComment}
    - 包名称 ${table.tablePackage}
    - 项目路径 ${table.projectPath}
    - 项目路径 ${table.savetPath}
数据库表中字段信息 如需获取每个表字段信息 freemarker语法遍历colums即可
    colum 为遍历后命名的每个表字段
    - 表注释 ${colum.columComment}
    - 数据库数据类型  ${colum.jdbcType}
    - sql类型 ${colum.sqlType}
    - 字段名称 ${colum.columName}
    - 字段名称全小写不含下划线   ${colum.columNameLower}
    - 字段名称首字母小写其余驼峰 ${colum.columNameLowerCamel}
    - 字段名称首字母大写其余驼峰 ${colum.columNameUpperCamel}
   