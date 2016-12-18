<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<head>
    <title>..::${applicationScope.projectName}::.. | <spring:message code='bidedit.title' />
    </title>
</head>
<body>
<div class="container" style="width:70%">
    <%--<jsp:include page="./../public/nav.jsp"/>--%>

    <div>

        <form id="form" class="form-horizontal" method="post" action="<%=basePath%>bid/updateBid"
              enctype="multipart/form-data" target="upLoadCustomizationCandyFrame"
        >

            <div class="form-group" style="display: none;">
                <label for="bidId" class="col-sm-2 control-label"><spring:message code='bidedit.id' /></label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="bidId" readonly=true name="bidId"
                           value="${bid.bidId}">
                </div>
            </div>

            <div class="form-group">
                <label for="tenderId" class="col-sm-2 control-label"><spring:message code='bidedit.tid' /></label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="tenderId" readonly=true name="tenderId"
                           value="${bid.tender.tenderId}">
                </div>
            </div>
            <div class="form-group">
                <label for="createTime" class="col-sm-2 control-label"><spring:message code='bidedit.time' /></label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="createTime" readonly=true name="createTime"
                           value="${bid.tender.createTime}">
                </div>
            </div>
            <div class="form-group">
                <label for="tenderName" class="col-sm-2 control-label"><spring:message code='bidedit.tname' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="tenderName" readonly=true name="tenderName"
                           placeholder="<spring:message code='bidedit.tname' />"
                           value="${bid.tender.tenderName}">
                </div>
            </div>
            <div class="form-group">
                <label for="explainContent" class="col-sm-2 control-label"><spring:message code='bidedit.exp' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="explainContent" readonly=true name="explainContent"
                           placeholder="<spring:message code='bidedit.exp' />" value="${bid.tender.explainContent}">
                </div>
            </div>
            <div class="form-group">
                <label for="state" class="col-sm-2 control-label"><spring:message code='bidedit.stat' /></label>

                <div class="col-sm-10">
                    <select id="state" name="state" class="form-control" style="width: 300px;margin-bottom: 10px;">
                        <option value="WaitForAudit"><spring:message code='bidedit.WaitForAudit' /></option>
                        <option value="Bid"><spring:message code='bidedit.Bid' /></option>
                        <option value="NotWinning"><spring:message code='bidedit.NotWinning' /></option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="pdf" class="col-sm-2 control-label"><spring:message code='bidedit.pdf' /></label>

                <div class="col-sm-10">
                    <input type="file" class="form-control" id="pdf" name="pdf" placeholder="<spring:message code='bidedit.pdf' />"
                           value="${bid.pdf}">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" class="btn btn-warning" id="update"><spring:message code='bidedit.submit' /></button>
                </div>
            </div>
        </form>
    </div>

</div>

<iframe id="upLoadCustomizationCandyFrame" name="upLoadCustomizationCandyFrame" style="display:none;">
</iframe>
</body>

<script>

    var state = '${bid.state}';
    $("#state").val(state);



    $('#update').click(function () {

        var pdf = $("#pdf").val();
        if ($("#tenderName").val() && $("#explainContent").val()) {
            if (pdf) {
                if (pdf.substring(pdf.lastIndexOf(".") + 1, pdf.length).toLocaleUpperCase() === "PDF") {
                    $('#form').submit();
                } else {
                    MSG.showErrorMsg("<spring:message code='bidedit.erremp' />");
                    return;
                }
            }
            $('#form').submit();
        } else {
            MSG.showErrorMsg("<spring:message code='bidedit.err' />");
        }

    });

    var $upLoadCustomizationCandyFrame = $("#upLoadCustomizationCandyFrame");

    $upLoadCustomizationCandyFrame.load(function () {
        var result = "<spring:message code='bidedit.errmax' /> 10M";
        try {
            result = $upLoadCustomizationCandyFrame.contents().find("body").text();
        } catch (e) {
            console.log(e);
        }
        if (result.indexOf('true-') != -1) {
            MSG.showSucceedMsg("<spring:message code='bidedit.suc' />");
            //window.open('<%=basePath%>bid/showOneBid?bidId=' + result.split("-")[1]);
        } else {
            MSG.showErrorMsg("<spring:message code='bidedit.errfail' />: " + result);
        }

    });

</script>
