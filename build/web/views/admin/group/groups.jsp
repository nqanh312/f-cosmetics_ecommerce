<%-- 
    Document   : manageCategory
    Created on : Jun 25, 2022, 8:59:54 AM
    Author     : LENOVO
--%>

<%@page import="model.product.Group"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='shortcut icon' href='assets/images/Logo.png' />
        <title>Group Admin</title>
        <%
            ArrayList<Group> groups = (ArrayList<Group>) request.getAttribute("groups");
        %>
    </head>
    <jsp:include page="../base/header.jsp" />
    <body>
        <div class="flex">
            <div class="w-64  bg-gray-50">
                <jsp:include page="../base/navbar.jsp" />
            </div>
            <div class="w-full px-20 py-5">
                <div class="mb-6">
                    <nav class="flex" aria-label="Breadcrumb">
                        <ol class="inline-flex items-center space-x-1 md:space-x-3">
                            <li class="inline-flex items-center text-xl">
                                <a href="/admin" class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-gray-900">
                                    <svg class="mr-2 w-4 h-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"></path></svg>
                                    Admin
                                </a>
                            </li>
                            <li aria-current="page">
                                <div class="flex items-center">
                                    <svg class="w-6 h-6 text-gray-400 text-xl" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <span class="ml-1 text-sm font-medium text-gray-400 md:ml-2 dark:text-gray-500">Group</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>
                <div class="mb-6">
                    <a href="/admin/group/add" class="inline-flex items-center py-2 px-4 text-sm font-medium text-center text-gray-900 bg-white rounded-lg border border-gray-300 hover:bg-gray-100 focus:ring-4 focus:ring-blue-300">Add Group</a>
                </div>
                <div class="w-full grid lg:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-6 gap-4">
                    <c:forEach items="${groups}" var="group">
                        <div class="min-w-md bg-white rounded-lg border border-gray-200 shadow-md py-8 px-6">
                            <div class="flex flex-col items-center pb-5">
                                <h3 class="mb-1 text-xl font-medium text-gray-900 text-center">${group.getName()}</h3>
                                <!--<span class="text-sm text-gray-500 text-center">id - ${group.getId()}</span>-->
                                <div class="flex mt-4 space-x-3">
                                    <a href="/admin/group/edit?id=${group.getId()}" class="inline-flex items-center py-2 px-4 text-sm font-medium text-center text-gray-900 bg-white rounded-lg border border-gray-300 hover:bg-gray-100 focus:ring-4 focus:ring-blue-300">Edit</a>
                                        <a onclick="return confirm('Are you sure you want to delete this group?');" href="/admin/group/delete?id=${group.getId()}" class="inline-flex items-center py-2 px-4 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:ring-blue-300">Delete</a>
                                    <input type="button" onclick="ConfirmDelete()">
                                                    <script>
                                                        function ConfirmDelete()
                                                        {
                                                          var x = confirm("Are you sure you want to delete this group?");
                                                          if (x)
                                                              return true;
                                                          else
                                                            return false;
                                                        }
                                                    </script>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <jsp:include page="../base/footer.jsp" />
    </body>
</html>
