<template>
        <el-row>
            <el-button type="primary" @click="openadditem">添加</el-button>
            <el-table border stripe  :data='tableData' ref='table'>
                <#list colum as map>
                    <#if  map["colum"] != "creator" && map["colum"] != "createTime" && map["colum"] != "modifyTime" && map["colum"] != "modifyor" >
                        <el-table-column fixed align="center"  prop="${map["colum"]}"  label="${map["REMARKS"]}"></el-table-column>
                    </#if>
                </#list>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button size="mini" @click="openedit(scope.row)">编辑
                        </el-button>
                        <el-button size="mini" type="danger" @click="deleteitem(scope.row)">删除
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-pagination background  layout="prev, pager, next" :total="tableTotal+1" :current-page.sync="currentPage" :page-size.sync="pageSize"
                           @current-change='tablePageChange'></el-pagination>
            <el-dialog :visible.sync='addModal' :title="title" width="80%">
                <el-form :model='${modelNameUpperCamel}' label-width='150px' ref='${modelNameUpperCamel}form' :rules="rule4${modelNameUpperCamel}form" inline>
                    <#list colum as map>
                        <#if  map["colum"] != "creator" && map["colum"] != "createTime" && map["colum"] != "modifyTime" && map["colum"] != "modifyor" >
                            <el-form-item label="${map["REMARKS"]}" prop="${map["colum"]}">
                                <el-input v-model='${modelNameUpperCamel}.${map["colum"]}' placeholder="请输入${map["REMARKS"]}"/>
                            </el-form-item>
                        </#if>
                    </#list>
                </el-form>
                <div slot="footer">
                    <el-button type="default" size="large" @click="addModal=false">取消</el-button>
                    <el-button type="primary" size="large" @click="addoredit" >确认</el-button>
                </div>
            </el-dialog>
        </el-row>
</template>

<script>

    export default {
        name: '${modelNameUpperCamel}',
        data () {
            return {
                title: '添加**',
                state: 0,
            ${modelNameUpperCamel}: {
                <#list colum as map>
                <#if  map["colum"] != "creator" && map["colum"] != "createTime" && map["colum"] != "modifyTime" && map["colum"] != "modifyor" >
                ${map["colum"]}: '',
                </#if>
                </#list>
            },
            rule4${modelNameUpperCamel}form: {
                <#list colum as map>
                <#if  map["colum"] != "creator" && map["colum"] != "createTime" && map["colum"] != "modifyTime" && map["colum"] != "modifyor" >
                ${map["colum"]}: this.vstring,
                </#if>
                </#list>
            },
            addModal: false,
            tableData: [],
            currentPage:1,
            pageSize:10,
            tableTotal: 0
            };
        },
        methods: {
            /* 通过state判断添加还是修改 */
            addoredit () {
                if (this.state === 0) {
                    this.additem();
                } else {
                    this.edititem();
                }
            },
            /* 增加 */
            openadditem () {
                this.addModal = true;
                this.title = '添加**';
                if (this.state === 1) {
                    this.$refs['${modelNameUpperCamel}form'].resetFields();
                }
                this.state = 0;
            },
            additem () {
                this.$refs['${modelNameUpperCamel}form'].validate((valid) => {
                    if (valid) {
                        this.ajax.${baseRequestMapping}add(this.${modelNameUpperCamel}).then((res) => {
                            if (res.result) {
                            this.$message.success(res.description);
                            this.addModal = false;
                            this.tablePageChange();
                        } else {
                            this.$message.error(res.description);
                        }
                    });
                    } else {
                        this.$message.error('请检查提交信息');
            }
            });
            },
            /* 修改 */
            openedit (item) {
                this.addModal = true;
                this.title = '修改**';
                this.state = 1;
                this.${modelNameUpperCamel} = JSON.parse(JSON.stringify(item));
            },
            edititem () {
                this.$refs['${modelNameUpperCamel}form'].validate((valid) => {
                    if (valid) {
                        this.ajax.${baseRequestMapping}update(this.${modelNameUpperCamel}).then((res) => {
                            if (res.result) {
                            this.$message.success(res.description);
                            this.addModal = false;
                            this.tablePageChange();
                        } else {
                            this.$message.error(res.description);
                        }
                    });
                    } else {
                        this.$message.error('请检查提交信息');
            }
            });
            },
            /* 删除 */
            deleteitem (item) {
                this.$confirm('此操作将永久删除该数据, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.ajax.${baseRequestMapping}delete({
                            <#list colum as map>
                            <#if map["COLUM"]==KEY>
                            '${map["colum"]}': item.${map["colum"]}
                            </#if>
                            </#list>
                        }).then((res) => {
                        if (res.result) {
                    this.$message.success(res.description);
                    this.tablePageChange();
                } else {
                    this.$message.error(res.description);
                }
            });
            });
            },
            /* 查询 */
            gettabledata (start = 0, length = 10) {
                this.ajax.${baseRequestMapping}pages({
                        'start': start,
                        'length': length
                    }).then((res) => {
                    if (res.result) {
                    this.tableData = res.obj.data;
                    this.tableTotal = res.obj.recordsTotal;
                } else {
                    this.$message.error(res.description);
                }
            });
            },
            /* 分页 */
            tablePageChange () {
                this.gettabledata((this.currentPage - 1) * this.pageSize, this.pageSize);
            }
        },
        /* 初始化 */
        created () {
            this.gettabledata();
        }
    };
</script>
