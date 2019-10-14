package ${basePackage};

import com.heyi.jinbeijie.commonutils.PagesBean4DataTables;
import com.heyi.jinbeijie.commonutils.PagingBean;
import ${basePackage}.${table.tableNameUpperCamel};
import ${basePackage}.${table.tableNameUpperCamel}Service;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.context.annotation.Scope;
import javax.annotation.Resource;
import java.util.List;
import com.heyi.jinbeijie.commonbase.SysBaseController;

/**
*
*
* @author ${table.author}
* @date  ${table.createTime}
* @date  ${table.tableComment}
*/
@Controller
@Scope("request")
@RequestMapping("/${table.tableNameLower}")

public class ${table.tableNameUpperCamel}Controller extends SysBaseController{

@Resource
private ${table.tableNameUpperCamel}Service service;

/**
* 分页查询
**/
@RequestMapping(value = "/pages")
public void pages(@RequestBody  ${table.tableNameUpperCamel} ${table.tableNameLowerCamel}) {
PagingBean pagingBean = getPagingBean(${table.tableNameLowerCamel});
List<${table.tableNameUpperCamel}> list = this.service.pages(${table.tableNameLowerCamel}, pagingBean);
PagesBean4DataTables pagesBean4DataTables = this.getPagesBean4DataTables(pagingBean, list);
this.responseWriter(true, "获取成功", pagesBean4DataTables);

}

/**
* 获取所有
**/
@RequestMapping(value = "/getAll")
public void getall() {
List<${table.tableNameUpperCamel}> list = this.service.getAll();
this.responseWriter(true, "获取成功", list);

}

/**
* 添加
**/
@RequestMapping("/add")
public void add(@RequestBody ${table.tableNameUpperCamel} ${table.tableNameLowerCamel}) {
${table.tableNameUpperCamel} new${table.tableNameLowerCamel} = service.add${table.tableNameLowerCamel},  getSysUser());
this.responseWriter(true, "添加成功", new${table.tableNameLowerCamel});

}

/**
* 删除
**/
@RequestMapping("/delete")
public void delete(@RequestBody ${table.tableNameUpperCamel} ${table.tableNameLowerCamel}) {
service.delById(${table.tableNameLowerCamel}.get${key.columNameLower}());
this.responseWriter(true, "删除成功");

}

/**
* 详情
**/
@RequestMapping("/detail")
public void detail(@RequestBody ${table.tableNameUpperCamel} ${table.tableNameLowerCamel}) {
${table.tableNameUpperCamel} new${table.tableNameLowerCamel}= service.getById(${table.tableNameLowerCamel}.get${key.columNameLower}());
if (new${table.tableNameLowerCamel} != null) {
this.responseWriter(true, "查询成功", new${table.tableNameLowerCamel});
} else {
this.responseWriter(false, "没有找到");
}

}

/**
* 修改
**/
@RequestMapping("/update")
public void update(@RequestBody ${table.tableNameUpperCamel} ${table.tableNameLowerCamel}) throws Exception {
${table.tableNameUpperCamel} new${table.tableNameLowerCamel}= service.update(${table.tableNameLowerCamel},  getSysUser());
this.responseWriter(true, "修改成功", new${table.tableNameLowerCamel});

}

}