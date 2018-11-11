<%@page pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理</title>
    <link rel="stylesheet" type="text/css" href="../css/common.css"/>
    <link rel="stylesheet" type="text/css" href="../css/main.css"/>
    <script type="text/javascript" src="../js/libs/modernizr.min.js"></script>
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
    
    $(function(){
    	//实现全选反选
        $("#all").on('click', function() {
            $("input[name = 'ids']").prop("checked", $(this).prop('checked'));
        });
        
        var chknum = $("input[id = 'sonid']").size();//选项总个数
        
        $("input[id = 'sonid']").on('click', function() {
	    	var chk = 0;
	    	$("input[id = 'sonid']").each(function () {  
	            if($(this).prop("checked")==true){
	    			chk++;
	    		}
	        });
	    	if(chknum==chk){	//全选
	    		$("#all").prop("checked",true);
	    	}else{	//不全选
	    		$("#all").prop("checked",false);
	    	}
        });
        
    });
    
    
    </script>
    
    
</head>
<body>
<jsp:include page="../util/top.jsp"></jsp:include>

<div class="container clearfix">
<jsp:include page="../util/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">

        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font">&#xe06b;</i><span>欢迎来理想科技公司学习 <span style="color:blue">  现在位置 删除心情</span></span></div>
        </div>
        <div class="search-wrap">
            <div class="search-content">
                <form action="#" method="post">
                    <table class="search-tab">
                        <tr>
                            <th width="70">关键字:</th>
                            <td><input class="common-text" placeholder="关键字" name="pname" type="text"></td>
                            <td><input class="btn btn-primary btn2" name="sub" value="查询" type="submit"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" id="all" name="ids" type="checkbox"></th>
                            <th>标题</th>
                            <th>文章状态</th>
                            <th>发布人</th>
                            <th>更新时间</th>
                            <th>内容</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${lists}" var="admin">
                        <tr>
                            <td class="tc"><input name="ids" id="sonid" value="${admin.id}" type="checkbox"></td>
                            <td>
                               <a href="findXiangxi.action?id=${admin.id}" name="title"> ${admin.title}</a>
                            </td>
                            <td>
                               <c:if test="${admin.state==0}">
                                                                                          未发布的
                               </c:if>
                                <c:if test="${admin.state==1}">
                                                                                          发布的
                               </c:if>
                                <c:if test="${admin.state==2}">
                            	      删除的
                               </c:if>
                            </td>
                            <td title="${admin.username}">${admin.username}
                            </td>
                            <td>${admin.createtime}</td>
                            <td>${fn:substring(admin.neirong, 0, 10)}</td>
                            <input type="hidden" name="neirong" value="${admin.neirong}"/>
                            <td>
                            	<a href="findXiangxi.action?id=${admin.id}" name="查看详情"> 查看详情</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a class="link-update" href="toupdatedelete.action?id=${admin.id}" onclick="if(confirm('确定还原?')==false)return false;">还原</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a class="link-update" href="delete.action?id=${admin.id}" onclick="if(confirm('确定彻底删除?')==false)return false;">彻底删除</a>
                            </td>
                        </tr>
                        </c:forEach>
                    </table>
                    <c:if test="${page.allPage > 0}">
	                    <input id="deleteMore" type="button" value="批量删除" onclick="document.myform.action='deleteMore.action';document.myform.submit();"/>&nbsp;&nbsp;&nbsp;&nbsp;
						<input id="returnMore" type="button" value="批量还原" onclick="document.myform.action='returnMore.action';document.myform.submit();"/> 
                    </c:if>
                    <p align="center">
						<c:if test="${page.page==1 && page.allPage > 1}">
							<a style="cursor: pointer" href="findDeleted.action?page=${page.page+1}">下一页</a>
							<a style="cursor: pointer" href="findDeleted.action?page=${page.allPage}">尾页</a>
						</c:if>
						
						<c:if test="${page.page > 1 && page.page < page.allPage}">
							<a style="cursor: pointer;" href="findDeleted.action?page=1">首页</a>
							<a style="cursor: pointer" href="findDeleted.action?page=${page.page-1}">上一页</a>
							<a style="cursor: pointer" href="findDeleted.action?page=${page.page+1}">下一页</a>
							<a style="cursor: pointer" href="findDeleted.action?page=${page.allPage}">尾页</a>
						</c:if>
						<c:if test="${page.page==page.allPage && page.allPage > 1}">
							<a style="cursor: pointer;" href="findDeleted.action?page=1">首页</a>
							<a style="cursor: pointer" href="findDeleted.action?page=${page.page-1}">上一页</a>
						</c:if>
						<c:if test="${page.allPage > 0}">共${page.allPage}页，现在是第${page.page}页</c:if>
					</p>
                </div>
            </form>
        </div>
    </div>
    <!--/main-->
</div>
</body>
</html>