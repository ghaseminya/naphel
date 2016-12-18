<%@ page import="com.gourderwa.entity.Users" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<nav>
    <ul class="nav nav-pills pull-right" id="menu">

        <li id="tenderMenu" role="presentation"><a href="<%=basePath%>tender/goIndexPage"><spring:message code='nav.tenderslist'/></a></li>

        <c:if test="${sessionScope.get('users') != null}">

            <li id="bidMenu" role="presentation"><a href="<%=basePath%>bid/goIndexPage"><spring:message code='nav.bidlist'/></a></li>
            <c:if test="${sessionScope.get('isAdmin') != null}">
                <li id="createTender" role="presentation"><a href="<%=basePath%>tender/createTenderPage"><spring:message code='nav.createtender'/></a></li>
                <li id="usersMenu" role="presentation"><a href="<%=basePath%>users/goShowAllUsersIndexPage"><spring:message code='nav.userlist'/></a>
                </li>
            </c:if>

            <li id="myMenu" role="presentation" class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"
                   aria-expanded="false">
                    <%=((Users) session.getAttribute("users")).getUserName()%> <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="<%=basePath%>users/goUpdateUsersIndexPage?usersId=<%=((Users) session.getAttribute("users")).getUserId()%>"><spring:message code='nav.updateuser'/></a>
                    </li>
                    <li id="myOrderFormMenu" role="presentation"><a
                            href="<%=basePath%>bid/goMyIndexPage"><spring:message code='nav.mybid'/></a></li>
                    <li><a href="<%=basePath%>login/loginOut"><spring:message code='nav.logout'/></a></li>
                </ul>
            </li>
        </c:if>

        <c:if test="${sessionScope.get('users') == null}">
            <li id="loginMenu" role="presentation"><a href="<%=basePath%>login/goIndexPage"><spring:message code='nav.login'/></a></li>
            <li id="registerMenu" role="presentation"><a href="<%=basePath%>users/goCreateUsersIndexPage"><spring:message code='nav.signup'/></a>
            </li>
        </c:if>

    </ul>
</nav>
<h3 class="text-muted">${applicationScope.projectName}</h3>

<script>


    var activeMenu = '${activeMenu}';
    if (activeMenu) {
        $("#menu").find("li .active").removeClass("active");
        $("#" + activeMenu).addClass("active");
    }

</script>
