<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>..::${applicationScope.projectName}::.. | <spring:message code="usercreating.title" text="tender" />
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

        <form class="form-horizontal">
            <div class="form-group">
                <label for="userName" class="col-sm-2 control-label"><spring:message code='usercreating.username' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="userName" placeholder="<spring:message code='usercreating.username' />">
                </div>
            </div>
            <div class="form-group">
                <label for="passWd" class="col-sm-2 control-label"><spring:message code='usercreating.passwd' /></label>

                <div class="col-sm-10">
                    <input type="password" class="form-control" id="passWd" placeholder="<spring:message code='usercreating.passwd' />">
                </div>
            </div>
            <div class="form-group">
                <label for="passWd" class="col-sm-2 control-label"><spring:message code='usercreating.passwdc' /></label>

                <div class="col-sm-10">
                    <input type="password" class="form-control" id="passWdConfirm" placeholder="<spring:message code='usercreating.passwdc' />">
                </div>
            </div>
            <div class="form-group">
                <label for="phone" class="col-sm-2 control-label"><spring:message code='usercreating.phone' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="phone" placeholder="<spring:message code='usercreating.phone' />">
                </div>
            </div>
            <div class="form-group">
                <label for="email" class="col-sm-2 control-label"><spring:message code='usercreating.email' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="email" placeholder="<spring:message code='usercreating.email' />">
                </div>
            </div>
            <div class="form-group">
                <label for="address" class="col-sm-2 control-label"><spring:message code='usercreating.add' /></label>

                <div class="col-sm-10">
                    <input type="text" class="form-control" id="address" placeholder="<spring:message code='usercreating.add' />">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" class="btn btn-warning" id="create"><spring:message code='usercreating.submit' /></button>
                </div>
            </div>
        </form>

    </div>
</div>


</body>
</html>

<script>


    $(function () {


        $("#create").click(function () {

            var userName = $("#userName").val();
            var passWd = $("#passWd").val();
            var passWdConfirm = $("#passWdConfirm").val();
            var phone = $("#phone").val();
            var email = $("#email").val();
            var address = $("#address").val();
            if (userName == "" || passWd == "") {
                $("#entity").modal("toggle");
                MSG.showErrorMsg("<spring:message code='usercreating.errempty' />");
                return;
            }

            $.ajax({
                type: "POST",
                url: "<%=basePath%>" + "users/createUsers",
                data: {
                    "method": "createUser",
                    "userName": userName,
                    "passWd": passWd,
                    "phone": phone,
                    "email": email,
                    "address": address
                },
                dataType: "json",
                success: function (data) {
                    if (data.success) {
                        setTimeout(window.location.href = "<%=basePath%>" + "login/goIndexPage", 3000);
                        alert("<spring:message code='usercreating.suc' />！");
                    } else {
                        MSG.showErrorMsg("<spring:message code='usercreating.err' />！");
                    }
                },
                error: function () {
                }
            });
        });
    });

</script>
