package ${basePackage};

import  ${basePackage}.${table.tableNameUpperCamel};
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * ${table.tableComment}(${table.tableNameUpperCamel})表数据交互类
 * @author ${table.author}
 * @date  $${table.createTime}
 */
@Mapper
public interface ${table.tableNameUpperCamel}Dao {

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
   * @return 影响行数
   */
   int add(${table.tableNameUpperCamel} ${table.tableNameLowerCamel});

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
   * @return 影响行数
   */
   int update(${table.tableNameUpperCamel} ${table.tableNameLowerCamel});

   /**
   * 通过主键删除数据
   *
   * @param ${table.tableNameLowerCamel}Id 主键
   * @return 影响行数
   */
   int deleteById(Long ${table.tableNameLowerCamel}Id);
}
