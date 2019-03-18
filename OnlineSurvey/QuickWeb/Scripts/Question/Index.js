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

//加载类型列表数据
function loadTables(startPage, pageSize) {
	$("#tableBody").html("");
	$("#checkAll").prop("checked", false);
	$.ajax({
		type: "GET",
		url: "/Admin/Question/GetQuestions?pageIndex=" + startPage + "&pageSize=" + pageSize + "&_t=" + new Date().getTime(),
		success: function (data) {
			$.each(data.rows[0], function (i, item) {
				var tr = "<tr>";
				tr += "<td align='center'><input type='checkbox' class='checkboxs' value='" + item.id + "'/></td>";
				tr += "<td>" + item.topic + "</td>";
				tr += "<td>" + item.systemType.typeName + "</td>";
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
			loadTypes(data);
		}
	});
};

function loadTypes(data) {
	$("#ItemType").select2({ minimumResultsForSearch: -1 });
	var option = "";
	$.each(data.rows[1], function (i, item) {
		option += "<option value='" + item.id + "'>" + item.typeName + "</option>";
	});
	$("#ItemType").html(option);
}

//新增
function add() {
	$("#Id").val("");
	$("#ItemCount").val("4");
	$("#Topic").val("");
	$("#Title").text("新增话题");
	$("#ItemType").val('').select2({ minimumResultsForSearch: -1 });
	createOption();
	//弹出新增窗体
	$("#editModal").modal("show");
};

//编辑
function edit(id) {
	$.ajax({
		type: "Get",
		url: "/Admin/Question/Get?id=" + id + "&_t=" + new Date().getTime(),
		success: function (result) {
			var data = result.data;
			$("#Id").val(data.id);
			$("#ItemCount").val(data.itemCount);
			$("#Topic").val(data.topic);
			$("#ItemType").val(data.itemType).select2({ minimumResultsForSearch: -1 });
			recreateOption(data);
			$("#Title").text("编辑话题");
			$("#editModal").modal("show");
		}
	});
};

//保存
function save() {
	var postData = {
		"dto":
		{
			"Id": $("#Id").val(), "Topic": $("#Topic").val(), "Name": $("#Name").val(), "ItemType": $("#ItemType").val(),"ItemCount": $("#ItemCount").val(),
			"Option1":$("#Option1").val(),
			"Option2":$("#Option2").val(),
			"Option3":$("#Option3").val(),
			"Option4":$("#Option4").val(),
			"Option5":$("#Option5").val(),
			"Option6":$("#Option6").val(),
			"Option7":$("#Option7").val(),
			"Option8":$("#Option8").val(),
			"Option9":$("#Option9").val()
		}
	};
	$.ajax({
		type: "Post",
		url: "/Admin/Question/Edit",
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
			url: "/Admin/Question/Delete",
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
			url: "/Admin/Question/MultiDelete",
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

//创建空选项
function createOption() {
	var count = parseInt($("#ItemCount").val());
	if (count <= 0 || count > 9) return;
	$("#options").empty();
	var options = '';
	for (var i = 1; i <= count; i++) {
		options += '<div class="form-group">' +
			'<label class="col-sm-3 control-label" for="Option1">选项' + i + '</label>' +
			'<div class="col-sm-8">' +
			'<input class="form-control" id="Option' + i + '" type="text" placeholder="选项' + i + '" autocomplete="off" />' +
			'</div>' +
			'</div>';
	}
	$("#options").append(options);
}

//创建带数据的选项
function recreateOption(data) {
	var count = data.itemCount;
	if (count <= 0 || count > 9) return;
	$("#options").empty();
	var options = '';
	for (var i = 1; i <= count; i++) {
		var key = "option" + i;
		options += '<div class="form-group">' +
			'<label class="col-sm-3 control-label" for="Option1">选项' + i + '</label>' +
			'<div class="col-sm-8">' +
			'<input class="form-control" id="Option' + i + '" type="text" placeholder="选项' + i + '" autocomplete="off" value="' + data[key] + '"/>' +
			'</div>' +
			'</div>';
	}
	$("#options").append(options);
}

