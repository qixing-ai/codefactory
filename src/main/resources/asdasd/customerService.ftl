package ${basePackage};


import com.heyi.jinbeijie.commonbase.BaseService;
import com.heyi.jinbeijie.commonbase.DaoInterface;
import com.heyi.jinbeijie.commonutils.BeanUtils;
import com.heyi.jinbeijie.commonutils.ID16NumberGenerator;
import com.heyi.jinbeijie.commonutils.PagingBean;
import ${basePackage}.${modelNameUpperCamel}Dao;
import ${basePackage}.${modelNameUpperCamel};
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.Calendar;
import java.util.List;
import com.heyi.jinbeijie.platform.customeruser.CustomerUser;
/**
*
*
* @author ${author}
* @date  ${date}
*/
@Service
public class ${modelNameUpperCamel}Service extends BaseService<${modelNameUpperCamel},Long> {
    @Resource
    private ${modelNameUpperCamel}Dao dao;

    @Override
    protected DaoInterface<${modelNameUpperCamel}, Long> getDao() {
    return this.dao;
    }

    /**
    * 固定分页查询
    **/
    public List<${modelNameUpperCamel}> pages(${modelNameUpperCamel} ${modelNameLowerCamel}, PagingBean pagingBean) {

        List<${modelNameUpperCamel}> list = this.dao.getPages(${modelNameLowerCamel}, pagingBean);
        return list;
    }

    /**
    * 添加
    * @param ${modelNameLowerCamel}
    * @param currentUsers
    * @return
    */
    public ${modelNameUpperCamel} add(${modelNameUpperCamel} ${modelNameLowerCamel}, CustomerUser currentUsers)  {
        ${modelNameLowerCamel}.set${getkey}(ID16NumberGenerator.get16NumberID());
        ${modelNameLowerCamel}.setCreator(currentUsers.getUserId());
        ${modelNameLowerCamel}.setCreateTime(Calendar.getInstance().getTime());
        dao.add(${modelNameLowerCamel});
        return ${modelNameLowerCamel};
    }

    /**
    * 修改
    * @param ${modelNameLowerCamel}
    * @param currentUsers
    * @return
    * @
    */
    public  ${modelNameUpperCamel} update(${modelNameUpperCamel} ${modelNameLowerCamel}, CustomerUser currentUsers) throws Exception  {
        ${modelNameUpperCamel} old${modelNameLowerCamel} = dao.getById(${modelNameLowerCamel}.get${getkey}());
        ${modelNameLowerCamel}.setModifyor(currentUsers.getUserId());
        ${modelNameLowerCamel}.setModifyTime(Calendar.getInstance().getTime());

        dao.update(${modelNameLowerCamel});
        BeanUtils.copyBeanNotNull2Bean(${modelNameLowerCamel}, old${modelNameLowerCamel});
        return old${modelNameLowerCamel};
    }

}
