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

//加载用户列表数据
function loadTables(startPage, pageSize) {
	$("#tableBody").html("");
	$("#checkAll").prop("checked", false);
	$.ajax({
		type: "GET",
		url: "/Admin/User/GetAdminUsers?pageIndex=" + startPage + "&pageSize=" + pageSize + "&_t=" + new Date().getTime(),
		success: function (data) {
			$.each(data.rows, function (i, item) {
				var tr = "<tr>";
				tr += "<td align='center'><input type='checkbox' class='checkboxs' value='" + item.id + "'/></td>";
				tr += "<td>" + item.userName + "</td>";
				tr += "<td>" + (item.nickName == null ? "" : item.nickName) + "</td>";
				tr += "<td>" + (item.isActive == "True" ? "<span class='btn btn-info btn-xs'>正常</span>" : "<span class='btn btn-danger btn-xs'>禁用</span>") + "</td>";
				tr += "<td><button class='btn btn-info btn-xs' href='javascript:;' onclick='edit(\"" + item.id + "\")'><i class='fa fa-edit'></i> 编辑 </button> <button class='btn btn-danger btn-xs' href='javascript:;' onclick='deleteSingle(\"" + item.id + "\")'><i class='fa fa-trash-o'></i> 删除 </button> </td>"
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
					alignment:"right",
					size:"normal",//应该是页眉的大小。
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
		                    case "page": return "转到第"+page+"页";
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
	$("#UserName").val("");
	$("#Password").val("admin");
	$("#NickName").val("");
	$("#Remarks").val("");
	$("#Title").text("新增管理员");
	$("#PwdText").text("默认：admin");
	$("#IsActive").prop("checked", true);
	//弹出新增窗体
	$("#editModal").modal("show");
};

//编辑
function edit(id) {
	$.ajax({
		type: "Get",
		url: "/Admin/User/Get?id=" + id + "&_t=" + new Date().getTime(),
		success: function (result) {
			var data = result.data;
			$("#Id").val(data.id);
			$("#UserName").val(data.userName);
			$("#Password").val("");
			$("#NickName").val(data.nickName);
			$("#Title").text("编辑管理员");
			$("#PwdText").text("不修改则留空");
			$("#IsActive").prop("checked", data.isActive == "True");
			$("#editModal").modal("show");
		}
	});
};

//保存
function save() {
	var postData = { "dto": { "Id": $("#Id").val(), "UserName": $("#UserName").val(), "Password": $("#Password").val(), "NickName": $("#NickName").val(),"IsActive":$("#IsActive").prop("checked") } };
	$.ajax({
		type: "Post",
		url: "/Admin/User/Edit",
		data: postData,
		success: function (result) {
			if (1 == result.status) {
				loadTables(1, 10);
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
			url: "/Admin/User/Delete",
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
			url: "/Admin/User/MultiDelete",
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

