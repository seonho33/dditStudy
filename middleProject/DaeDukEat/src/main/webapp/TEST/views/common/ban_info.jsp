<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>D.D.M - 이용 제한 안내</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    body{ margin:0; background:#020617; color:#e2e8f0; font-family:'Noto Sans KR',sans-serif; }
    .wrap{ max-width:760px; margin:0 auto; padding:64px 20px; }
    .card{ background:#0f172a; border:1px solid #1e293b; border-radius:28px; padding:34px; }
    .title{ display:flex; align-items:center; gap:12px; font-size:26px; font-weight:900; }
    .title i{ color:#ef4444; }
    .sub{ margin:10px 0 26px; color:#94a3b8; font-weight:700; }
    .box{ background:rgba(239,68,68,.08); border:1px solid rgba(239,68,68,.25); border-radius:18px; padding:18px 18px; }
    .row{ display:flex; justify-content:space-between; gap:14px; padding:10px 0; border-bottom:1px dashed rgba(148,163,184,.2); }
    .row:last-child{ border-bottom:none; }
    .k{ color:#94a3b8; font-size:12px; font-weight:900; letter-spacing:.02em; }
    .v{ font-weight:900; }
    .btns{ display:flex; gap:10px; margin-top:22px; }
    .btn{ border:none; cursor:pointer; padding:12px 16px; border-radius:14px; font-weight:900; }
    .btn-logout{ background:#334155; color:#e2e8f0; }
    .btn-home{ background:#38bdf8; color:#020617; }
    .hint{ margin-top:16px; color:#64748b; font-size:12px; font-weight:700; }
    a{ color:inherit; text-decoration:none; }
  </style>
</head>
<body>
  <div class="wrap">
    <div class="card">
      <div class="title">
        <i class="fa-solid fa-ban"></i>
        이용 제한 안내
      </div>
      <div class="sub">
        현재 계정은 운영정책에 따라 일시적으로 이용이 제한되었습니다.
      </div>

      <div class="box">
        <c:set var="b" value="${banInfo}" />
        <div class="row">
          <div class="k">아이디</div>
          <div class="v"><c:out value="${b.userId}" /></div>
        </div>
        <div class="row">
          <div class="k">사유</div>
          <div class="v"><c:out value="${b.blockReason}" /></div>
        </div>
        <div class="row">
          <div class="k">제재기간</div>
          <div class="v">
            <c:out value="${fn:replace(b.blockDate, '-', '.')}" /> ~
            <c:out value="${fn:replace(b.blockEndDate, '-', '.')}" />
          </div>
        </div>
      </div>

      <div class="btns">
        <button class="btn btn-home" onclick="location.href='${pageContext.request.contextPath}/logout.do'">메인으로</button>
      </div>

      <div class="hint">
        제재 기간이 종료되면 자동으로 이용이 가능하도록 처리하는 것이 일반적입니다.
        (필요 시 관리자에게 문의하세요.)
      </div>
    </div>
  </div>
</body>
</html>
