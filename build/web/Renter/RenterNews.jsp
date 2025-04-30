<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="Untree.co">
        <link rel="shortcut icon" href="favicon.png">
        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap5" />

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="fonts/icomoon/style.css">
        <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
        <link rel="stylesheet" href="css/tiny-slider.css">
        <link rel="stylesheet" href="css/aos.css">
        <link rel="stylesheet" href="css/style.css">

        <title>Property — Free Bootstrap 5 Website Template by Untree.co</title>
        <style>
            .tabular--wrapper {
                background: #fff;
                margin-top: 1rem;
                border-radius: 10px;
                padding: 2rem;
            }
            .table-container {
                width: 100%;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            thead {
                background: rgb(138, 110, 60, 0);
                color: black;
            }
            th {
                padding: 15px;
                text-align: left;
            }
            tbody {
                background: #f2f2f2;
            }
            td {
                padding: 15px;
                font-size: 14px;
                color: #333;
            }
            tr:nth-child(even) {
                background: white;
            }
            tfoot {
                background: rgba(113, 99, 186, 255);
                font-weight: bold;
                color: rgb(255, 255, 255);
            }
            tfoot td {
                padding: 15px;
            }
            .table-container button {
                color: green;
                background: none;
                cursor: pointer;
            }
            th {
                padding: 15px;
                background: none;
                cursor: pointer;
            }
            .table-container table {
                table-layout: fixed;
            }
            .table-container td {
                word-wrap: break-word;
                max-width: 200px;
            }
            .table-container th:nth-child(1),
            .table-container td:nth-child(1) {
                width: 60%;
            }
            .table-container th:nth-child(2),
            .table-container td:nth-child(2),
            .table-container th:nth-child(3),
            .table-container td:nth-child(3) {
                width: 10%;
            }
        </style>
    </head>
    <body>
        <div class="site-mobile-menu site-navbar-target">
            <div class="site-mobile-menu-header">
                <div class="site-mobile-menu-close">
                    <span class="icofont-close js-menu-toggle"></span>
                </div>
            </div>
            <div class="site-mobile-menu-body"></div>
        </div>

        <nav class="site-nav">
            <div class="container">
                <div class="menu-bg-wrap">
                    <div class="site-navigation">
                        <a href="rentercontroller?service=renterhome" class="logo m-0 float-start">News</a>
                        <jsp:include page="navbar.jsp"></jsp:include>
                        <a href="#" class="burger light me-auto float-end mt-1 site-menu-toggle js-menu-toggle d-inline-block d-lg-none" data-toggle="collapse" data-target="#main-navbar">
                            <span></span>
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="hero page-inner overlay" style="background-image: url('images/hero_bg_3.jpg');">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="col-lg-9 text-center mt-5">
                        <h1 class="heading" data-aos="fade-up">News</h1>
                        <nav aria-label="breadcrumb" data-aos="fade-up" data-aos-delay="200">
                            <ol class="breadcrumb text-center justify-content-center">
                                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                                <li class="breadcrumb-item active text-white-50" aria-current="page">News</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>

        <div class="tabular--wrapper">
            <h3 class="main--title">News</h3>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${ListN}" var="n">
                            <tr>
                                <td><a href="newsdetails?id=${n.newId}">${n.newTitle}</a></td>
                                <td>${n.userName}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="site-footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="widget">
                           expired, or there is a typo in the URL.