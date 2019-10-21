<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${basePackage}.${table.tableNameUpperCamel}Dao">
    <resultMap id="BaseResultMap" type="${basePackage}.${table.tableNameUpperCamel}">
<#list colums as colum>
    <#if colum.columName==key.columName>
        <id column="${colum.columName}" jdbcType="${colum.jdbcType}" property="${colum.columNameLowerCamel}"/>
    <#else>
        <result column="${colum.columName}" jdbcType="${colum.jdbcType}" property="${colum.columNameLowerCamel}"/>
    </#if>
</#list>
    </resultMap>
    <!--获取全部-->
    <select id="getAll" resultMap="BaseResultMap">
        select
        <#list colums as colum>
            ${colum.columName}<#if colum_has_next>,</#if>
        </#list>
        from ${table.tableName}
    </select>
    <!--分页查询-->
    <select id="pages" resultMap="BaseResultMap">
        select
        <#list colums as colum>
            ${colum.columName}<#if colum_has_next>,</#if>
        </#list>
        from ${table.tableName}
        order by ${key.columName} desc
    </select>
    <!--添加-->
    <insert id="add" parameterType="${basePackage}.${table.tableNameUpperCamel}">
        insert into ${table.tableName} (
        <#list colums as colum>
            ${colum.columName}<#if colum_has_next>,</#if>
        </#list> )values (
        <#list colums as colum>
            #${r'{'}${colum.columNameLowerCamel},jdbcType=${colum.jdbcType}${r'}'}<#if colum_has_next>,</#if>
        </#list>)
    </insert>
    <!--修改-->
    <update id="update" parameterType="${basePackage}.${table.tableNameUpperCamel}">
        update ${table.tableName}
        <set>
<#list colums as colum>
    <#if colum.columName!=key.columName >
        <#if  colum.jdbcType != 'BIT' && colum.jdbcType != 'TIMESTAMP'&& colum.jdbcType != 'INTEGER'&& colum.jdbcType != 'DECIMAL'>
           <if test="${colum.columNameLowerCamel} != null and ${colum.columNameLowerCamel} !='' ">
              ${colum.columName} = #${r'{'}${colum.columNameLowerCamel},jdbcType=${colum.jdbcType}${r'}'}<#if colum_has_next>,</#if>
           </if>
        </#if>
        <#if  colum.jdbcType == 'BIT'>
           <if test="${colum.columNameLowerCamel} != null ">
              ${colum.columName} = #${r'{'}${colum.columNameLowerCamel},jdbcType=${colum.jdbcType}${r'}'}<#if colum_has_next>,</#if>
           </if>
        </#if>
        <#if  colum.jdbcType == 'INTEGER'>
           <if test="${colum.columNameLowerCamel} != null ">
              ${colum.columName} = #${r'{'}${colum.columNameLowerCamel},jdbcType=${colum.jdbcType}${r'}'}<#if colum_has_next>,</#if>
           </if>
        </#if>
        <#if  colum.jdbcType == 'TIMESTAMP'>
           <if test="${colum.columNameLowerCamel} != null ">
              ${colum.columName} = #${r'{'}${colum.columNameLowerCamel},jdbcType=${colum.jdbcType}${r'}'}<#if colum_has_next>,</#if>
           </if>
        </#if>
        <#if  colum.jdbcType == 'DECIMAL'>
            <if test="${colum.columNameLowerCamel} != null ">
                ${colum.columName} = #${r'{'}${colum.columNameLowerCamel},jdbcType=${colum.jdbcType}${r'}'}<#if colum_has_next>,</#if>
            </if>
        </#if>
    </#if>
</#list>
        </set>
        where ${key.columName}= <#list colums as colum><#if colum.columName==key.columName>#${r'{'}${colum.columNameLowerCamel},jdbcType=${colum.jdbcType}${r'}'} </#if></#list>
    </update>
    <!--详情-->
    <select id="getById" parameterType="java.lang.Long" resultMap="BaseResultMap">
        select
        <#list colums as colum>
            ${colum.columName}<#if colum_has_next>,</#if>
        </#list>
        from ${table.tableName}
        where ${key.columName}= <#list colums as colum><#if colum.columName==key.columName>#${r'{'}${colum.columNameLowerCamel},jdbcType=${colum.jdbcType}${r'}'} </#if></#list>
    </select>
    <!--删除-->
    <delete id="delById" parameterType="java.lang.Long">
        delete from ${table.tableName} where ${key.columName}= <#list colums as colum><#if colum.columName==key.columName>#${r'{'}${colum.columNameLowerCamel},jdbcType=${colum.jdbcType}${r'}'} </#if></#list>
    </delete>
</mapper>