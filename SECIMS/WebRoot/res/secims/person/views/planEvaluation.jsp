<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
    <head>
    
        <title>学习计划互评</title>
        
        <%-- 公共JS 和 css --%>
		<%@include file="../../common/commonJS.jsp" %>
		
		<link rel="stylesheet" href="/SECIMS/res/steps/jquery.steps.css">
		<link rel="stylesheet" href="/SECIMS/res/bootstrap-star-rating/css/star-rating.min.css" >
		
		<script type="text/javascript" src="/SECIMS/res/steps/jquery.steps.min.js"></script>
		<script type="text/javascript" src="/SECIMS/res/bootstrap-star-rating/js/star-rating.js"></script>
		
		<%-- 自定义 JS --%>
		<script type="text/javascript" src="/SECIMS/res/secims/person/js/planEvaluation.js"></script>
		
    </head>
    
    <body class="gray-bg">
    	
    	<div class="wrapper wrapper-content animated fadeInRight">
        	<div class="row">
        		<div class="col-sm-12">
        			<div class="ibox">

						<div class="mail-box-header">
						
							<div class="pull-right tooltip-demo">
								<a href="/SECIMS/res/getStudyPlans" class="btn btn-white btn-sm"> 
									<span class="glyphicon glyphicon-home" aria-hidden="true"></span> 计划主页
								</a>
							</div>
						
							<h3 style="font-family: '华文行楷';">计划互评</h3>
						</div>
						
					<c:choose>
						<c:when test="${plans == null}">
							<%-- 还没有到 星期一下午 不能评论 --%>
							<div class="ibox-content">
								<h3>还未到评分时间，请耐心等待。。。。。</h3><br />
								<p style="color: red;font-size: .8em;">注：只有在星期一下午才能评论打分</p>
							</div>
						</c:when>
						
						<%-- 时间正确，可以评分 --%>
						<c:otherwise>

						<%-- 互评 打分 --%>
						<div class="ibox-content">
							<form action="">
								<input id="evalStars" name="evalStars" 
									class="rating rating-loading" 
									data-size="lg" type="number"
									data-min="0" data-max="10" value=""
									data-stars="10" data-step="0.1" />
							</form>
						</div>
						
						<%-- 内容 --%>
						<div class="ibox-content">
							<div class="row">
								<div class="col-sm-12">
									
									<%-- jquery steps --%>
									<div id="wizard" class="wizard-big"> 
									
										<%-- 各个用户 完成的 计划列表 开始 --%>
										<c:forEach items="${plans }" var="plan" varStatus="status">
										
										<h1>芥空</h1>
			                            <fieldset style="overflow: auto;">
			                                <div class="ibox">
							                    <div class="ibox-content" >
							                    
							                        <div class="row">
							                            <div class="col-sm-12">
							                                <div class="m-b-md">
							                                    <h2>学习计划</h2>
							                                </div>
							                                <dl class="dl-horizontal">
																<dt>状态：</dt>
																<dd><span class="label label-default">已完成</span></dd>
															</dl>
							                            </div>
							                        </div>
							                        
							                        <br/>
							                        
							                        <div class="row">
							                            <div class="col-sm-5">
							                                <dl class="dl-horizontal">
							                                    <dt>类型：</dt>
							                                    <dd>${plan.planType }</dd>
							                                    <dt>标题：</dt>
							                                    <dd>${plan.planTitle }</dd>
							                                </dl>
							                            </div>
							                            
							                            <div class="col-sm-7" id="cluster_info">
							                                <dl class="dl-horizontal">
							
							                                    <dt>最后更新：</dt>
							                                    <dd>${plan.finishTimeString }</dd>
							                                    <dt>创建于：</dt>
							                                    <dd>${plan.createTimeString }</dd>
							                                </dl>
							                            </div>
							                            
							                        </div>
							                        
							                        <br/>
							                        
							                        <!-- 学习计划 内容 -->
							                        <div class="row">
							                            <div class="col-sm-12">
							                            
							                                <dl class="dl-horizontal">
							                                    <dt>计划内容：</dt>
							                                    <dd>
							                                    	<span>${plan.planContent }</span>
							                                    	<span id="planID${status.index }" style="display:none;">${plan.planId }</span>
							                                    </dd>
							                                </dl>
							                                
							                            </div>
							                        </div>
							                        
							                        <br/>

							                         <br/>
													<!-- 学习计划详细 -->
													<div class="row m-t-sm" >
														<div class="col-sm-12">
															<a href="javascript:void(0)">
																<h4>执行计划过程</h4>
															</a>
														</div>
													</div>
													
													
													 <br/>
													<!-- 学习计划详细 -->
													<div class="row">
														<div class="col-sm-12">
															<div class="ibox-content" id="ibox-content">
																
								                                <div id="vertical-timeline" class="vertical-container dark-timeline detailLists">
								                                
								                                	<!--  计划 详情 列表  -->
								                                
								                                    <c:forEach var="detail" items="${plan.studyPlanDetails }">
								                                    
									                                    	 <div class="vertical-timeline-block detailList" id="detailID${detail.planDetailId}">
									                                    	 
										                                       	<div class="vertical-timeline-icon blue-bg">
										                                            <i class="layui-icon">&#xe63c;</i>
										                                        </div>
										
										                                        <div class="vertical-timeline-content">
										                                            <h2>${detail.planDetailTitle }</h2>
										                                            <br>
										                                            <p>${detail.planDetailContent }</p>
										                                            
										                                            <!-- 如果已经完结 就 不可以编辑/删除  
										                                            <c:if test="${plan.status != 'F' && detail.status != 'F' }">
											                                            <div>
																							<a class="btn btn-sm btn-default" id="delDetail" onclick="delDetail('${detail.planDetailId}','${plan.planId }')">
																							    <i class="layui-icon">&#xe640;</i>
																							</a>
												                                            <a class="btn btn-sm btn-default" onclick="editDetail('${detail }')">
																								<i class="layui-icon">&#xe642;</i>
																							</a>
																						</div>
																					</c:if> -->
																					
										                                            <span class="vertical-date">
										                                            	<br>
										                                        		<small>${detail.createTimeString }</small>
										                                    		</span>
										                                        </div>
									                                    	</div>
									                                    	
								                                    	
								                                    </c:forEach>
							
																</div>
							                            	</div>
														
														</div>
													</div>
							
												</div>
							                </div>
							                
			                            </fieldset>
			
										</c:forEach>
										<%-- 各个用户 完成的 计划列表 结束 --%>
										
										
									</div>
									
								</div>
							</div>
						</div>
						
						</c:otherwise>
					</c:choose>
						
        			</div>
        			
        		</div>
        		
        	</div>
        	
        </div>
	
</body>
</html>