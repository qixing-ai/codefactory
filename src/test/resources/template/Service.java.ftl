package ${basePackage};

import java.util.List;
import ${basePackage}.${table.tableNameUpperCamel};

/**
* ${table.tableComment}(${table.tableNameUpperCamel})表服务接口
*
* @author ${table.author}
* @date  ${table.createTime}
*/
public interface ${table.tableNameUpperCamel}Service {

    /**
    * 查询多条数据
    *
    * @param ${table.tableNameLowerCamel} 查询参数
    * @return 对象列表
    */
    List<${table.tableNameUpperCamel}> pages(${table.tableNameUpperCamel} ${table.tableNameLowerCamel});

    /**
    * 查询所有数据
    *
    * @return 对象列表
    */
    List<${table.tableNameUpperCamel}> getAll();

    /**
    * 新增数据
    *
    * @param ${table.tableNameLowerCamel} 实例对象
    * @param student    操作人
    * @return 实例对象
    */
    ${table.tableNameUpperCamel} add(${table.tableNameUpperCamel} ${table.tableNameLowerCamel} );

    /**
    * 通过ID查询单条数据
    *
    * @param ${table.tableNameLowerCamel}Id 主键
    * @return 实例对象
    */
    ${table.tableNameUpperCamel} getById(Long ${table.tableNameLowerCamel}Id);


    /**
    * 修改数据
    *
    * @param ${table.tableNameLowerCamel} 实例对象
    * @param student    操作人
    * @return 实例对象
    */
    ${table.tableNameUpperCamel} update(${table.tableNameUpperCamel} ${table.tableNameLowerCamel});

    /**
    * 通过主键删除数据
    *
    * @param ${table.tableNameLowerCamel}Id 主键
    * @return 是否成功
    */
    boolean deleteById(Long ${table.tableNameLowerCamel}Id);

}