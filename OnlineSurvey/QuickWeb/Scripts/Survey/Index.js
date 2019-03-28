var pageCount = 10;

$(function () {
	$("#btnAdd").click(function () { add(); });
	$("#btnSave").click(function () { save(); });
	$("#btnDelete").click(function () { deleteMulti(); });
	$("#checkAll").click(function () { checkAll(this) });
	loadTables(1, pageCount);
});

//全选
function checkAll(obj) {
	$(".checkboxs").each(function () {
		if (obj.checked == true) {
			$(this).prop("checked", true);
		}
		if (obj.checked == false) {
			$(this).prop("checked", false);
		}
	});
};

//加载问卷列表数据
function loadTables(startPage, pageSize) {
	$("#tableBody").html("");
	$("#checkAll").prop("checked", false);
	$.ajax({
		type: "GET",
		url: "/Admin/Survey/GetSurveys?pageIndex=" + startPage + "&pageSize=" + pageSize + "&_t=" + new Date().getTime(),
		success: function (data) {
			$.each(data.rows, function (i, item) {
				var tr = "<tr>";
				tr += "<td align='center'><input type='checkbox' class='checkboxs' value='" + item.id + "'/></td>";
				tr += "<td>" + item.surveyName + "</td>";
				tr += "<td title='" + item.description + "' onclick='show(\"" + item.description + "\")'><span class='btn btn-primary btn-xs'><i class='fa fa-eye'> 查看</span></td>";
				tr += "<td title='" + item.copyRight + "' onclick='show(\"" + item.copyRight + "\")'><span class='btn btn-primary btn-xs'><i class='fa fa-eye'> 查看</span></td>";
				tr += "<td>" + item.createTime + "</td>";
				switch (item.surveyStatus) {
					case 0: // 创建中
						tr += "<td>" +
							"<span class='btn btn-info btn-xs'>创建中</span> " +
							"<button class='btn btn-info btn-xs' href='javascript:;' onclick='giveQuestion(\"" + item.id + "\")'><i class='fa fa-institution'></i> 分配答题 </button>" +
							"</td>"; break;
					case 1: // 待发布
						tr += "<td>" +
							"<span class='btn btn-info btn-xs'>待发布</span> " +
							"<button class='btn btn-info btn-xs' href='javascript:;' onclick='giveQuestion(\"" + item.id + "\")'><i class='fa fa-institution'></i> 分配答题 </button>  " +
							"<button class='btn btn-warning btn-xs' href='javascript:;' onclick='setStatus(\"" + item.id + ",2\")'><i class='fa fa-hand-o-right'></i> 发布问卷 </button>" +
							"</td>"; break;
					case 2:// 发布中
						tr += "<td>" +
							"<span class='btn btn-info btn-xs'>发布中</span>" +
							"<button class='btn btn-warning btn-xs' href='javascript:;' onclick='setStatus(\"" + item.id + ",3\")'><i class='fa fa-hand-o-right'></i> 暂停问卷 </button>" +
							"<button class='btn btn-warning btn-xs' href='javascript:;' onclick='setStatus(\"" + item.id + ",5\")'><i class='fa fa-hand-o-right'></i> 关闭问卷 </button>" +
							"</td>"; break;
					case 3:// 已暂停
						tr += "<td>" +
							"<span class='btn btn-warning btn-xs'>已暂停</span> " +
							"<button class='btn btn-info btn-xs' href='javascript:;' onclick='giveQuestion(\"" + item.id + "\")'><i class='fa fa-institution'></i> 分配答题 </button>  " +
							"<button class='btn btn-info btn-xs' href='javascript:;' onclick='giveQuestion(\"" + item.id + ",2\")'><i class='fa fa-hand-o-right'></i> 发布问卷 </button> " +
							"</td>"; break;
					case 4:// 已结束
						tr += "<td>" +
							"<span class='btn btn-info btn-xs'>已结束</span>" +
							"</td>"; break;
					case 5:// 已关闭
						tr += "<td>" +
							"<span class='btn btn-danger btn-xs'>已关闭</span>" +
							"</td>"; break;
				}
				tr += "<td><button class='btn btn-info btn-xs' href='javascript:;' onclick='edit(\"" + item.id + "\")'><i class='fa fa-edit'></i> 编辑 </button> <button class='btn btn-danger btn-xs' href='javascript:;' onclick='deleteSingle(\"" + item.id + "\")'><i class='fa fa-trash-o'></i> 删除 </button> </td>";
				tr += "</tr>";
				$("#tableBody").append(tr);
			});
			var element = $("#grid_paging_part"); //分页插件的容器id
			if (data.rowCount > 0) {
				var options = { //分页插件配置项
					bootstrapMajorVersion: 3,
					currentPage: startPage, //当前页
					numberOfPages: data.rowsCount, //总数
					totalPages: data.pageCount, //总页数
					onPageChanged: function (event, oldPage, newPage) { //页面切换事件
						loadTables(newPage, pageSize);
					},
					alignment: "right",
					size: "normal",//应该是页眉的大小。
					useBootstrapTooltip: true,
					bootstrapTooltipOptions: {
						html: true,
						placement: 'bottom'
					},
					itemTexts: function (type, page, current) {//如下的代码是将页眉显示的中文显示我们自定义的中文。
						switch (type) {
							case "first": return "首页";
							case "prev": return "上一页";
							case "next": return "下一页";
							case "last": return "末页";
							case "page": return page;
							default: return "";
						}
					},
					tooltipTitles: function (type, page, current) {
						switch (type) {
							case "first": return "转到首页";
							case "prev": return "转到上一页";
							case "next": return "转到下一页";
							case "last": return "转到末页";
							case "page": return "转到第" + page + "页";
							default: return "";
						}
					}
				}
				element.bootstrapPaginator(options); //分页插件初始化
			}
		}
	});
};

