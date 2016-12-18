<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>..::${applicationScope.projectName}::.. | <spring:message code='tenders.alltendertitle' /></title>
    <jsp:include page="../public/datatables-bootstrap-js-css.jsp"/>
</head>
<body>
Current Locale : ${pageContext.response.locale}
<select id="state" class="form-control" style="width: 300px;margin-bottom: 10px;">
    <option value="0"><spring:message code="tenders.all" text="" /></option>
    <option value="BeingPublicized"><spring:message code="tenders.BeingPublicized" text="" /></option>
    <option value="UpcomingOpening"><spring:message code="tenders.UpcomingOpening" text="" /></option>
    <option value="Bidding"><spring:message code="tenders.Bidding" text="" /></option>
    <option value="TenderEnd"><spring:message code="tenders.TenderEnd" text="" /></option>
</select>
<div>
    <table id="showTable" class="table table-striped" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th><spring:message code="tenders.id" text="" /></th>
            <th><spring:message code="tenders.title" text="" /></th>
            <th><spring:message code="tenders.categ" text="" /></th>
            <th><spring:message code="tenders.exp" text="" /></th>
            <th><spring:message code="tenders.dt" text="" /></th>
            <th><spring:message code="tenders.op" text="" /></th>
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
            {"data": "tenderId"},
            {"data": "tenderName"},
            {"data": "stateChina"},
            {"data": "explainContent"},
            {"data": "createTime"},
            {"data": "tenderId"}
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
            },
            {
                "render": function (data, type, row) {
                    return "<button  type=\"button\" class=\"btn btn-warning btn-xs\" " +
                            "onclick=\"window.open('<%=basePath%>tender/showOneTender?tenderId=" + data + "')\"><spring:message code='tenders.showOneTender' /></button>&nbsp;&nbsp;" +

                            <c:if test="${sessionScope.get('users') != null}">
                            ((row.state === 'Bidding') ? "<button  type=\"button\" class=\"btn btn-warning btn-xs\" " +
                            "onclick=\"window.open('<%=basePath%>bid/createBidPage?tenderId=" + data + "')\"><spring:message code='tenders.createBidPage' /></button>" +
                            "&nbsp;&nbsp;" : "")
                            </c:if>


                            <c:if test="${sessionScope.get('isAdmin') != null}">
                            + "<button  type=\"button\" class=\"btn btn-danger btn-xs\" " +
                            "onclick=\"window.open('<%=basePath%>tender/goUpdatePage?tenderId=" + data + "')\"><spring:message code='tenders.goUpdatePage'/></button>" +
                            "&nbsp;&nbsp;<button type=\"button\" class=\"btn btn-danger btn-xs js-del\" tenderId=" + data + "><spring:message code='tenders.del' /></button>" +
                            </c:if>
                            "";
                },
                "orderable": false,
                "targets": 5
            }
        ]
    };


    $(function () {


        var delRegister = function () {
            $showTable.find(" tbody").on('click', 'tr .js-del', function () {
                var $2 = $(this);
                var tenderId = $2.attr("tenderId");
                $2.parent().parent().addClass("js-del-tr");
                $.ajax({
                    type: "POST",
                    url: "<%=basePath%>" + "tender/delete",
                    data: {
                        "tenderId": tenderId
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.success) {
                            table.row(".js-del-tr").remove().draw(false);
                            alert("<spring:message code='tenders.alert' />！")
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
            window.location.href = "<%=basePath%>" + "tender/goIndexPage?state=" + state;
        });
    });

</script>