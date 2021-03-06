var error = false;
var role = {
		URL:{
			roleList:function(){
				return Utils.root()+'/role/roleList';
			},
			addRole:function(){
				return Utils.root()+"/role/addRole";
			},
			removeRole:function(){
				return Utils.root()+'/role/removeRole';
			}
		}
	}
$(function(){
	TableInit();
	//ButtonInit();
	
	$('#roleName').blur(function(){
		var roleName = $('input[id=roleName]').val();
		if(roleName == ''){
			showError('roleName', '角色名不能为空');
			error=true;
			return;
		}else{
			$('#roleName').css({"border-color":"green"});
			$('#roleNameTip').css({"display":"none"});
			error = false;
		}
	});
	$('#roleType').blur(function(){
		var username = $('input[id=roleType]').val();
		if(username == ''){
			showError('roleType', '角色类型不能为空');
			error=true;
			return;
		}else{
			$('#roleType').css({"border-color":"green"});
			$('#roleTypeTip').css({"display":"none"});
			error = false;
		}
	});
});



function TableInit(){
	$('#roleTable').bootstrapTable('destroy');
	$('#roleTable').bootstrapTable({
		url:role.URL.roleList(),
		striped: true,  //表格显示条纹
		toolbar: '#toolbar', 
		search: true,  
	    pagination: true,
	    showColumns:true,
	    showRefresh:true,
	    pageList:[],
	    columns:[
	             {
	            	 field:'id',
	            	 title:'id',
	             },
		           {
		        	   field:'roleName',
		        	   title:'角色',
		        	   align:'center',
		           },
		           {
		        	   
		        	   field:'type',
		        	   title:'类型',
		        	   align:'center',
		           },
		           {
		        	   field:'action',
		        	   title:'Action',
		        	   align:'center',
		        	   formatter:operateFormatter
		           }]
	});
	 $('#roleTable').bootstrapTable('hideColumn', 'id');
}

function Btn_add(){
	var roleInfoModal = $('#roleInfo');
	roleInfoModal.modal({
		show:true,//显示弹出层
		backdrop:'static',//禁止位置关闭
		keyboard:false //关闭键盘事件
	});
	
	$('#submitBtn').unbind('click').bind('click',function(){
		$('#roleName').blur();
		$('#roleType').blur();
		if(!error){
			var roleName = $('#roleName').val();
			var roleType = $('#roleType').val();
			$.post(role.URL.addRole(),{roleName:roleName,roleType:roleType},function(result){
				if(result && result['success']){
					$('#roleTable').bootstrapTable('insertRow',{
						index:0,
						row:result['data']
					});
					$('#roleName').val("");
					$('#roleType').val("");
					roleInfoModal.modal('hide');
				}else{
					console.log('result:'+result);
				}
			});
//			$.ajax({
//				url:role.URL.addRole(),
//				data:{
//					roleName:roleName,
//					roleType:roleType
//				},
//				success:function(result){
//					$('#roleTable').bootstrapTable('insertRow',{
//						index:0,
//						row:result['data']
//					});
//					roleInfoModal.modal('hide');
//				},
//				error:function(result){
//					alert("error");
//				}
//			});
		}
//		window.location.reload();
	});
	
}

function operateFormatter(value, row, index) {
	return [
			 '<button id="btn_delete" type="button" class="btn btn-default" onclick="onRemove(\''+row.id+'\')">'+
			    '<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除'+
			 '</button>'
	    ].join('');
}

function onRemove(obj){
	Utils.confirm({title:"提示",message:"是否确认删除 "+obj+"角色信息",operate:function(result){
		if(result){
			$.post(role.URL.removeRole(),{roleId:obj},function(result){
				if(result == 'removeSuccess'){
					$('#roleTable').bootstrapTable('remove',{
						field:'id',
						values:[parseInt(obj)]
					});
				}else{
					console.log("result:"+result);
				}
			});
		}
	}});
//	if(confirm("是否确认删除 "+obj+"角色信息")){
//		$.post(role.URL.removeRole(),{roleId:obj},function(result){
//			if(result == 'removeSuccess'){
//				$('#roleTable').bootstrapTable('remove',{
//					field:'id',
//					values:[parseInt(obj)]
//				});
//			}else{
//				console.log("result:"+result);
//			}
//		});
//	}
}

function showError(formSpan,errorText){
	$('#'+formSpan).css({"border-color":"red"});
	$('#'+formSpan+'Tip').empty();
	$('#'+formSpan+'Tip').append(errorText);
	$('#'+formSpan+'Tip').css({"display":"inline"});
}

