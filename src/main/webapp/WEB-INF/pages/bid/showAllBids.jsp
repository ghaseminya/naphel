<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>..::${applicationScope.projectName}::.. | <spring:message code='bidall.title' /></title>
    <jsp:include page="../public/datatables-bootstrap-js-css.jsp"/>
</head>
<body>
<select id="state" class="form-control" style="width: 300px;margin-bottom: 10px;">
    <option value="0"><spring:message code='bidall.all' /></option>
    <option value="WaitForAudit"><spring:message code='bidall.WaitForAudit' /></option>
    <option value="Bid"><spring:message code='bidall.win' /></option>
    <option value="NotWinning"><spring:message code='bidall.NotWinning' /></option>
</select>
<div>
    <table id="showTable" class="table table-striped" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th><spring:message code='bidall.itemno' /></th>
            <th><spring:message code='bidall.tendername' /></th>
            <th><spring:message code='bidall.serviceprovider' /></th>
            <th><spring:message code='bidall.stat' /></th>
            <th><spring:message code='bidall.desc' /></th>
            <th><spring:message code='bidall.time' /></th>
            <th><spring:message code='bidall.op' /></th>
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
            {"data": "bidId"},
            {"data": "tender.tenderName"},
            {"data": "users.userName"},
            {"data": "stateChina"},
            {"data": "explainContent"},
            {"data": "createTime"},
            {"data": "bidId"}
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
                    return data;
                },
                "targets": 3
            }, {
                "render": function (data, type, row) {
                    return data;
                },
                "targets": 4
            }, {
                "render": function (data, type, row) {
                    return data;
                },
                "targets": 5
            },
            {
                "render": function (data, type, row) {
                    return "<button  type=\"button\" class=\"btn btn-warning btn-xs\" " +
                            "onclick=\"window.open('<%=basePath%>bid/showOneBid?bidId=" + data + "')\"><spring:message code='bidall.look' /></button>&nbsp;&nbsp;"
                            <c:if test="${sessionScope.get('isAdmin') != null}">
                            + "<button  type=\"button\" class=\"btn btn-warning btn-xs\" " +
                            "onclick=\"window.open('<%=basePath%>bid/goUpdatePage?bidId=" + data + "')\"><spring:message code='bidall.modify' /></button>" +
                            "&nbsp;&nbsp;<button type=\"button\" class=\"btn btn-danger btn-xs js-del\" bidId=" + data + "><spring:message code='bidall.del' /></button>"
                            </c:if>
                            ;
                },
                "orderable": false,
                "targets": 6
            }
        ]
    };


    $(function () {


        var delRegister = function () {
            $showTable.find(" tbody").on('click', 'tr .js-del', function () {
                var $2 = $(this);
                var tenderId = $2.attr("bidId");
                $2.parent().parent().addClass("js-del-tr");
                $.ajax({
                    type: "POST",
                    url: "<%=basePath%>" + "bid/delete",
                    data: {
                        "tenderId": tenderId
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.success) {
                            table.row(".js-del-tr").remove().draw(false);
                            alert("<spring:message code='bidall.suc' />！")
                        } else {
                            MSG.showErrorMsg(data.data);
                        }
                    }
                });

            });
        };


        dataTableSetting.data = eval('${tenders}');
        table = $showTable.DataTable(dataTableSetting);
        delRegister();

        var settingState = '${state}';
        if (settingState) {
            $("#state").val(settingState);
        } else {
            $("#state").val("0");
        }
        $("#state").on("change", function () {
            var state = $(this).val();
            window.location.href = "<%=basePath%>" + "bid/goIndexPage?state=" + state;
        });
    });

</script>
