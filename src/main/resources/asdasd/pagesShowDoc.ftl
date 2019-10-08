**简要描述：**

- 分页查询

**请求URL：**
- ` http://127.0.0.1:8080/${baseRequestMapping}/pages `

**请求方式：**
- POST

**参数：**

|参数名|必选|类型|说明|
|:----    |:---|:----- |-----   |
|start |是  |Integer |分页-跳过几条   |
|length |是  |Integer | 分页-显示几条    |

**请求示例**
```
{
"start":"1",
"length":"3"
}
```
**返回示例**

```
{
"description": "获取成功",
"obj": {
"data": [
{
<#list colum as map>
    "${map["colum"]}":<#if map_has_next>,</#if>
</#list>
},
],
"recordsTotal": X
},
"result": true
}
```

**返回参数说明**

|参数名|类型|说明|
|:-----  |:-----|-----                           |
<#list colum as map>
|${map["colum"]} |${map["type"]}   |${map["REMARKS"]}  |
</#list>

**备注**



