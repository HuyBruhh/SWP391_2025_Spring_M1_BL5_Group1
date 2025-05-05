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

    <link rel="shortcut icon" href="./images/favicon.png">

    <!-- Google Webfonts -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="fonts/icomoon/style.css">
    <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
    <link rel="stylesheet" href="css/tiny-slider.css">
    <link rel="stylesheet" href="css/aos.css">
    <link rel="stylesheet" href="css/style.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="RenterCSS/css/animate.css">
    <!-- Icomoon Icon Fonts-->
    <link rel="stylesheet" href="RenterCSS/css/icomoon.css">
    <!-- Magnific Popup -->
    <link rel="stylesheet" href="RenterCSS/css/magnific-popup.css">
    <!-- Theme Style -->
    <link rel="stylesheet" href="RenterCSS/css/style.css">
    <!-- Modernizr JS -->
    <script src="RenterCSS/js/modernizr-2.6.2.min.js"></script>
    <!-- FOR IE9 below -->
    <!--[if lt IE 9]>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <style>
        .news-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .news-item {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 8px;
            overflow: hidden;
            transition: box-shadow 0.3s;
        }
        .news-item:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .news-img img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .news-content {
            padding: 15px;
        }
        .news-title {
            font-size: 18px;
            font-weight: 600;
            margin: 0 0 10px;
        }
        .news-title a {
            color: #333;
            text-decoration: none;
        }
        .news-title a:hover {
            color: #28a745; /* Light green for consistency */
        }
        .news-description {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .news-date {
            font-size: 12px;
            color: #999;
        }
        .search-bar {
            margin-bottom: 20px;
            text-align: center;
            padding: 10px 0;
        }
        .search-bar form {
            display: inline-block;
            width: 100%;
            max-width: 500px;
        }
        .search-bar input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .search-bar input:focus {
            border-color: #28a745; /* Light green for consistency */
            box-shadow: 0 0 8px rgba(40, 167, 69, 0.3);
        }
        .search-bar input::placeholder {
            color: #999;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .pagination a {
            display: inline-block;
            padding: 8px 16px;
            margin: 0 4px;
            text-decoration: none !important;
            color: #28a745 !important; /* Light green text */
            border: 1px solid #28a745 !important; /* Light green border */
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
        }
        .pagination a:hover {
            background-color: #e6f4ea !important; /* Very light green background on hover */
            color: #28a745 !important;
        }
        .pagination a.active {
            background-color: #28a745 !important; /* Light green background for active */
            color: white !important;
            border: 1px solid #28a745 !important;
        }
        .pagination a.disabled {
            color: #ccc !important;
            border: 1px solid #ccc !important;
            pointer-events: none;
            cursor: default;
        }
        /* Responsive Design */
        @media (max-width: 1200px) {
            .news-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 768px) {
            .news-container {
                grid-template-columns: 1fr;
            }
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

    <div class="hero page-inner overlay" style="background-image: url('images/hero_bg_1.jpg');">
        <div class="container">
            <div class="row justify-content-center align-items-center">
                <div class="col-lg-9 text-center mt-5">
                    <h1 class="heading">News</h1>
                    <nav aria-label="breadcrumb" data-aos-delay="200"></nav>
                </div>
            </div>
        </div>
    </div>

    <div id="fh5co-main">
        <div class="container">
            <div class="row">
                <!-- Search Bar -->
                <div class="search-bar">
                    <form action="ownernews" method="post">
                        <input type="text" id="searchInput" name="search" placeholder="Search news" value="${search}">
                    </form>
                </div>
                <!-- News Grid -->
                <div class="news-container">
                    <c:forEach items="${ListN}" var="n">
                        <div class="news-item">
                            <div class="news-img">
                                <a href="data:image/jpg;base64,${n.img}" class="image-popup" title="${n.description}">
                                    <img src="data:image/jpg;base64,${n.img}" alt="News Image">
                                </a>
                            </div>
                            <div class="news-content">
                                <h3 class="news-title"><a href="ownernewsdetails?id=${n.newId}">${n.newTitle}</a></h3>
                                <p class="news-description">${n.description}</p>
                                <p class="news-date">${n.createAt}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <!-- Pagination -->
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="ownernews?index=${currentPage - 1}&pageSize=${pageSize}<c:if test='${not empty search}'>&search=${search}</c:if>">Previous</a>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="ownernews?index=${i}&pageSize=${pageSize}<c:if test='${not empty search}'>&search=${search}</c:if>" class="${i == currentPage ? 'active' : ''}">${i}</a>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <a href="ownernews?index=${currentPage + 1}&pageSize=${pageSize}<c:if test='${not empty search}'>&search=${search}</c:if>">Next</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

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

    <!-- jQuery -->
    <script src="RenterCSS/js/jquery.min.js"></script>
    <!-- jQuery Easing -->
    <script src="RenterCSS/js/jquery.easing.1.3.js"></script>
    <!-- Bootstrap -->
    <script src="RenterCSS/js/bootstrap.min.js"></script>
    <!-- Waypoints -->
    <script src="RenterCSS/js/jquery.waypoints.min.js"></script>
    <!-- Magnific Popup -->
    <script src="RenterCSS/js/jquery.magnific-popup.min.js"></script>
    <!-- Main JS -->
    <script src="RenterCSS/js/main.js"></script>
    <!-- Initialize Magnific Popup and Search Function -->
    <script>
        $(document).ready(function() {
            // Initialize Magnific Popup for images
            $('.image-popup').magnificPopup({
                type: 'image',
                closeOnContentClick: true,
                mainClass: 'mfp-img-mobile',
                image: {
                    verticalFit: true,
                    titleSrc: function(item) {
                        return item.el.attr('title');
                    }
                }
            });

            // Client-side search function
            function searchNews() {
                let input = $('#searchInput').val().toLowerCase();
                let items = $('.news-item');

                items.each(function() {
                    let title = $(this).find('.news-title a').text().toLowerCase();
                    if (title.includes(input)) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            }

            // Attach keyup event to search input
            $('#searchInput').on('keyup', function() {
                if ($(this).val() === '') {
                    $(this).closest('form').submit();
                } else {
                    searchNews();
                }
            });
        });
    </script>
</body>
</html>