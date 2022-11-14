<%-- 
    Document   : productDetail
    Created on : Jul 2, 2022, 1:58:06 AM
    Author     : LENOVO
--%>

<%@page import="model.product.Product"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../base/header.jsp" />
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='shortcut icon' href='assets/images/Logo.png' />
        <%
            Product product = (Product) request.getAttribute("product");
        %>
        <title><%=product.getName()%></title>
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
        <link rel="stylesheet" type="text/css" href="/assets/css/ckeditor/preview.css">
    </head>
    <style>
        .swiper {
            max-width: 100%;
            height: 600px;
        }

        .swiper-button-next::after, .swiper-button-prev::after{
            font-size: 30px!important;
            font-weight: bold!important;
            color: #000!important;
        }

        .editor h1{
            font-size: 2em!important;
            display: block!important;
            margin-block-start: 0.67em!important;
            margin-block-end: 0.67em!important;
            margin-inline-start: 0px!important;
            margin-inline-end: 0px!important;
            font-weight: bold!important;
        }

        .editor h2{
            display: block!important;
            font-size: 1.5em!important;
            margin-block-start: 0.83em!important;
            margin-block-end: 0.83em!important;
            margin-inline-start: 0px!important;
            margin-inline-end: 0px!important;
            font-weight: bold!important;
        }

        .editor h3{
            display: block!important;
            font-size: 1.17em!important;
            margin-block-start: 1em!important;
            margin-block-end: 1em!important;
            margin-inline-start: 0px!important;
            margin-inline-end: 0px!important;
            font-weight: bold!important;
        }

        .editor h4{
            display: block!important;
            margin-block-start: 1.33em!important;
            margin-block-end: 1.33em!important;
            margin-inline-start: 0px!important;
            margin-inline-end: 0px!important;
            font-weight: bold!important;
            font-size: 1em!important;
        }

        .editor p{
            font-size: 1.1rem!important;
            font-weight: 500!important;
            color: #3b3a39!important;
        }
    </style>
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
                            <li class="inline-flex items-center text-xl">
                                <a href="/admin/products" class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-gray-900">
                                    <svg class="w-6 h-6 text-xl" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    Products
                                </a>
                            </li>
                            <li aria-current="page">
                                <div class="flex items-center">
                                    <svg class="w-6 h-6 text-gray-400 text-xl" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <span class="ml-1 text-sm font-medium text-gray-400 md:ml-2 dark:text-gray-500"><%=product.getName()%></span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>
                <div class="w-full mt-10">
                    <div class="container w-full grid grid-cols-5 gap-2 mx-auto">
                        <div class="col-span-2">
                            <div class="swiper">
                                <div class="swiper-wrapper">
                                    <c:if test="${product.getImages().size()>0}">
                                        <c:forEach items="${product.getImages()}" var="image">
                                            <div class="swiper-slide">
                                                <img src="${image.getImage()}" style="width: 100%; height: 100%"/>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${product.getImages().size()<=0}">
                                        <div class="swiper-slide">
                                            <img src="/assets/images/no-image.png" style="width: 100%; height: 100%"/>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="swiper-button-next"></div>
                                <div class="swiper-button-prev"></div>
                                <div class="swiper-pagination"></div>
                            </div>
                        </div>
                        <div class="col-span-3 px-3 h-full flex flex-col">
                            <h2 class="text-2xl font-medium">
                                <%=product.getName()%>
                            </h2>
                            <div class="mt-6">
                                <table>
                                    <tr>
                                        <td class="font-medium pr-10 uppercase">STATUS:</td>
                                        <td class="font-medium uppercase"><%=product.getState().getName()%></td>
                                    </tr>
                                    <tr>
                                        <td class="font-medium pr-10 uppercase">CATEGORY:</td>
                                        <td class="font-medium uppercase"><%=product.getCategory().getName()%></td>
                                    </tr>
                                    <tr>
                                        <td class="font-medium pr-10 uppercase">BRAND:</td>
                                        <td class="font-medium uppercase"><%=product.getBrand()%></td>
                                    </tr>
                                </table>
                            </div>
                            <p class="mt-3 font-medium">
                                <%=product.getDescription()%>
                            </p>
                            <div>
                               <br>
