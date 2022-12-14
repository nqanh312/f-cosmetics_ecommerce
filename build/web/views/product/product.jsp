<%-- 
    Document   : product
    Created on : Jun 24, 2022, 5:07:24 PM
    Author     : LENOVO
--%>

<%@page import="model.product.Category"%>
<%@page import="model.common.Pagination"%>
<%@page import="model.product.Product"%>
<%@page import="model.product.Group"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='shortcut icon' href='assets/images/Logo.png' />
        <title>Product Page</title>
        <%
            ArrayList<Group> groups = (ArrayList<Group>) request.getAttribute("groups");
            ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products");
            Pagination pagination = (Pagination) request.getAttribute("pagination");
            ArrayList<Category> categorys = (ArrayList<Category>) request.getAttribute("categorys");
        %>
    </head>
    <style>
        .sold-out-overlay {
            background: #4ea384;
            color: #fff;
            font-size: 14px;
            font-weight: 600;
            padding: 5px 10px;
            position: absolute;
            left: 0;
            top: 1px;
            width: 98px;
            height: 45px;
            line-height: 32px;
            display: flex;
            justify-content: center;
            border-radius: 2px
        }
    </style>

    <body>
        <jsp:include page="../base/header.jsp" />
        <div class="container flex mx-auto mt-10">
            <div class="shrink-0 hidden md:block w-75">
                <div>
                    <div class=" w-full text-sm font-medium text-gray-900 bg-white py-2 px-3">
                        <h3 class="uppercase text-xl block py-3 px-4 w-full font-semibold border-b border-dashed border-gray-200 focus:outline-none focus:ring-2 focus:ring-blue-700 focus:text-blue-700">
                            GROUP
                        </h3>
                        <a href="/" class="uppercase block py-3 px-4 w-full font-small border-b border-dashed border-gray-200 cursor-pointer hover:bg-gray-100 hover:text-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-700 focus:text-blue-700">
                            HOME
                        </a>
                        <a href="/products" class="uppercase block py-3 px-4 w-full font-small border-b border-dashed border-gray-200 cursor-pointer hover:bg-gray-100 hover:text-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-700 focus:text-blue-700">
                            ALL
                        </a>
                        <c:forEach items="${groups}" var="group">
                            <a href="/products?group=${group.getId()}" class="uppercase block py-3 px-4 w-full font-small border-b border-dashed border-gray-200 cursor-pointer hover:bg-gray-100 hover:text-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-700 focus:text-blue-700">
                                ${group.getName()}
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="w-full p-5">
                <div class="w-full flex items-center mb-4 ">
                    <div>
                        <form action="/products" method="GET" class="flex items-center flex-wrap">
                            <div class="relative mt-1 my-2 ">
                                <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                    <svg class="w-5 h-5 text-gray-500 ml-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path></svg>
                                </div>
                                <input type="text" name="q" id="search" class="ml-3 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-80 sm:w-full pl-10 p-2.5" placeholder="Search for items">
                            </div>
                            <select id="group" name="group" class=" my-2 ml-3  bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-80 sm:w-full p-2.5">
                                <option value="all">Group</option>
                                <c:forEach items="${groups}" var="group">
                                    <option value="${group.id}">${group.getName()}</option>
                                </c:forEach>
                            </select>
                            <select id="category" name="category" class=" my-2 ml-3 w-80 sm:w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                                <option value="all">Category</option>
                            </select>
                            <select id="countries" name="arrange" class=" my-2 ml-3  bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-80 sm:w-full p-2.5">
                                <option class="py-2 px-3">Sort</option>
                                <option class="py-2 px-3" value="ASC" >Price: ascending</option>
                                <option class="py-2 px-3" value="DESC" >Price: descending</option>
                                <option class="py-2 px-3" value="Newest">Newest</option>
                                <option class="py-2 px-3" value="Oldest">Oldest</option>
                            </select>

                            <button type="submit" class="my-2 ml-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm w-80 sm:w-full sm:w-auto px-5 py-2.5 text-center">search</button>
                        </form>
                    </div>
                    <!--                    <div class="ml-auto">
                                            <select id="countries" class="min-w-[200px] bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                                                <option class="py-2 px-3">S???p x???p</option>
                                                <option class="py-2 px-3">Gi??: T??ng d???n</option>
                                                <option class="py-2 px-3">Gi??: Gi???m d???n</option>
                                                <option class="py-2 px-3">Th???i gian: M???i nh???t</option>
                                                <option class="py-2 px-3">Th???i gian: C?? nh???t</option>
                                                <option class="py-2 px-3">C??n h??ng</option>
                                            </select>
                                        </div>-->
                </div>
                <c:if test="${products.size()<=0}">
                    <div class="w-full min-h-[50vh] flex justify-center items-center">
                        <p class="text-5xl">NOT FOUND</p>
                    </div>
                </c:if>
                <div class="px-4 grid sm:grid-cols-1  md:grid-cols-2 lg:grid-cols-3 gap-5 <%=products.size() <= 0 ? "hidden" : ""%>">
                    <c:forEach items="${products}" var="product">
                        <div class="bg-white rounded-lg shadow-md flex flex-col relative ">
                            <c:if test="${product.getQuantity() == 0}">
                                <span class="sold-out-overlay bg-gray-400">
                                    Sold out
                                </span>

                            </c:if>
                            <c:if test="${product.isSale}">
                                <span class="absolute right-0 bg-red-600 text-white text-sm flex justify-center text-center font-semibold inline-flex items-center w-10 h-10 rounded-full">
                                    ${product.discount}%
                                </span>
                            </c:if>
                            <a href="/products/detail?id=${product.getId()}">
                                <img class="rounded-t-lg aspect-[285/280] w-full" src="${product.getImages().get((product.getImages().size()-(product.getImages().size()-1))-1).getImage()}" alt="product image" />
                            </a>
                            <div class="px-5 pb-5 mt-4 flex flex-col flex-1">
                                <a class="mb-10" href="/products/detail?id=${product.getId()}">
                                    <h3 class="text-xl font-semibold tracking-tight text-gray-900 dark:text-white" style="overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;">${product.getName()}</h3>
                                </a>
                                <div class="flex justify-center items-end mt-auto ">
                                    <c:choose>
                                        <c:when test="${product.isSale && product.discount != 0}">
                                            <span class="text-xl line-through font-medium text-gray-900" id="price-not-discount-${product.id}">${product.price}</span>
                                            <span class="ml-2 text-md font-medium text-red-500" id="price-${product.id}">
                                                ${product.price-product.price*product.discount/100}
                                            </c:when>

                                            <c:otherwise>
                                                <span class="text-xl font-medium text-gray-900" id="price-not-discount-${product.id}">${product.price}</span>
                                            </c:otherwise>
                                        </c:choose>

                                    </span>
                                    <script>
                                        var price = Number.parseInt($("#price-${product.id}").text());
                                        price = price.toLocaleString('en-US', {style: 'currency', currency: 'USD'});
                                        $("#price-${product.id}").text(price);
                                        var discount_price = Number.parseInt($("#price-not-discount-${product.id}").text());
                                        discount_price = discount_price.toLocaleString('en-US', {style: 'currency', currency: 'USD'});
                                        $("#price-not-discount-${product.id}").text(discount_price);
                                    </script>
                                </div>

                                <c:choose>
                                    <c:when test="${product.getQuantity() == 0}">
                                        <button class="block text-white bg-gray-400  focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                                            Add to cart
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button onclick="addToCart(${product.id})" class="block text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" type="button" data-modal-toggle="popup-modal">
                                            Add to cart
                                        </button>
                                    </c:otherwise>
                                </c:choose>





                                <div id="popup-modal" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 md:inset-0 h-modal md:h-full justify-center items-center" aria-hidden="true">
                                    <div class="relative p-4 w-full max-w-md h-full md:h-auto">
                                        <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                                            <button type="button" class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-800 dark:hover:text-white" data-modal-toggle="popup-modal">
                                                <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                                <span class="sr-only">Close modal</span>
                                            </button>
                                            <div class="p-6 text-center">
                                                <h3 class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">Add Products Successful!!</h3>
                                                <button  data-modal-toggle="popup-modal" type="button" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
                                                    Close
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </c:forEach> 
                </div>
                <div class="mt-10 mb-5 w-full flex justify-center <%=products.size() <= 0 ? "hidden" : ""%>">
                    <nav aria-label="Page navigation example">
                        <ul class="inline-flex -space-x-px">
                            <li>
                                <a href="/products?page=<%=pagination.getPrev()%>" data="<%=pagination.getPrev()%>" class="pagination-link py-2 px-3 ml-0 leading-tight text-gray-500 bg-white rounded-l-lg border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">Previous</a>
                            </li>
                            <c:if test="${pagination.getPageIndex()>2}">
                                <li>
                                    <a href="/products?page=<%=pagination.getPageIndex() - 2%>" data="<%=pagination.getPageIndex() - 2%>" class="pagination-link py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"><%=pagination.getPageIndex() - 2%></a>
                                </li>
                            </c:if>
                            <c:if test="${pagination.getPageIndex()>1}">
                                <li>
                                    <a href="/products?page=<%=pagination.getPageIndex() - 1%>" data="<%=pagination.getPageIndex() - 1%>" class="pagination-link py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"><%=pagination.getPageIndex() - 1%></a>
                                </li>
                            </c:if>
                            <li>
                                <a href="/products?page=<%=pagination.getPageIndex()%>" data="<%=pagination.getPageIndex()%>" aria-current="page" class="pagination-link py-2 px-3 text-blue-600 bg-blue-50 border border-gray-300 hover:bg-blue-100 hover:text-blue-700 dark:border-gray-700 dark:bg-gray-700 dark:text-white"><%=pagination.getPageIndex()%></a>
                            </li>
                            <c:if test="${pagination.getPageIndex()<pagination.getCount()}">
                                <li>
                                    <a href="/products?page=<%=pagination.getPageIndex() + 1%>" data="<%=pagination.getPageIndex() + 1%>" class="pagination-link py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"><%=pagination.getPageIndex() + 1%></a>
                                </li>
                            </c:if>
                            <c:if test="${pagination.getPageIndex()+1<pagination.getCount()}">
                                <li>
                                    <a href="/products?page=<%=pagination.getPageIndex() + 2%>" data="<%=pagination.getPageIndex() + 2%>" class="pagination-link py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"><%=pagination.getPageIndex() + 2%></a>
                                </li>
                            </c:if>
                            <li>
                                <a href="/products?page=<%=pagination.getNext()%>" data="<%=pagination.getNext()%>" class="pagination-link py-2 px-3 leading-tight text-gray-500 bg-white rounded-r-lg border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <div>
            <jsp:include page="/views/base/footer.jsp" />
        </div>
        <script>

            const addToCart = (productId) => {
            console.log(productId);
            $("#cart-quantity").removeClass("hidden")
                    const data = {
                    productId: productId,
                            quantity: 1,
                    }
            $.ajax({
            method: "POST",
                    url: "/addCart",
                    data: data,
            }).done(function(data){
            if (data?.detailMessage) {

            } else{
            $("#cart-quantity").text(data);
            }
            })
            }

            const categorys = [
            <%for (Category category : categorys) {%>
            {
            id: <%=category.getId()%>,
                    name: "<%=category.getName()%>",
                    group: {
                    id: <%=category.getGroup().getId()%>,
                            name: "<%=category.getGroup().getName()%>",
                    }
            },
            <%}%>
            ]

                    const category = document.getElementById("category");
            for (var i = 0; i < categorys.length - 1; i++) {
            category.innerHTML += '<option value="' + categorys[i].id + '">' + categorys[i].name + '</option>';
            }

            $("#group").on("change", function (e) {
            category.innerHTML = "";
            category.innerHTML += '<option value="all">Category</option>';
            categorys.forEach(item => {
            if (item.group.id == $("#group").val() || $("#group").val() == "all") {
            category.innerHTML += '<option value="' + item.id + '">' + item.name + '</option>';
            }
            });
            })


                    const url_string = window.location.href;
            const url = new URL(url_string);
            const search = url.searchParams.get("q");
            const paginationLinks = document.querySelectorAll(".pagination-link");
            if (paginationLinks) {
            paginationLinks.forEach(item => {
            var search = location.search.substring(1);
            const params = search ? JSON.parse('{"' + decodeURI(search).replace(/"/g, '\\"')
                    .replace(/&/g, '","').replace(/=/g, '":"') + '"}') : {};
            if (params?.group){
            $("#group").val(params?.group)
                    category.innerHTML = "";
            categorys.forEach(item => {
            if (item.group.id == params?.group || params?.group == "all") {
            if (params?.category == item.id){
            category.innerHTML += '<option value="' + item.id + '"selected>' + item.name + '</option>'
            } else{
            category.innerHTML += '<option value="' + item.id + '">' + item.name + '</option>'
            }
            }
            });
            }
            const page = item.getAttribute("data");
            params.page = page;
            const href = new URLSearchParams(params).toString();
            item.setAttribute("href", "?" + href);
            })
            }


        </script>
        <jsp:include page="../base/footerImport.jsp" />
    </body>
</html>
