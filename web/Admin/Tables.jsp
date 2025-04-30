<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <link rel="icon" href="favicon.png">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Tables - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="AdminCSS/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            .is-valid {
                border-color: #28a745 !important;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3e%3cpath fill='%2328a745' d='M2.3 6.73L.6 4.53c-.4-1.04.46-1.4 1.1-.8l1.1 1.4 3.4-3.8c.6-.63 1.6-.27 1.2.7l-4 4.6c-.43.5-.8.4-1.1.1z'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right calc(.375em + .1875rem) center;
                background-size: calc(.75em + .375rem) calc(.75em + .375rem);
                padding-right: calc(1.5em + .75rem);
            }
            
            .is-invalid {
                border-color: #dc3545 !important;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='%23dc3545' viewBox='-2 -2 7 7'%3e%3cpath stroke='%23dc3545' d='M0 0l3 3m0-3L0 3'/%3e%3ccircle r='.5'/%3e%3ccircle cx='3' r='.5'/%3e%3ccircle cy='3' r='.5'/%3e%3ccircle cx='3' cy='3' r='.5'/%3e%3c/svg%3E");
                background-repeat: no-repeat;
                background-position: right calc(.375em + .1875rem) center;
                background-size: calc(.75em + .375rem) calc(.75em + .375rem);
                padding-right: calc(1.5em + .75rem);
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="manage">Admin</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="logout">Logout</a></li>
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
                            <a class="nav-link" href="manage">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Account
                            </a>
<!--                            <a class="nav-link" href="selist">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Security List
                            </a>-->
                            <a class="nav-link" href="displayNews">
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
                        <h1 class="mt-4">Tables</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="manage">Manage</a></li>
                            <li class="breadcrumb-item active">Account</li>
                        </ol>

                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Manage Account
                            </div>
                            <div class="card-body">
                                <!-- Hiển thị thông báo thành công nếu có -->
                                <c:if test="${not empty sessionScope.successMessage}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        ${sessionScope.successMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        <% session.removeAttribute("successMessage"); %>
                                    </div>
                                </c:if>

                                <br>
                                <table id="datatablesSimple" border="1">
                                    <thead>
                                        <th>Mail</th>
<!--                                        <th>Password</th>-->
                                        <th>Role</th>
                                        <th>Action</th>
                                    </thead>
                                    <c:forEach var="acc" items="${account}">
                                        <tr>
                                            <td>${acc.userMail}</td>
<!--                                            <td>${acc.userPassword}</td>-->
                                            <td><c:if test="${acc.userRole == 1}">
                                                    Renter
                                                </c:if>
                                                <c:if test="${acc.userRole == 2}">
                                                    Owner
                                                </c:if>
                                                <c:if test="${acc.userRole == 3}">
                                                    Security
                                                </c:if>
                                                <c:if test="${acc.userRole == 4}">
                                                    Admin
                                                </c:if>
                                                <c:if test="${acc.userRole == 0}">
                                                    DeActive
                                                </c:if></td>
                                            <td>
<!--                                                <a href="#" onclick="setModalFields('${acc.userMail}', '${acc.userRole}')" data-bs-toggle="modal" data-bs-target="#editModal" style="margin-right: 10px">
                                                    <i class="fa-regular fa-pen-to-square"></i>
                                                </a>-->
                                                <a href="changeRole?email=${acc.userMail}" onclick="return confirm('Are you sure you want to ban this user?')">DeActive</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- Edit Modal -->
                    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editModalLabel">Edit Account</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <c:if test="${not empty sessionScope.errorMessage}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            ${sessionScope.errorMessage}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                            <% session.removeAttribute("errorMessage"); %>
                                        </div>
                                    </c:if>
                                    <form id="editAccountForm" action="edac" method="post">
                                        <div class="form-group mb-3">
                                            <label for="emailInput" class="form-label">Email address</label>
                                            <input type="email" name="email" class="form-control" id="emailInput" value="${sessionScope.editEmail}" readonly>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="passwordInput" class="form-label">Password:</label>
                                            <input type="password" name="password" class="form-control" id="passwordInput" required>
                                            <div class="form-text">
                                                Password must contain at least 8 characters, including at least one letter, one number, and one special character (!@#$%^&*).
                                            </div>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="roleInput" class="form-label">Role:</label>
                                            <select class="form-select" name="role" id="roleInput" required>
                                                <option value="1" ${sessionScope.editRole == '1' ? 'selected' : ''}>Renter</option>
                                                <option value="2" ${sessionScope.editRole == '2' ? 'selected' : ''}>Owner</option>
                                                <option value="3" ${sessionScope.editRole == '3' ? 'selected' : ''}>Security</option>
                                                <option value="4" ${sessionScope.editRole == '4' ? 'selected' : ''}>Admin</option>
                                            </select>
                                        </div>
                                        <div class="mt-3">
                                            <button type="submit" class="btn btn-primary" name="save">Save Changes</button>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Add Account Modal -->
                    <div class="modal fade" id="addAccountModal" tabindex="-1" role="dialog" aria-labelledby="addAccountModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addAccountModalLabel">Add Account</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form id="addAccountForm" action="addAccount" method="get">
                                        <div class="form-group mb-3">
                                            <label for="addEmailInput" class="form-label">Email address</label>
                                            <input type="email" name="email" class="form-control" id="addEmailInput" required>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="addPasswordInput" class="form-label">Password</label>
                                            <input type="password" name="password" class="form-control" id="addPasswordInput" required>
                                            <div class="form-text">
                                                Password must contain at least 8 characters, including at least one letter, one number, and one special character (!@#$%^&*).
                                            </div>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="addRoleInput" class="form-label">Role</label>
                                            <select class="form-select" name="role" id="addRoleInput" required>
                                                <option value="1">Renter</option>
                                                <option value="2">Owner</option>
                                                <option value="3">Security</option>
                                                <option value="4">Admin</option>
                                            </select>
                                        </div>
                                        <button type="submit" value="Add" name="add" class="btn btn-primary">Add Account</button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
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
        <script src="AdminCSS/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="AdminCSS/js/datatables-simple-demo.js"></script>
        
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Kiểm tra nếu có lỗi thì hiển thị modal
                <% if (session.getAttribute("errorMessage") != null) { %>
                    var editModal = new bootstrap.Modal(document.getElementById('editModal'));
                    editModal.show();
                <% } %>
                
                // Kiểm tra mật khẩu khi người dùng nhập
                var passwordInput = document.getElementById('passwordInput');
                if (passwordInput) {
                    passwordInput.addEventListener('input', function() {
                        validatePassword(this);
                    });
                }
                
                var addPasswordInput = document.getElementById('addPasswordInput');
                if (addPasswordInput) {
                    addPasswordInput.addEventListener('input', function() {
                        validatePassword(this);
                    });
                }
            });
            
            function validatePassword(input) {
                var password = input.value;
                var regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$/;
                var isValid = regex.test(password);
                
                if (password.length > 0) {
                    if (isValid) {
                        input.classList.remove('is-invalid');
                        input.classList.add('is-valid');
                    } else {
                        input.classList.remove('is-valid');
                        input.classList.add('is-invalid');
                    }
                } else {
                    input.classList.remove('is-valid');
                    input.classList.remove('is-invalid');
                }
            }
            
            function setModalFields(email, role) {
                document.getElementById('emailInput').value = email;
                document.getElementById('roleInput').value = role;
                sessionStorage.setItem('editEmail', email);
                sessionStorage.setItem('editRole', role);
            }
            
            window.onload = function() {
                const storedEmail = sessionStorage.getItem('editEmail');
                const storedRole = sessionStorage.getItem('editRole');
                
                if (storedEmail) {
                    document.getElementById('emailInput').value = storedEmail;
                }
                if (storedRole) {
                    document.getElementById('roleInput').value = storedRole;
                }
            };
        </script>
    </body>
</html>