<!--                            <a href="https://www.facebook.com/techycetera" class="block">Liên hệ:</a>
                            <a href="https://www.facebook.com/techycetera" class="block">Cần Thơ:  600, Nguyễn Văn Cừ nối dài, An Bình, Ninh Kiều, Cần Thơ</a>
                            <a href="https://www.facebook.com/techycetera" class="block">Sài Gòn: Lô E2a-7,Khu CNC, P.Long Thạnh Mỹ, Tp. Thủ Đức, TP.HCM</a>
                            <a href="https://www.facebook.com/techycetera" class="block">Đà Nẵng Khu Đô Thị FPT, P. Hòa Hải, Q. Ngũ Hành Sơn, TP Đà Nẵng</a>
                            <a href="https://www.facebook.com/techycetera" class="block">Hà Nội: Khu CNC Hòa Lạc, Km29, ĐCT08, Thạch Hoà, Thạch Thất, Hà Nội</a> 
                            <a href="https://www.facebook.com/techycetera" class="block">Quy Nhơn: Khu đô thị mới An Phú Thịnh, Phường Nhơn Bình & Phường Đống Đa, TP. Quy Nhơn, Bình Định</a>-->
                            <br>
                            </div>
                            <p class="text-4xl text-red-600 font-bold mt-auto" id="price">
                                <%=product.getPrice()%>
                            </p>

                            <div class="mt-6">
                                <p class="text-md text-gray-500 font-medium mb-3">QUANTITY</p>
                                <div class="flex items-center border-solid border border-gray-100" style="width: fit-content">
                                    <button id="button-minus" type="button" class="text-white focus:ring-1 font-medium px-2 py-2 text-center text-sm text-gray-500 border border-gray-100">
                                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path></svg>
                                    </button>
                                    <span class="py-1 px-4 text-2xl font-bold" id="quantity">
                                        1
                                    </span>
                                    <button id="button-plus" type="button" class="text-white focus:ring-1 font-medium px-2 py-2 text-center text-sm text-gray-500 border border-gray-100">
                                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
                                    </button>                            
                                </div>
                            </div>
                            <button id="button-add-to-cart" type="button" class="max-w-lg mt-5 text-white bg-gray-900 hover:bg-gray-900 focus:ring-1 focus:ring-gray-600 font-medium px-15 py-2 text-center text-lg">
                                ADD TO CART
                            </button>
                        </div>
                    </div>
                    <div class="container mx-auto mt-20">
                        <div class="mb-4 border-b border-gray-200">
                            <ul class="flex justify-center flex-wrap -mb-px" id="myTab" data-tabs-toggle="#myTabContent" role="tablist">
                                <li class="mr-2" role="presentation">
                                    <button class="inline-block py-4 px-4 text-lg font-medium text-center text-gray-500 rounded-t-lg border-b-2 border-transparent hover:text-gray-600 hover:border-gray-300 uppercase active" id="dashboard-tab" data-tabs-target="#dashboard" type="button" role="tab" aria-controls="dashboard" aria-selected="true">Product description</button>
                                </li>
                            </ul>
                        </div>
                        <div id="myTabContent">
                            <div class="p-4 rounded-lg w-full" id="dashboard" role="tabpanel" aria-labelledby="dashboard-tab">
                                 <div class="editor preview ck-content w-full"></div>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../base/footer.jsp" />
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script>
            const swiper = new Swiper('.swiper', {
//                direction: 'vertical',
                loop: true,
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                scrollbar: {
                    el: '.swiper-scrollbar',
                },
            });

            var price = <%=product.getPrice()%>;
            price = price.toLocaleString('en-US', {style: 'currency', currency: 'USD'});
            $("#price").text(price);

            $("#button-minus").on("click", function (e) {
                if (Number.parseInt($("#quantity").text()) - 1 > 0) {
                    $("#quantity").text(Number.parseInt($("#quantity").text()) - 1);
                } else {
                    $("#quantity").text(0);
                }
            })

            $("#button-plus").on("click", function (e) {
                if (Number.parseInt($("#quantity").text()) + 1 <${product.quantity}) {
                    $("#quantity").text(Number.parseInt($("#quantity").text()) + 1);
                } else {
                    $("#quantity").text(${product.quantity});
                }
            })

            $(".preview").html(`<%=product.getContent()%>`)
        </script>
    </body>
</html>
