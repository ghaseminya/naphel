<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>..::${applicationScope.projectName}::.. | <spring:message code='useredit.title'/>
    </title>
</head>
<body>
<div class="container" style="width:70%">
    <%--<jsp:include page="./../public/nav.jsp"/>--%>
    <div>

        <form class="form-horizontal">

            <span style="display:none" id="userId" readonly>${updateUsers.userId}</span>
            <div class="form-group">
                <label for="userName" class="col-sm-2 control-label"><spring:message code='usercreating.username'/></label>

                <div class="col-sm-10">

                    <input type="text" class="form-control" id="userName" readonly=true
                           value="${updateUsers.userName}">
                </div>
            </div>
            <div class="form-group">
                <label for="passWd" class="col-sm-2 control-label"><spring:message code='usercreating.passwd'/></label>

                <div class="col-sm-10">
                    <input type="password" class="form-control" id="passWd" placeholder="<spring:message code='usercreating.passwd'/>"
                           value="${updateUsers.passWd}">
                </div>
            </div>
            <div class="form-group">
                <label for="phone" class="col-sm-2 control-label"><spring:message code='usercreating.phone'/></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="phone" placeholder="<spring:message code='usercreating.phone'/>" value="${updateUsers.phone}">
                </div>
            </div>
            <div class="form-group">
                <label for="email" class="col-sm-2 control-label"><spring:message code='usercreating.email'/></label>

                <div class="col-sm-10">
                    <input type="email" class="form-control" id="email" placeholder="<spring:message code='usercreating.email'/>" value="${updateUsers.email}">
                </div>
            </div>
            <div class="form-group">
                <label for="address" class="col-sm-2 control-label"><spring:message code='usercreating.add'/></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="address" placeholder="<spring:message code='usercreating.add'/>"
                           value="${updateUsers.address}">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" class="btn btn-warning" id="update"><spring:message code='userall.update'/></button>
                </div>
            </div>
        </form>

    </div>
</div>


</body>
</html>

<script>
    $(function () {

        var $userName = $("#userName");
        if ($userName.val() === 'admin') {
            $userName.attr("readonly", true);
        }
        $("#update").click(function () {
            var userId = '${updateUsers.userId}';
            var userName = $("#userName").val();
            var passWd = $("#passWd").val();
            var phone = $("#phone").val();
            var email = $("#email").val();
            var address = $("#address").val();
            if (userName == "" || passWd == "") {
                $("#entity").modal("toggle");
                MSG.showErrorMsg("<spring:message code='usercreating.errempty'/>");
                return;
            }

            $.ajax({
                type: "POST",
                url: "<%=basePath%>" + "users/updateUser",
                data: {
                    "method": "updateUser",
                    "userId": userId,
                    "userName": userName,
                    "passWd": passWd,
                    "phone": phone,
                    "email": email,
                    "address": address
                },
                dataType: "json",
                success: function (data) {
                    if (data.success) {
                        MSG.showSucceedMsg("<spring:message code='useredit.err'/>！");
                    } else {
                        MSG.showErrorMsg("<spring:message code='useredit.suc'/>！");
                    }
                }
            });
        });
    });

</script>
