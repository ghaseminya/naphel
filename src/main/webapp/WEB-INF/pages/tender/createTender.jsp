<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<head>
    <title>发..::${applicationScope.projectName}::.. | <spring:message code="tenderscreate.createtitle" text="tender" />
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

        <form id="form" class="form-horizontal" method="post" action="<%=basePath%>tender/createTender"
              enctype="multipart/form-data" target="upLoadCustomizationCandyFrame"
        >
            <div class="form-group">
                <label for="tenderName" class="col-sm-2 control-label"><spring:message code="tenderscreate.nameofbid" text="tender" /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="tenderName" name="tenderName" placeholder="<spring:message code='tenderscreate.nameofbid' />">
                </div>
            </div>
            <div class="form-group">
                <label for="explainContent" class="col-sm-2 control-label"><spring:message code='tenderscreate.content' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="explainContent" name="explainContent"
                           placeholder="<spring:message code='tenderscreate.content' />">
                </div>
            </div>
            <div class="form-group">
                <label for="pdf" class="col-sm-2 control-label"><spring:message code='tenderscreate.pdf' /></label>

                <div class="col-sm-10">
                    <input type="file" class="form-control" id="pdf" name="pdf" placeholder="<spring:message code='tenderscreate.pdf' />">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" class="btn btn-warning" id="create"><spring:message code='tenderscreate.submit' /></button>
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
                MSG.showErrorMsg("<spring:message code='tenderscreate.msgerr' />");
            }
        } else {
            MSG.showErrorMsg("<spring:message code='tenderscreate.msgerrinc' />");
        }

    });

    var $upLoadCustomizationCandyFrame = $("#upLoadCustomizationCandyFrame");

    $upLoadCustomizationCandyFrame.load(function () {
        var result = "<spring:message code='tenderscreate.msgerrmax' /> 10M";
        try {
            result = $upLoadCustomizationCandyFrame.contents().find("body").text();
        } catch (e) {
            console.log(e);
        }
        if (result.indexOf('true-') != -1) {
            MSG.showSucceedMsg("<spring:message code='tenderscreate.msgsuc' />");
            window.close();
            window.location.href = '<%=basePath%>tender/showOneTender?tenderId=' + result.split("-")[1];
        } else {
            MSG.showErrorMsg("<spring:message code='tenderscreate.msgerropf' />: " + result);
        }

    });

</script>

