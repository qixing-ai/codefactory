package  ${basePackage};


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
* ${table.tableComment}
*
* @author ${table.author}
* @date  ${table.createTime}
*/
@ApiModel(description = "${table.tableComment}")
@Data
public class ${table.tableNameUpperCamel}  {
<#list colums as colum>
        @ApiModelProperty(value = "${colum.columComment}", name = "${colum.columNameLowerCamel}", example = "")
        private ${colum.javaType} ${colum.columNameLowerCamel};
</#list>
}