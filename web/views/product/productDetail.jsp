<%-- 
    Document   : productDetail
    Created on : Jul 2, 2022, 1:58:06 AM
    Author     : LENOVO
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.product.Product"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='shortcut icon' href='assets/images/Logo.png' />
        <%
            Product product = (Product) request.getAttribute("product");
            ArrayList<Product> sameProducts = (ArrayList<Product>) request.getAttribute("sameProducts");
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

        .sold-out-overlay {
            background: #4ea384;
            color: #fff;
            font-size: 14px;
            font-weight: 600;
            padding: 5px 10px;
            position: absolute;
            right: 0px;
            top: 1px;
            width: 98px;
            height: 45px;
            line-height: 32px;
            display: flex;
            justify-content: center;
            border-radius: 2px;
        }
    </style>
    <body>
        <jsp:include page="../base/header.jsp" />
        <div class="container mx-auto">
            <div class="w-full mt-10">
                <div class="container w-full grid grid-cols-5 gap-2 mx-auto">
                    <div class="col-span-2">
                        <div class="swiper">
                            <div class="swiper-wrapper">
                                <c:if test="${product.getImages().size()>0}">
                                    <c:forEach items="${product.getImages()}" var="image">
                                        <div class="swiper-slide">
                                            <img src="${image.getImage()}" style="width: 100%; height: 100%"/>
                                            <c:if test="${product.getQuantity() == 0}">
                                                <span class="sold-out-overlay bg-gray-400"> Sold Out
                                                </span>
                                            </c:if> 
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
                        <!--                        <div>
                                                    <a href="https://www.facebook.com/techycetera" class="block">Liên hệ:</a>
                                                    <a href="https://www.facebook.com/techycetera" class="block">Cần Thơ:  600, Nguyễn Văn Cừ nối dài, An Bình, Ninh Kiều, Cần Thơ</a>
                                                    <a href="https://www.facebook.com/techycetera" class="block">Sài Gòn: Lô E2a-7,Khu CNC, P.Long Thạnh Mỹ, Tp. Thủ Đức, TP.HCM</a>
                                                    <a href="https://www.facebook.com/techycetera" class="block">Đà Nẵng Khu Đô Thị FPT, P. Hòa Hải, Q. Ngũ Hành Sơn, TP Đà Nẵng</a>
                                                    <a href="https://www.facebook.com/techycetera" class="block">Hà Nội: Khu CNC Hòa Lạc, Km29, ĐCT08, Thạch Hoà, Thạch Thất, Hà Nội</a> 
                                                    <a href="https://www.facebook.com/techycetera" class="block">Quy Nhơn: Khu đô thị mới An Phú Thịnh, Phường Nhơn Bình & Phường Đống Đa, TP. Quy Nhơn, Bình Định</a>
                                                </div>-->
                        <div class="flex">
                            <c:choose>
                                <c:when test="${product.isSale}">
                                    <p class="text-4xl line-through text-gray-900 font-bold mt-auto" id="price">
                                        <%=product.getPrice()%>
                                    </p>
                                    <p class="ml-3 text-2xl text-red-600 font-bold mt-auto" id="price-discount">
                                        <%=product.getPrice()%>
                                    </p>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-4xl text-red-600 font-bold mt-auto" id="price">
                                        <%=product.getPrice()%>
                                    </p>
                                </c:otherwise>
                            </c:choose>

                        </div>

                        <div class="mt-6">
                            <p id="p-quantity" class="text-md text-gray-500 font-medium mb-3">Quantity On Hand: ${product.getQuantity()}</p>
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
                            <div class="text-md text-red-500 font-medium mb-3" id="hello-test"></div>
                        </div>
                        <c:choose>
                            <c:when test="${product.getQuantity() == 0}">
                                <button onclick="addToCart()" class="max-w-lg mt-5 text-white bg-gray-400 focus:ring-1 focus:ring-gray-600 font-medium px-15 py-2 text-center text-lg"  type="button" data-modal-toggle="popup-modal">
                                    Add to cart
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button onclick="addToCart()" class="max-w-lg mt-5 text-white bg-gray-900 hover:bg-gray-900 focus:ring-1 focus:ring-gray-600 font-medium px-15 py-2 text-center text-lg"  type="button" data-modal-toggle="popup-modal">
                                    Add to cart
                                </button>

                            </c:otherwise>
                        </c:choose>


                        <!--                        <div id="popup-modal" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 md:inset-0 h-modal md:h-full justify-center items-center" aria-hidden="true">
                                                    <div class="relative p-4 w-full max-w-md h-full md:h-auto">
                                                        <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                                                            <button type="button" class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-800 dark:hover:text-white" data-modal-toggle="popup-modal">
                                                                <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                                                <span class="sr-only">Close modal</span>
                                                            </button>
                                                            <div class="p-6 text-center">
                                                                <h3 class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">Add Products Successfull!!</h3>
                                                                <button onclick="addToCart(${product.id})" data-modal-toggle="popup-modal" type="button" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
                                                                    Close
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>-->

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
        <div class="container mx-auto mt-20">
            <h3 class="text-4xl text-center">SIMILAR PRODUCTS</h3>
            <div class="mt-20 w-full">
                <div class="grid grid-cols-4 gap-6 snap-x">
                    <c:forEach items="${sameProducts}" var="product">
                        <div class="bg-white rounded-lg shadow-md flex flex-col relative">
                            <c:if test="${product.isSale}">
                                <span class="absolute -top-5 -right-5 bg-red-600 text-white text-sm flex justify-center text-center font-semibold inline-flex items-center w-10 h-10 rounded-full">
                                    ${product.discount}%
                                </span>
                            </c:if>
                            <a href="/products/detail?id=${product.getId()}">
                                <img class="rounded-t-lg w-full h-[340px]" src="${product.getImages().get(product.getImages().size()-1).getImage()}" alt="product image" />
                            </a>
                            <div class="px-5 pb-5 mt-4 flex flex-col flex-1">
                                <a class="mb-10" href="/products/detail?id=${product.getId()}">
                                    <h3 class="text-xl font-semibold tracking-tight text-gray-900 dark:text-white" style="overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;">${product.getName()}</h3>
                                </a>
                                <div class="flex justify-center items-end mt-auto">
                                    <c:choose>
                                        <c:when test="${product.isSale}">
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
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <jsp:include page="../base/footerImport.jsp" />
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script>
                                        const addToCart = () => {
                                            if (Number.parseInt($("#quantity").text()) > 0) {
                                                $("#cart-quantity").removeClass("hidden")
                                                const data = {
                                                    productId: ${product.id},
                                                    quantity: Number.parseInt($("#quantity").text()),
                                                }
                                                $.ajax({
                                                    method: "POST",
                                                    url: "/addCart",
                                                    data: data,
                                                }).done(function (data) {
                                                    if (data?.detailMessage) {

                                                    } else {
                                                        $("#cart-quantity").text(data);
                                                        $("#quantity").text();
                                                    }
                                                })
                                            }
                                        }
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

                                        var price_discount = <%=product.getPrice() - product.getPrice() * (double) product.getDiscount() / 100%>;
                                        price_discount = price_discount.toLocaleString('en-US', {style: 'currency', currency: 'USD'});
                                        $("#price-discount").text(price_discount);

                                        $("#button-minus").on("click", function (e) {
                                            if (Number.parseInt($("#quantity").text()) - 1 > 0) {
                                                $("#quantity").text(Number.parseInt($("#quantity").text()) - 1);
                                                $("#hello-test").empty();
                                            } else {
                                                $("#quantity").text();
                                            }
                                        });
                                        $("#button-plus").on("click", function (e) {
                                            if (Number.parseInt($("#quantity").text()) + 1 <${product.quantity}) {
                                                $("#quantity").text(Number.parseInt($("#quantity").text()) + 1);
                                            } else if (Number.parseInt($("#quantity").text()) + 1 === ${product.quantity}) {
                                                $("#quantity").text(${product.quantity});
                                                $("#hello-test").text("The quantity you selected has reached the maximum of this product");
                                            } else {
                                                return;
                                            }
                                        });
                                        $(".preview").html(`<%=product.getContent()%>`)
        </script>
        <div>
            <jsp:include page="/views/base/footer.jsp" />
        </div>
    </body>
</html>
