package ${basePackage};

import com.heyi.jinbeijie.commonutils.PagesBean4DataTables;
import com.heyi.jinbeijie.commonutils.PagingBean;
import ${basePackage}.${modelNameUpperCamel};
import ${basePackage}.${modelNameUpperCamel}Service;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.context.annotation.Scope;
import javax.annotation.Resource;
import java.util.List;
import com.heyi.jinbeijie.commonbase.CustomerBaseController;

/**
*
*
* @author ${author}
* @date  ${date}
*/
@Controller
@Scope("request")
@RequestMapping("/${baseRequestMapping}")

public class ${modelNameUpperCamel}Controller extends CustomerBaseController{

    @Resource
    private ${modelNameUpperCamel}Service service;

    /**
    * 分页查询
    **/
    @RequestMapping(value = "/pages")
    public void pages(@RequestBody ${modelNameUpperCamel} ${modelNameLowerCamel}) {
    PagingBean pagingBean = getPagingBean(${modelNameLowerCamel});
    List<${modelNameUpperCamel}> list = this.service.pages(${modelNameLowerCamel}, pagingBean);
    PagesBean4DataTables pagesBean4DataTables = this.getPagesBean4DataTables(pagingBean, list);
    this.responseWriter(true, "获取成功", pagesBean4DataTables);

    }

    /**
    * 获取所有
    **/
    @RequestMapping(value = "/getAll")
    public void getall() {
        List<${modelNameUpperCamel}> list = this.service.getAll();
        this.responseWriter(true, "获取成功", list);

    }

    /**
    * 添加
    **/
    @RequestMapping("/add")
    public void add(@RequestBody ${modelNameUpperCamel} ${modelNameLowerCamel}) {
        ${modelNameUpperCamel} new${modelNameLowerCamel} = service.add(${modelNameLowerCamel},  getCustomerUser());
        this.responseWriter(true, "添加成功", new${modelNameLowerCamel});

    }

    /**
    * 删除
    **/
    @RequestMapping("/delete")
    public void delete(@RequestBody ${modelNameUpperCamel} ${modelNameLowerCamel}) {
        service.delById(${modelNameLowerCamel}.get${getkey}());
        this.responseWriter(true, "删除成功");

    }

    /**
    * 详情
    **/
    @RequestMapping("/detail")
    public void detail(@RequestBody ${modelNameUpperCamel} ${modelNameLowerCamel}) {
        ${modelNameUpperCamel} new${modelNameLowerCamel}= service.getById(${modelNameLowerCamel}.get${getkey}());
        if (new${modelNameLowerCamel} != null) {
        this.responseWriter(true, "查询成功", new${modelNameLowerCamel});
        } else {
        this.responseWriter(false, "没有找到");
    }

    }

    /**
    * 修改
    **/
    @RequestMapping("/update")
    public void update(@RequestBody ${modelNameUpperCamel} ${modelNameLowerCamel}) throws Exception {
        ${modelNameUpperCamel} new${modelNameLowerCamel}= service.update(${modelNameLowerCamel},  getCustomerUser());
        this.responseWriter(true, "修改成功", new${modelNameLowerCamel});

    }

}
