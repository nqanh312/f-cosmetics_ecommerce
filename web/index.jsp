<%-- 
    Document   : index
    Created on : Jun 24, 2022, 3:45:58 PM
    Author     : LENOVO
--%>


<%@page import="model.product.Product"%>
<%@page import="dal.product.ProductDBContext"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.product.Group"%>
<%@page import="dal.product.GroupDBContext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='shortcut icon' href='assets/images/Logo.png' />
        <title>Home Page</title>
        <%
            GroupDBContext groupDB = new GroupDBContext();
            ArrayList<Group> groups = groupDB.list();
            request.setAttribute("groups", groups);
            ProductDBContext productDB = new ProductDBContext();
            ArrayList<Product> products = productDB.getProducts("", -1, -1, 1, 12);
            request.setAttribute("products", products);

            ArrayList<Product> productsIndex = productDB.getProductsIndex("", -1, -1, 1, 12);

            request.setAttribute("productsIndex", productsIndex);

        %>
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
    </head>
    <style>


        .swiper {
            width: 100%;
            height: 100%;
        }

        .swiper-slide {
            text-align: center;
            font-size: 18px;
            background: #fff;

            /* Center slide text vertically */
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
            -webkit-box-pack: center;
            -ms-flex-pack: center;
            -webkit-justify-content: center;
            justify-content: center;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;
        }

        .swiper-slide img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
    <body>
        <jsp:include page="/views/base/header.jsp" />
        <div class="w-full h-[520px]">
            <div class="swiper mySwiper">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <img src="/assets/images/banner1.png" class="container h-full"/>
                    </div>
                    <div class="swiper-slide">
                        <img src="/assets/images/banner2.png" class="container h-full"/>
                    </div>
                    <div class="swiper-slide">
                        <img src="/assets/images/banner3.png" class="container h-full"/>
                    </div>
                    <div class="swiper-slide">
                        <img src="/assets/images/banner4.png" class="container h-full"/>
                    </div>
                </div>
                <div class="swiper-pagination"></div>              
            </div>
            <div class="container mx-auto">
                <div class="text-center mt-10 w-full">
                    <h3 class="text-4xl">CATEGORIES</h3>
                    <div class="px-4 grid md:grid-cols-3 w-full mt-10 gap-5">
                        <a href="/products" class="block bg-white rounded-lg border border-gray-200 shadow-sm hover:bg-gray-1000 ">
                            <img class="aspect-[1/1]" src="/assets/images/danhmuc1.png" style="width: 100%"/>
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900">FACE</h5>
                        </a>
                        <a href="/products" class="block bg-white rounded-lg border border-gray-200 shadow-sm hover:bg-gray-1000">
                            <img class="aspect-[1/1]" src="/assets/images/danhmuc2.png" style="width: 100%"/>
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900">BODY</h5>
                        </a>
                        <a href="/products" class="block bg-white rounded-lg border border-gray-200 shadow-sm hover:bg-gray-1000">
                            <img class="aspect-[1/1]" src="/assets/images/danhmuc3.png" style="width: 100%"/>
                            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900">OTHERS</h5>
                        </a>
                    </div>
                </div>
                <div class="text-center mt-10 w-full sm:px-3 md:px-0">
                    <h3 class="text-4xl">PRODUCT HIGHLIGHTS</h3>
                    <div class="px-4 grid xs:grid-cols-2 sm:grid-cols-2  md:grid-cols-3 lg:grid-cols-4 gap-6 mt-10 <%=products.size() <= 0 ? "hidden" : ""%>">
                        <c:forEach items="${productsIndex}" var="product">
                            <div class="bg-white rounded-lg shadow-md flex flex-col relative">
                                <c:if test="${product.isSale}">
                                    <span class="absolute right-0 bg-red-600 text-white text-sm flex justify-center text-center font-semibold inline-flex items-center w-10 h-10 rounded-full">
                                        ${product.discount}%
                                    </span>
                                </c:if>
                                <a href="/products/detail?id=${product.getId()}">
                                    <img class="aspect-[285/280] rounded-t-lg w-full" src="${product.getImages().get((product.getImages().size()-(product.getImages().size()-1))-1).getImage()}" alt="product image" />
                                </a>
                                <div class="px-5 pb-5 mt-4 flex flex-col flex-1">
                                    <a class="mb-10" href="/products/detail?id=${product.getId()}">
                                        <h3 class="text-xl font-semibold tracking-tight text-gray-900 dark:text-white" style="overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;">${product.getName()}</h3>
                                    </a>
                                    <div class=" justify-center items-end mt-auto">
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

                                    <button onclick="addToCart(${product.id})" data-modal-toggle="popup-modal" type="button"  class="mt-5 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-3 py-2 text-center">Add to cart</button>

                                    </button>

                                    <div id="popup-modal" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 md:inset-0 h-modal md:h-full justify-center items-center" aria-hidden="true">
                                        <div class="relative p-4 w-full max-w-md h-full md:h-auto">
                                            <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                                                <button type="button" class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-800 dark:hover:text-white" data-modal-toggle="popup-modal">
                                                    <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                                    <span class="sr-only">Close modal</span>
                                                </button>
                                                <div class="p-6 text-center">
                                                    <h3 class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">Add Products Successful!!</h3>
                                                    <button data-modal-toggle="popup-modal" type="button" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
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
                </div>
            </div>
            <div>
                <jsp:include page="/views/base/footer.jsp" />
            </div>
        </div>
        <jsp:include page="/views/base/footerImport.jsp" />
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script>
                                                        var swiper = new Swiper(".mySwiper", {
                                                            loop: true,
                                                            centeredSlides: true,
                                                            autoplay: {
                                                                delay: 2500,
                                                                disableOnInteraction: false,
                                                            },
                                                            pagination: {
                                                                el: ".swiper-pagination",
                                                                dynamicBullets: true,
                                                            },
                                                        });
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
                                                            }).done(function (data) {
                                                                if (data?.detailMessage) {

                                                                } else {
                                                                    $("#cart-quantity").text(data);
                                                                }
                                                            })
                                                        }
        </script>
    </body>
</html>
