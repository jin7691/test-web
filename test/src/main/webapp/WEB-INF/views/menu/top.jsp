<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../../views/common/common.jsp" %>
<script src ="${pageContext.request.contextPath}/resources/js/top.js"></script>

<header class="d-flex justify-content-center py-3">
      <ul class="nav nav-pills" id ="menu">
        <li class="nav-item"><a href="/main" class="nav-link " aria-current="page" id="main">메인 페이지</a></li>
        <li class="nav-item"><a href="/product" class="nav-link" id="product">부품 관리</a></li>
        <li class="nav-item"><a href="/user" class="nav-link" id="user">회원정보</a></li>
        <li class="nav-item"><a href="#" class="nav-link">FAQs</a></li>
        <li class="nav-item"><a href="#" class="nav-link">About</a></li>
      </ul>
    </header>