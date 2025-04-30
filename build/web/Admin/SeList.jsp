<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.png">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Security List - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/css/bootstrap.min.css" integrity="sha512-..." crossorigin="anonymous">
        <link href="${pageContext.request.contextPath}/AdminCSS/css/styles.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/selist">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Security List
                            </a>
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
                        <h1 class="mt-4">Security List</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/manage">Manage</a></li>
                            <li class="breadcrumb-item active">Security List</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Manage Security
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple" class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Shift</th>
                                            <th>Department</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="o" items="${list}">
                                            <tr>
                                                <td>${o.seID}</td>
                                                <td>${o.userName}</td>
                                                <c:choose>
                                                    <c:when test="${o.xShift == 1}">
                                                        <td>Day</td>
                                                    </c:when>
                                                    <c:when test="${o.xShift == 2}">
                                                        <td>Night</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>None</td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td>${o.department}</td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/selctseup?seID=${o.seID}" class="btn btn-sm btn-primary">Change Shift</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editModalLabel">Edit Account</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <c:if test="${not empty errorMessage}">
                                        <div class="alert alert-danger">${errorMessage}</div>
                                    </c:if>
                                    <form id="editAccountForm" action="${pageContext.request.contextPath}/edac" method="post">
                                        <div class="mb-3">
                                            <label for="emailInput" class="form-label">Email address</label>
                                            <input type="email" name="email" class="form-control" id="emailInput" aria-describedby="emailHelp">
                                        </div>
                                        <div class="mb-3">
                                            <label for="passwordInput" class="form-label">Password</label>
                                            <input type="password" name="password" placeholder="Abcdefg1" class="form-control" id="passwordInput" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="roleInput" class="form-label">Role</label>
                                            <input type="number" name="role" placeholder="Role: 1,2,3" class="form-control" id="roleInput" required>
                                        </div>
                                        <button type="submit" name="save" class="btn btn-primary">Save</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="addAccountModal" tabindex="-1" aria-labelledby="addAccountModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addAccountModalLabel">Add Account</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form id="addAccountForm" action="${pageContext.request.contextPath}/addAccount" method="get">
                                        <div class="mb-3">
                                            <label for="addEmailInput" class="form-label">Email address</label>
                                            <input type="email" name="email" class="form-control" id="addEmailInput" aria-describedby="emailHelp" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="addPasswordInput" class="form-label">Password</label>
                                            <input type="password" name="password" placeholder="Abcdefg1" class="form-control" id="addPasswordInput" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="addRoleInput" class="form-label">Role</label>
                                            <input type="number" name="role" placeholder="Role: 1,2,3" class="form-control" id="addRoleInput" required>
                                        </div>
                                        <button type="submit" name="add" class="btn btn-primary">Add</button>
                                    </form>
                                </div>
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
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/AdminCSS/js/datatables-simple-demo.js"></script>
        <script>
            <% if (request.getAttribute("errorMessage") != null) { %>
            $('#editModal').modal('show');
            <% } %>

            $(document).ready(function () {
                $('#editModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    var email = button.data('email');
                    var password = button.data('password');
                    var role = button.data('role');

                    var modal = $(this);
                    modal.find('.modal-body #emailInput').val(email);
                    modal.find('.modal-body #passwordInput').val(password);
                    modal.find('.modal-body #roleInput').val(role);
                });
                $('#addAccountModal').on('show.bs.modal', function (event) {
                    var modal = $(this);
                    modal.find('.modal-body').find('input').val('');
                });
            });
        </script>
    </body>
</html>