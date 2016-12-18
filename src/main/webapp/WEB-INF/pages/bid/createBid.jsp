<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<head>
    <title>..::${applicationScope.projectName}::.. | <spring:message code='bidcreate.title' />
    </title>
    <style>

        .col-sm-10 {
            max-width: 330px;
        }


    </style>
</head>
<body>
<div class="container" style="width:70%">
    <%--<jsp:include page="./../public/nav.jsp"/>--%>
    <div>


        <form id="form" class="form-horizontal" method="post" action="<%=basePath%>bid/createBid"
              enctype="multipart/form-data" target="upLoadCustomizationCandyFrame"
        >

            <div class="form-group">
                <label for="tenderId" class="col-sm-2 control-label"><spring:message code='bidcreate.item' /></label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="tenderId" readonly=true name="tenderId"
                           value="${tender.tenderId}">
                </div>
            </div>
            <div class="form-group">
                <label for="createTime" class="col-sm-2 control-label"><spring:message code='bidcreate.time' /></label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="createTime" readonly=true name="createTime"
                           value="${tender.createTime}">
                </div>
            </div>
            <div class="form-group">
                <label for="tenderName" class="col-sm-2 control-label"><spring:message code='bidcreate.name' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="tenderName" readonly=true name="tenderName"
                           placeholder="<spring:message code='bidcreate.name' />"
                           value="${tender.tenderName}">
                </div>
            </div>
            <div class="form-group">
                <label for="explainContent" class="col-sm-2 control-label"><spring:message code='bidcreate.desc' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="tenderExplainContent" readonly=true
                           name="explainContent"
                           placeholder="<spring:message code='bidcreate.desc' />" value="${tender.explainContent}">
                </div>
            </div>


            <div class="form-group">
                <label for="explainContent" class="col-sm-2 control-label"><spring:message code='bidcreate.tdesc' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="explainContent" name="explainContent"
                           placeholder="<spring:message code='bidcreate.tdesc' />">
                </div>
            </div>
            <div class="form-group">
                <label for="pdf" class="col-sm-2 control-label"><spring:message code='bidcreate.pdf' /></label>

                <div class="col-sm-10">
                    <input type="file" class="form-control" id="pdf" name="pdf" placeholder="<spring:message code='bidcreate.pdf' />">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" class="btn btn-warning" id="create"><spring:message code='bidcreate.submit' /></button>
                </div>
            </div>
        </form>
    </div>
</div>
<iframe id="upLoadCustomizationCandyFrame" name="upLoadCustomizationCandyFrame" style="display:none;">
</iframe>
</body>

<script>


    $('#create').click(function () {

        var pdf = $("#pdf").val();
        if ($("#tenderName").val() && $("#explainContent").val() && pdf) {
            if (pdf.substring(pdf.lastIndexOf(".") + 1, pdf.length).toLocaleUpperCase() === "PDF") {
                $('#form').submit();
            } else {
                MSG.showErrorMsg("<spring:message code='bidcreate.erremp' />");
            }
        } else {
            MSG.showErrorMsg("<spring:message code='bidcreate.err' />");
        }

    });

    var $upLoadCustomizationCandyFrame = $("#upLoadCustomizationCandyFrame");
    $upLoadCustomizationCandyFrame.load(function () {
        var result = "<spring:message code='bidcreate.errmax' /> 10M";
        try {
            result = $upLoadCustomizationCandyFrame.contents().find("body").text();
        } catch (e) {
            console.log(e);
        }
        if (result.indexOf('true-') != -1) {
            MSG.showSucceedMsg("<spring:message code='bidcreate.suc' />");
            window.location.href = '<%=basePath%>bid/showOneBid?bidId=' + result.split("-")[1];
        } else {
            MSG.showErrorMsg("<spring:message code='bidcreate.err' />: " + result);
        }

    });

</script>

