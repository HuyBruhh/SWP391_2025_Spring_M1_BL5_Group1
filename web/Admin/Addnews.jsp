<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Account" %>
<%
    Account account = (Account) session.getAttribute("user");
    if (account == null || account.getUserRole() != 4) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=Access+denied");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.png">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Add News - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/css/bootstrap.min.css" integrity="sha512-..." crossorigin="anonymous">
        <link href="${pageContext.request.contextPath}/AdminCSS/css/styles.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            .error-message {
                color: red;
                font-size: 0.9em;
            }
            .form-control:focus {
                box-shadow: none;
                background-color: rgba(255, 255, 255, 0.5);
            }
            .btn-primary:hover {
                background: #0056b3;
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand ps-3" href="${pageContext.request.contextPath}/manage">Admin</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"></form>
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Addons</div>
                            <a class="nav-link" href="${pageContext.request.contextPath}/manage">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Account
                            </a>
<!--                            <a class="nav-link" href="${pageContext.request.contextPath}/selist">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Security List
                            </a>-->
                            <a class="nav-link" href="${pageContext.request.contextPath}/displayNews">
                                <div class="sb-nav-link-icon"><i class="fas fa-newspaper"></i></div>
                                News Management
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Admin
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Add News</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/manage">Manage</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/displayNews">News Management</a></li>
                            <li class="breadcrumb-item active">Add News</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-plus me-1"></i>
                                Add New News
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/addnews" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                                    <div class="mb-3">
                                        <label for="title" class="form-label">Title</label>
                                        <input type="text" class="form-control" id="title" name="title" maxlength="100" required>
                                        <span id="titleError" class="error-message"></span>
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" name="description" rows="5" maxlength="500" required></textarea>
                                        <span id="descriptionError" class="error-message"></span>
                                    </div>
                                    <div class="mb-3">
                                        <label for="image" class="form-label">Upload Image (Optional)</label>
                                        <input id="fileInput" type="file" class="form-control" name="image" accept="image/jpeg, image/png">
                                        <span id="fileError" class="error-message"></span>
                                    </div>
                                    <div class="mb-3">
                                        <label for="createAt" class="form-label">Creation Date</label>
                                        <input type="date" class="form-control" id="createAt" name="createAt" required readonly>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                        <a href="${pageContext.request.contextPath}/displayNews" class="btn btn-secondary">Back to List</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright © Your Website 2023</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                ·
                                <a href="#">Terms & Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/AdminCSS/js/scripts.js"></script>
        <script>
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('createAt').value = today;

            function validateForm() {
                let isValid = true;
                const title = document.getElementById('title').value.trim();
                const description = document.getElementById('description').value.trim();
                const fileInput = document.getElementById('fileInput');
                const titleError = document.getElementById('titleError');
                const descriptionError = document.getElementById('descriptionError');
                const fileError = document.getElementById('fileError');

                titleError.textContent = '';
                descriptionError.textContent = '';
                fileError.textContent = '';

                if (!title) {
                    titleError.textContent = 'Title is required.';
                    isValid = false;
                } else if (title.length > 100) {
                    titleError.textContent = 'Title cannot exceed 100 characters.';
                    isValid = false;
                }

                if (!description) {
                    descriptionError.textContent = 'Description is required.';
                    isValid = false;
                } else if (description.length > 500) {
                    descriptionError.textContent = 'Description cannot exceed 500 characters.';
                    isValid = false;
                }

                if (fileInput.files && fileInput.files.length > 0) {
                    const file = fileInput.files[0];
                    const allowedTypes = ['image/jpeg', 'image/png'];
                    const maxSize = 1 * 1024 * 1024;

                    if (!allowedTypes.includes(file.type)) {
                        fileError.textContent = 'Only JPEG and PNG files are allowed.';
                        isValid = false;
                    }

                    if (file.size > maxSize) {
                        fileError.textContent = 'File size must be less than 1 MB.';
                        isValid = false;
                    }
                }

                return isValid;
            }
        </script>
    </body>
</html>