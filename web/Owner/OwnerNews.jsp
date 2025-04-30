<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>HL_Motel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Free HTML5 Template by FREEHTML5.CO" />
    <meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
    <meta name="author" content="FREEHTML5.CO" />

    <!-- Facebook and Twitter integration -->
    <meta property="og:title" content=""/>
    <meta property="og:image" content=""/>
    <meta property="og:url" content=""/>
    <meta property="og:site_name" content=""/>
    <meta property="og:description" content=""/>
    <meta name="twitter:title" content="" />
    <meta name="twitter:image" content="" />
    <meta name="twitter:url" content="" />
    <meta name="twitter:card" content="" />

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.png">

    <!-- Google Webfonts -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- CSS Files (context-relative paths) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/icomoon/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/flaticon/font/flaticon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tiny-slider.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/RenterCSS/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/RenterCSS/css/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slick.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/RenterCSS/css/tooplate-little-fashion.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/RenterCSS/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/RenterCSS/css/icomoon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/RenterCSS/css/magnific-popup.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/RenterCSS/css/salvattore.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/RenterCSS/css/style.css">

    <style>
        .news-card {
            margin-bottom: 30px;
            border: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .news-card:hover {
            transform: translateY(-5px);
        }
        .news-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .news-card-body {
            padding: 20px;
        }
        .news-card-title {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #333;
        }
        .news-card-text {
            font-size: 1rem;
            color: #666;
            margin-bottom: 10px;
        }
        .news-card-date {
            font-size: 0.9rem;
            color: #999;
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
                    <a href="OwnerController?service=OwnerHome" class="logo m-0 float-start">Owner</a>
                    <jsp:include page="navbar.jsp"></jsp:include>
                    <a href="#" class="burger light me-auto float-end mt-1 site-menu-toggle js-menu-toggle d-inline-block d-lg-none" data-toggle="collapse" data-target="#main-navbar">
                        <span></span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <div class="hero page-inner overlay" style="background-image: url('${pageContext.request.contextPath}/images/hero_bg_1.jpg');">
        <div class="container">
            <div class="row justify-content-center align-items-center">
                <div class="col-lg-9 text-center mt-5">
                    <h1 class="heading" data-aos="fade-up">News</h1>
                    <nav aria-label="breadcrumb" data-aos-delay="200"></nav>
                </div>
            </div>
        </div>
    </div>

    <section class="section-padding">
        <div class="container">
            <div class="row">
                <c:forEach items="${ListN}" var="n">
                    <div class="col-lg-4 col-md-6 col-12 mb-4">
                        <div class="card news-card">
                            <a href="ownernewsdetails?id=${n.newId}" class="image-popup">
                                <img src="data:image/jpg;base64,${n.img}" alt="News Image" class="card-img-top">
                            </a>
                            <div class="news-card-body">
                                <h5 class="news-card-title">${n.newTitle}</h5>
                                <p class="news-card-text">${n.description}</p>
                                <p class="news-card-date">${n.createAt}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <div class="site-footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <div class="widget">
                        <h3>Contact</h3>
                        <address>43 Raymouth Rd. Baltemoer, London 3910</address>
                        <ul class="list-unstyled links">
                            <li><a href="tel://11234567890">+1(123)-456-7890</a></li>
                            <li><a href="tel://11234567890">+1(123)-456-7890</a></li>
                            <li><a href="mailto:info@mydomain.com">info@mydomain.com</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="widget">
                        <h3>Sources</h3>
                        <ul class="list-unstyled float-start links">
                            <li><a href="#">About us</a></li>
                            <li><a href="#">Services</a></li>
                            <li><a href="#">Vision</a></li>
                            <li><a href="#">Mission</a></li>
                            <li><a href="#">Terms</a></li>
                            <li><a href="#">Privacy</a></li>
                        </ul>
                        <ul class="list-unstyled float-start links">
                            <li><a href="#">Partners</a></li>
                            <li><a href="#">Business</a></li>
                            <li><a href="#">Careers</a></li>
                            <li><a href="#">Blog</a></li>
                            <li><a href="#">FAQ</a></li>
                            <li><a href="#">Creative</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="widget">
                        <h3>Links</h3>
                        <ul class="list-unstyled links">
                            <li><a href="#">Our Vision</a></li>
                            <li><a href="#">About us</a></li>
                            <li><a href="#">Contact us</a></li>
                        </ul>
                        <ul class="list-unstyled social">
                            <li><a href="#"><span class="icon-instagram"></span></a></li>
                            <li><a href="#"><span class="icon-twitter"></span></a></li>
                            <li><a href="#"><span class="icon-facebook"></span></a></li>
                            <li><a href="#"><span class="icon-linkedin"></span></a></li>
                            <li><a href="#"><span class="icon-pinterest"></span></a></li>
                            <li><a href="#"><span class="icon-dribbble"></span></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-12 text-center">
                    <p>Copyright ©<script>document.write(new Date().getFullYear());</script>. All Rights Reserved. — Designed with love by <a href="https://untree.co">Untree.co</a></p>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript Files (context-relative paths) -->
    <script src="${pageContext.request.contextPath}/RenterCSS/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/RenterCSS/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/RenterCSS/js/Headroom.js"></script>
    <script src="${pageContext.request.contextPath}/RenterCSS/js/jQuery.headroom.js"></script>
    <script src="${pageContext.request.contextPath}/RenterCSS/js/slick.min.js"></script>
    <script src="${pageContext.request.contextPath}/RenterCSS/js/custom.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/tiny-slider.js"></script>
    <script src="${pageContext.request.contextPath}/js/aos.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script src="${pageContext.request.contextPath}/js/counter.js"></script>
    <script src="${pageContext.request.contextPath}/js/custom.js"></script>
    <script src="${pageContext.request.contextPath}/RenterCSS/js/jquery.easing.1.3.js"></script>
    <script src="${pageContext.request.contextPath}/RenterCSS/js/jquery.waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/RenterCSS/js/jquery.magnific-popup.min.js"></script>
    <script src="${pageContext.request.contextPath}/RenterCSS/js/salvattore.min.js"></script>
    <script src="${pageContext.request.contextPath}/RenterCSS/js/main.js"></script>
</body>
</html>