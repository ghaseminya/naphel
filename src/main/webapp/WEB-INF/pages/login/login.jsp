<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html lang="${pageContext.response.locale}">
<head>
    <title>..::${applicationScope.projectName}::.. | <spring:message code='login.title' /></title>

    <style>

        .form-signin {
            margin-top: 100px;
            max-width: 330px;
            padding: 15px;
            margin: 0 auto;
        }

        .form-signin .form-signin-heading,
        .form-signin .form-control {
            position: relative;
            height: auto;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            padding: 10px;
            font-size: 18px;
        }

        .form-signin .form-control:focus {
            z-index: 2;
        }

        .form-signin input[type="email"] {
            margin-bottom: -1px;
            border-bottom-right-radius: 0;
            border-bottom-left-radius: 0;
        }

        .form-signin input[type="password"] {
            margin-bottom: 10px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }

    </style>
</head>

<body>

<div class="container">
    <form class="form-signin">
        <h1 class="form-signin-heading" style="text-align: center;"><spring:message code='login.header' /></h1>
        <label for="userName" class="sr-only"><spring:message code='login.username' /></label>
        <input type="text" id="userName" class="form-control" placeholder="<spring:message code='login.username' />" required autofocus>
        <label for="passWd" class="sr-only"><spring:message code='login.password' /></label>
        <input type="password" id="passWd" class="form-control" placeholder="<spring:message code='login.password' />" required>
        <button class="btn btn-lg btn-primary btn-block" type="button" id="login" style="margin-top: 10px;"><spring:message code='login.submit' /></button>
    </form>
</div>

</body>
</html>
<script>

    var referer = '${Referer}';

    $(function () {

        $("#login").click(function () {

            var userName = $("#userName").val().trim();
            var passWd = $("#passWd").val().trim();
            if (userName == "" || passWd == "") {
                alert("<spring:message code='login.errempt' />");
                return;
            }

            $.ajax({
                type: "POST",
                url: "<%=basePath%>" + "login/verifyLogin",
                data: {
                    "userName": userName,
                    "passWd": passWd
                },
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    if (data.success) {
                        if (referer.indexOf('<%=basePath%>') != -1 && referer.indexOf("login/verifyLogin") == -1) {
                            window.location.href = referer;
                        } else {
                            window.location.href = "<%=basePath%>" + "home/goIndexPage";
                        }
                    } else {
                        if (data.data) {
                            MSG.showErrorMsg(data.data);
                        } else {
                            MSG.showErrorMsg("<spring:message code='login.err' />");
                        }
                    }
                }

            });
        });

    });

</script>
