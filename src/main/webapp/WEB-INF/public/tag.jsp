<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="baseurl" value="<%=basePath%>"></c:set>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script>
    var baseUrl = "${baseurl}";
    var ADDRESS_SPLIT_FLAG = "-";
    var HEAD_IMAGE_PREFIX = baseUrl+"images/user"
    var HEAD_IMAGE_PREFIX1 = baseUrl+"images/public/cover.png"
</script>