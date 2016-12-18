<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<head>
    <title>..::${applicationScope.projectName}::.. | <spring:message code="tendersupdate.title" text="tender" />
    </title>
</head>
<body>
<div class="container" style="width:70%">
    <%--<jsp:include page="./../public/nav.jsp"/>--%>

    <div>

        <form id="form" class="form-horizontal" method="post" action="<%=basePath%>tender/updateTender"
              enctype="multipart/form-data" target="upLoadCustomizationCandyFrame"
        >

            <div class="form-group">
                <label for="tenderId" class="col-sm-2 control-label"><spring:message code='tendersupdate.id' /></label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="tenderId" readonly=true name="tenderId"
                           value="${tender.tenderId}">
                </div>
            </div>
            <div class="form-group">
                <label for="createTime" class="col-sm-2 control-label"><spring:message code='tendersupdate.time' /></label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="createTime" readonly=true name="createTime"
                           value="${tender.createTime}">
                </div>
            </div>
            <div class="form-group">
                <label for="tenderName" class="col-sm-2 control-label"><spring:message code='tendersupdate.stat' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="tenderName" name="tenderName" placeholder="<spring:message code='tendersupdate.stat' />"
                           value="${tender.tenderName}">
                </div>
            </div>
            <div class="form-group">
                <label for="explainContent" class="col-sm-2 control-label"><spring:message code='tendersupdate.exp' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="explainContent" name="explainContent"
                           placeholder="<spring:message code='tendersupdate.exp' />" value="${tender.explainContent}">
                </div>
            </div>
            <div class="form-group">
                <label for="explainContent" class="col-sm-2 control-label"><spring:message code='tendersupdate.stat' /></label>

                <div class="col-sm-10">
                    <select id="state" name="state" class="form-control" style="width: 300px;margin-bottom: 10px;">
                        <option value="BeingPublicized"><spring:message code='tendersupdate.sBeingPublicized' /></option>
                        <option value="UpcomingOpening"><spring:message code='tendersupdate.sUpcomingOpening' /></option>
                        <option value="Bidding"><spring:message code='tendersupdate.sBidding' /></option>
                        <option value="TenderEnd"><spring:message code='tendersupdate.sTenderEnd' /></option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="pdf" class="col-sm-2 control-label"><spring:message code='tenderscreate.pdf' /><</label>

                <div class="col-sm-10">
                    <input type="file" class="form-control" id="pdf" name="pdf" placeholder="<spring:message code='tenderscreate.pdf' /><"
                           value="${tender.pdf}">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" class="btn btn-warning" id="update"><spring:message code='tendersupdate.submit' /></button>
                </div>
            </div>
        </form>
    </div>

</div>

<iframe id="upLoadCustomizationCandyFrame" name="upLoadCustomizationCandyFrame" style="display:none;">
</iframe>
</body>

<script>

    var state = '${tender.state}';
    $("#state").val(state);



    $('#update').click(function () {

        var pdf = $("#pdf").val();
        if ($("#tenderName").val() && $("#explainContent").val()) {
            if (pdf) {
                if (pdf.substring(pdf.lastIndexOf(".") + 1, pdf.length).toLocaleUpperCase() === "PDF") {
                    $('#form').submit();
                } else {
                    MSG.showErrorMsg("<spring:message code='tenderscreate.msgerr' />");
                    return;
                }
            }
            $('#form').submit();
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
            //window.open('<%=basePath%>tender/showOneTender?tenderId=' + result.split("-")[1]);
        } else {
            MSG.showErrorMsg("<spring:message code='tenderscreate.msgerropf' />: " + result);
        }

    });

</script>
