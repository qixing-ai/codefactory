package ${basePackage};

import ${basePackage}.${table.tableNameUpperCamel};
import ${basePackage}.${table.tableNameUpperCamel}Service;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.annotation.Resource;
import java.util.List;

/**
*
* ${table.tableComment}
* @author ${table.author}
* @date  ${table.createTime}
*/
@Controller
@RequestMapping("/${table.tableNameLower}")
@Api(value = "${table.tableComment}", tags = "${table.tableComment}操作接口")
public class ${table.tableNameUpperCamel}Controller {

    @Resource
    private ${table.tableNameUpperCamel}Service service;

    @ApiOperation(value = "分页", notes = "分页查询")
    @PostMapping(value = "/pages")
    public BaseResponse pages(@RequestBody ${table.tableNameUpperCamel} ${table.tableNameLowerCamel}) {
        PageHelper.startPage(${table.tableNameLowerCamel} .getStart(), ${table.tableNameLowerCamel} .getLength());
        List<${table.tableNameUpperCamel}> list = service.pages(${table.tableNameLowerCamel});
        return new BaseResponse(true, "获取成功", list, ((Page) list).getTotal());
    }

    @ApiOperation(value = "获取所有", notes = "获取所有")
    @PostMapping(value = "/getAll")
    public BaseResponse getAll() {
        List<${table.tableNameUpperCamel}> list = this.service.getAll();
        return new BaseResponse(true, "获取成功", list);
    }

    @ApiOperation(value = "添加", notes = "添加")
    @PostMapping("/add")
    public BaseResponse add(@RequestBody ${table.tableNameUpperCamel} ${table.tableNameLowerCamel}) {
        ${table.tableNameUpperCamel} new${table.tableNameUpperCamel} = service.add(${table.tableNameLowerCamel}, student);
        return new BaseResponse(true, "添加成功", new${table.tableNameUpperCamel});
    }


    @ApiOperation(value = "详情", notes = "详情")
    @PostMapping("/detail")
    public BaseResponse detail(@RequestBody ${table.tableNameUpperCamel} ${table.tableNameLowerCamel}) {
        ${table.tableNameUpperCamel} new${table.tableNameUpperCamel} = service.getById(${table.tableNameLowerCamel}. get${'${key.columName}'?cap_first}());
        if (new${table.tableNameUpperCamel} != null) {
            return new BaseResponse(true, "查询成功", new${table.tableNameUpperCamel});
        } else {
            return new BaseResponse(false, "没有找到");
        }
    }

    @ApiOperation(value = "修改", notes = "用户修改")
    @PostMapping("/update")
    public BaseResponse update(@RequestBody ${table.tableNameUpperCamel} ${table.tableNameLowerCamel}) {
        ${table.tableNameUpperCamel} new${table.tableNameUpperCamel} = service.update(${table.tableNameLowerCamel},student);
        return new BaseResponse(true, "修改成功", new${table.tableNameUpperCamel});
    }

    @ApiOperation(value = "删除", notes = "删除")
    @PostMapping("/delete")
    public BaseResponse delete(@RequestBody ${table.tableNameUpperCamel} ${table.tableNameLowerCamel}) {
        service.deleteById(${table.tableNameLowerCamel}.get${'${key.columName}'?cap_first}());
        return new BaseResponse(true, "删除成功");
    }

}