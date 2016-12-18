<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>..::${applicationScope.projectName}::.. | <spring:message code='userall.title'/></title>
    <jsp:include page="../public/datatables-bootstrap-js-css.jsp"/>
</head>
<body>

<div>
    <%--<button style="float: right;margin-bottom: 10px;" type="button" class="btn btn-info"
            onclick="window.location.href='<%=basePath%>pages/users/goCreateUsersIndexPage'"
    ><spring:message code='userall.new'/>
    </button>--%>

    <table id="showTable" class="table table-striped" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th><spring:message code='usercreating.username'/></th>
            <th><spring:message code='usercreating.phone'/></th>
            <th><spring:message code='usercreating.email'/></th>
            <th><spring:message code='userall.op'/></th>
        </tr>
        </thead>
    </table>
</div>
</body>
</html>

<script>

    var $showTable = $("#showTable");
    var table;

    var dataTableSetting = {

        "language": {
                                "sProcessing": "<spring:message code='tenders.processing' />...",
                                "lengthMenu": "<spring:message code='tenders.menuf' /> _MENU_ <spring:message code='tenders.menurec' />",
                                "zeroRecords": "<spring:message code='tenders.nodata' />",
                                "info": "_PAGE_ / _PAGES_",
                                "infoEmpty": "<spring:message code='tenders.nodata' />",
                                "infoFiltered": "(<spring:message code='tenders.ttn' /> _MAX_ <spring:message code='tenders.art' />)",
                                "search": "<spring:message code='tenders.search' />",
                                "sLoadingRecords": "<spring:message code='tenders.loading' />...",
                                "oPaginate": {
                                    "sNext": ">",
                                    "sPrevious": "<"
                                }
        },
        "columns": [
            {"data": "userName"},
            {"data": "phone"},
            {"data": "email"},
            {"data": "userId"}
        ],
        "columnDefs": [
            {
                "render": function (data, type, row) {
                    return data;
                },
                "targets": 0
            },
            {
                "render": function (data, type, row) {
                    return data;
                },
                "targets": 1
            },
            {
                "render": function (data, type, row) {
                    return data;
                },
                "targets": 2
            },

            {
                "render": function (data, type, row) {
                    return "<button  type=\"button\" class=\"btn btn-warning btn-xs\" " +
                            "onclick=\"window.location.href ='<%=basePath%>users/goUpdateUsersIndexPage?usersId=" + data + "'\"><spring:message code='userall.update'/></button>" +
                            "&nbsp;&nbsp;<button type=\"button\" class=\"btn btn-danger btn-xs js-del\" usersId=" + data + "><spring:message code='userall.del'/></button>";
                },
                "orderable": false,
                "targets": 3
            }
        ]
    };


    $(function () {


        var delRegister = function () {
            $showTable.find(" tbody").on('click', 'tr .js-del', function () {
                var $2 = $(this);
                var usersId = $2.attr("usersId");
                $2.parent().parent().addClass("js-del-tr");
                $.ajax({
                    type: "POST",
                    url: "<%=basePath%>" + "users/deleteUser",
                    data: {
                        "usersId": usersId
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.success) {
                            table.row(".js-del-tr").remove().draw(false);
                            alert("<spring:message code='userall.suc'/>！")
                        } else {
                            MSG.showErrorMsg(data.data);
                        }
                    }
                });

            });
        };


        $.ajax({
            type: "POST",
            url: "<%=basePath%>" + "users/searchUsers",
            data: {},
            dataType: "json",
            success: function (data) {
                console.log(data);
                dataTableSetting.data = data.data;
                table = $showTable.DataTable(dataTableSetting);
                delRegister();
            }
        });

    });

</script>