//新增
function add() {
	$("#Id").val("");
	$("#SurveyName").val("");
	$("#CopyRight").val("");
	$("#Description").val("");
	$("#Title").text("新增问卷");
	//弹出新增窗体
	$("#editModal").modal("show");
};

//编辑
function edit(id) {
	$.ajax({
		type: "Get",
		url: "/Admin/Survey/Get?id=" + id + "&_t=" + new Date().getTime(),
		success: function (result) {
			var data = result.data;
			$("#Id").val(data.id);
			$("#SurveyName").val(data.surveyName);
			$("#CopyRight").val(data.copyRight);
			$("#Description").val(data.description);
			$("#Title").text("编辑问卷");
			$("#editModal").modal("show");
		}
	});
};

//保存
function save() {
	var postData = { "dto": { "Id": $("#Id").val(), "SurveyName": $("#SurveyName").val(), "CopyRight": $("#CopyRight").val(), "Description": $("#Description").val() } };
	$.ajax({
		type: "Post",
		url: "/Admin/Survey/Edit",
		data: postData,
		success: function (result) {
			if (1 == result.status) {
				loadTables(1, pageCount);
				$("#editModal").modal("hide");
			} else {
				layer.tips(result.msg, "#btnSave");
			};
		}
	});
};

//删除单条数据
function deleteSingle(id) {
	layer.confirm("您确认删除选定的记录吗？", {
		btn: ["确定", "取消"]
	}, function () {
		$.ajax({
			type: "POST",
			url: "/Admin/Survey/Delete",
			data: { "id": id },
			success: function (result) {
				if (1 == result.status) {
					loadTables(1, pageCount);
					layer.closeAll();
				}
				else {
					layer.alert("删除失败！");
				}
			}
		});
	});
};

//批量删除
function deleteMulti() {
	var ids = [];
	$(".checkboxs").each(function () {
		if ($(this).prop("checked") == true) {
			ids.push($(this).val());
		}
	});
	if (ids.length == 0) {
		layer.alert("请选择要删除的记录。");
		return;
	};
	//询问框
	layer.confirm("您确认删除选定的记录吗？", {
		btn: ["确定", "取消"]
	}, function () {
		var sendData = { "ids": ids };
		$.ajax({
			type: "Post",
			url: "/Admin/Survey/MultiDelete",
			data: sendData,
			success: function (result) {
				if (1 == result.status) {
					loadTables(1, pageCount);
					layer.closeAll();
				}
				else {
					layer.alert("删除失败！");
				}
			}
		});
	});
};

//问卷信息展示
function show(text) {
	layer.open({
		type: 1,
		area: ['30%', '40%'],
		shade: [0.8, '#393D49'],
		content: '<br/>&nbsp;&nbsp;' + text + '<br/><br/>'
	});
}

var zNodes = '';

//选择题目
function giveQuestion(id) {
	$("#node_id").val(id);
	//加载层
	var loading = layer.load(0, { shade: false }); //0代表加载的风格，支持0-2
	// 获取权限信息
	$.getJSON("/Admin/Survey/GetQuestions", { 'id': id }, function (res) {
		layer.close(loading);
		if (1 == res.status) {
			zNodes = res.data;  //将字符串转换成obj
			//页面层
			var index = layer.open({
				type: 1,
				area: ['650px', '400px'],
				title: '话题设置',
				content: $('#topic')
			});

			//设置 zetree
			var setting = {
				check: {
					enable: true
				},
				data: {
					simpleData: {
						enable: true
					}
				}
			};
			$.fn.zTree.init($("#treeType"), setting, zNodes);
			var zTree = $.fn.zTree.getZTreeObj("treeType");
			zTree.expandAll(true);
		} else if (0 == res.status) {
			layer.alert(res.msg, { title: '友情提示', icon: 2 });
		} else {
			window.location.reload();
		}
	});
}

//确认选择题目
function saveQuestion() {
	var zTree = $.fn.zTree.getZTreeObj("treeType");
	var nodes = zTree.getCheckedNodes(true);
	var topics = [];
	$.each(nodes, function (n, value) {
		if (value.pId < 0) {
			topics.push(value.id);
		}
	});
	var id = $("#node_id").val();
	//写入库
	$.post("/Admin/Survey/Save", { 'id': id, 'topics': topics }, function (res) {
		layer.closeAll();
		if (1 == res.status) {
			layer.alert("分配成功！", { title: '友情提示', icon: 1, closeBtn: 0 }, function (self) {
				layer.close(self);
				loadTables(1, pageCount);
			});
		} else if (0 == res.status) {
			layer.alert(res.msg, { title: '友情提示', icon: 2 });
		} else {
			window.location.reload();
		}
	}, 'json');
}

//问卷状态控制
function setStatus(id, status) {
	$.post("/Admin/Survey/Status", { 'id': id, 'status': status }, function (res) {
		layer.closeAll();
		if (1 == res.status) {
			layer.alert("操作成功！", { title: '友情提示', icon: 1, closeBtn: 0 }, function (self) {
				layer.close(self);
				loadTables(1, pageCount);
			});
		} else if (0 == res.status) {
			layer.alert(res.msg, { title: '友情提示', icon: 2 });
		} else {
			window.location.reload();
		}
	}, 'json');
}