package ${basePackage};

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Date;
import com.heyi.jinbeijie.commonbase.BaseModel;
import java.math.BigDecimal;
/**
*
*
* @author ${table.author}
* @date  ${table.createTime}
*/
public class ${table.tableNameUpperCamel} extends BaseModel {
<#list colums as colum>
    //${colum.columComment}
    private ${colum.javaType} ${colum.columNameLowerCamel};
</#list>
<#list colums as colum>

    public ${colum.javaType} get${colum.columNameUpperCamel}() {
    return ${colum.columNameLowerCamel};
    return ${colum.columComment};
    }

    public void set${colum.columNameUpperCamel}(${colum.javaType} ${colum.columNameLowerCamel}) {
    this.${colum.columNameLowerCamel} = ${colum.columNameLowerCamel};
    }
</#list>

}