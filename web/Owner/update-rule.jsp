

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="images/favicon.png">
        <title>Rule Update</title>
        <style>
            .error-message {
                color: red;
                font-weight: bold;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" flush="true"></jsp:include>
        <div class="hero page-inner overlay" style="background-image: url('images/hero_bg_1.jpg');">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="col-lg-9 text-center mt-5">
                        <h1 class="heading" data-aos="fade-up">GuideLines</h1>
                        <nav aria-label="breadcrumb" data-aos="fade-up" data-aos-delay="200">
                            <ol class="breadcrumb text-center justify-content-center">
                                <li class="breadcrumb-item "><a href="index.html">Manager</a></li>
                                <li class="breadcrumb-item active text-white-50" aria-current="page">GuideLine</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>

        <div class="main">
            <div class="container" style="margin-top: 2em">
                <!-- Hiển thị thông báo lỗi -->
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>

                <form action="updateRule" method="post">
                    <div class="mb-3 mt-3">
                        <label for="guide-name" class="form-label">Rule Name: </label>
                        <input type="text" class="form-control" id="guideName" placeholder="Enter rule name" name="ruleName" value="${rule.ruleName}" required>
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="image-guideline" class="form-label">Image rule: </label>
                        <input type="text" class="form-control" id="img-guide" placeholder="Enter image rule" name="img" value="${rule.img}" required>
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="score-change" class="form-label">Score Change: </label>
                        <input type="number" class="form-control" id="score-change" placeholder="Enter score change" name="score" value="${rule.scoreChange}" required>
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="penalty-money" class="form-label">Penalty money: </label>
                        <input type="number" class="form-control" id="penalty-money" placeholder="Enter penalty money rule" name="penMoney" value="${rule.penMoney}" required min="0">
                    </div>
                    <input type="hidden" name="id" value="${rule.ruleID}"/>
                    <button class="btn btn-success">Update</button>
                </form>
            </div>
        </div>
    </body>
</html>