<template>
    <Row>
        <Card>
            <Form :label-width='80' class="myform">
                <Button type="primary" @click="openadditem" >添加</Button>
            </Form>
            <Table border stripe :columns='columnsList' :data='tableData' ref='table'></Table>
            <Page :total='tableTotal+1' @on-change='tablePageChange' ref='tablePage' style="margin-top: 10px;"></Page>
        </Card>

        <Modal v-model='addModal' :title="title" width="880">
            <Form :model='${modelNameUpperCamel}' :label-width='100' ref='${modelNameUpperCamel}form' :rules="rule4${modelNameUpperCamel}form" inline>
                <#list colum as map>
                    <#if  map["colum"] != "creator" && map["colum"] != "createTime" && map["colum"] != "modifyTime" && map["colum"] != "modifyor" >
                <FormItem label="${map["REMARKS"]}" prop="${map["colum"]}">
                    <Input v-model='${modelNameUpperCamel}.${map["colum"]}' placeholder="请输入${map["REMARKS"]}"/>
                </FormItem>
                    </#if>
                </#list>
            </Form>
            <div slot="footer">
                <Button type="default" size="large" @click="addModal=false">取消</Button>
                <Button type="primary" size="large" @click="addoredit" style="margin-left: 8px">确认</Button>
            </div>
        </Modal>
    </Row>
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
                columnsList: [
                    {
                        title: '序号',
                        type: 'index',
                        align: 'center'
                    },
                    <#list colum as map>
                        <#if  map["colum"] != "creator" && map["colum"] != "createTime" && map["colum"] != "modifyTime" && map["colum"] != "modifyor" >
                            {
                                title: '${map["REMARKS"]}',
                                align: 'center',
                                key: '${map["colum"]}'
                            },
                        </#if>
                    </#list>
            {
                title: '操作',
                        align: 'center',
                    key: 'handle',
                    render: (h, params) => {
                return h('div', [
                    h('Button', {
                        props: {
                            // type: 'warning',
                            // // size: 'small',
                            icon: 'ios-create-outline'
                        },
                        style: {
                            marginRight: '5px'
                        },
                        on: {
                            click: () => {
                            this.openedit(params.row);
            }
            }
            }),
                h('Button', {
                    props: {
                        // type: 'error',
                        // // size: 'small',
                        icon: 'ios-trash-outline'
                    },
                    on: {
                        click: () => {
                        this.deleteitem(params.row);
            }
            }
            })
            ]);
            }
            }
        ],
            tableData: [],
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
                        this.ajax.${baseRequestMapping}add({
                            data: this.${modelNameUpperCamel},
                            method: 'post'
                        }).then((res) => {
                            if (res.result) {
                            this.$Message.success(res.description);
                            this.addModal = false;
                            this.tablePageChange();
                        } else {
                            this.$Message.error(res.description);
                        }
                    });
                    } else {
                        this.$Message.error('错误');
            }
            });
            },
            /* 修改 */
            openedit (item) {
                this.addModal = true;
                this.title = '修改**';
                this.state = 1;
                this.$refs['${modelNameUpperCamel}form'].resetFields();
                this.${modelNameUpperCamel} = JSON.parse(JSON.stringify(item));
            },
            edititem () {
                this.$refs['${modelNameUpperCamel}form'].validate((valid) => {
                    if (valid) {
                        this.ajax.${baseRequestMapping}update({
                            data: this.${modelNameUpperCamel},
                            method: 'post'
                        }).then((res) => {
                            if (res.result) {
                            this.$Message.success(res.description);
                            this.addModal = false;
                            this.tablePageChange();
                        } else {
                            this.$Message.error(res.description);
                        }
                    });
                    } else {
                        this.$Message.error('错误');
            }
            });
            },
            /* 删除 */
            deleteitem (item) {
                this.$Modal.confirm({
                            title: '',
                            content: '确定删除？',
                            onOk: () => {
                                this.ajax.${baseRequestMapping}delete({
                                    data: {
                                        <#list colum as map>
                                            <#if map["COLUM"]==KEY>
                                            '${map["colum"]}': item.${map["colum"]}
                                            </#if>
                                        </#list>
                                    },
                                    method: 'post'
                                }).then((res) => {
                                    if (res.result) {
                                    this.$Message.success(res.description);
                                    this.tablePageChange();
                                } else {
                                    this.$Message.error(res.description);
                                }
                            });
                   }
                });
            },
            /* 查询 */
            gettabledata (start = 0, length = 10) {
                this.ajax.${baseRequestMapping}pages({
                    data: {
                        'start': start,
                        'length': length
                    },
                    method: 'post'
                }).then((res) => {
                    if (res.result) {
                    this.tableData = res.obj.data;
                    this.tableTotal = res.obj.recordsTotal;
                } else {
                    this.$Message.error(res.description);
                }
            });
            },
            /* 分页 */
            tablePageChange () {
                var tablePage = this.$refs.tablePage;
                var pageSize = tablePage.currentPageSize;
                var currentPage = tablePage.currentPage;
                this.gettabledata((currentPage - 1) * pageSize, pageSize);
            }
        },
        /* 初始化 */
        created () {
            this.gettabledata();
        }
    };
</script>
