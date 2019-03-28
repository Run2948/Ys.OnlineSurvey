    function checkForm(fm)
	{
		for(var i=0;i<fm.length;i++)
		{
			var title=fm[i].title;
			if(title=="")continue;//忽略未定义title的元素
			var p=title.lastIndexOf("~");
			if(p<0)continue;//忽略title中未定义检查格式的元素
			var info=title.substring(0,p);
			var format=title.substring(p+1,title.length);
			var name=fm[i].name;
			if(name=="")continue;//忽略没有名字的元素
			var value=trim(fm[i].value);
			//fm[i].value=value;//自动除去提交项的两端的空格
			
			if(fm[i].type=="radio")
			{
				if(checkRadio(fm,fm[i]))
				{
					continue;
				}
				else
				{
					return false;
				}
			}
			
			if(fm[i].type=="checkbox")
			{
				if(checkCheckbox(fm,fm[i]))
				{
					continue;
				}
				else
				{
				 	return false;
				}
			}
			
		}
		return true;
	}
	function checkRadio(fm,opt)
	{
		var title=opt.title;
		if(title=="")return true;//忽略未定义title的元素
		var p=title.lastIndexOf("~");
		if(p<0)return true;//忽略title中未定义检查格式的元素
		var info=title.substring(0,p);
		var format=title.substring(p+1,title.length);
		var name=opt.name;
		if(name=="")return true;//忽略没有名字的元素
		if(format=="!")
		{
			//必须选择一个选项
			if(typeof(fm.all[name].length)=="undefined")
			{
				//同名radio只有一个
				if(opt.checked)
				{
					return true;
				}
				else
				{
					alert(info+"\n必须选择"+name);
					opt.focus();
					return false;
				}
			}
			else
			{
				//是一个radio组
				var radios=fm[name];
				for(var j=0;j<radios.length;j++)
				{
					if(radios[j].checked==true)return true;
				}
				alert(info+"\n必须选择此题");
				opt.focus();
				return false;
			}
		}
		else
		{
			//可以一个选项也不选
			return true;
		}
	}
	
	
	function checkCheckbox(fm,opt)
	{
		var title=opt.title;
		if(title=="")return true;//忽略未定义title的元素
		var p=title.lastIndexOf("~");
		if(p<0)return true;//忽略title中未定义检查格式的元素
		var info=title.substring(0,p);
		var format=title.substring(p+1,title.length);
		var name=opt.name;
		if(name=="")return true;//忽略没有名字的元素

		var min=format.match(/min:(\d+)\w*/);
		var max=format.match(/\w*max:(\d+)/);

		if(typeof(fm.all[name].length)=="undefined")
		{
			//只有一个同名checkbox
			if(min!=null)
			{
				if(min[1]==1&&!opt.checked)
				{
					alert(info+"\n必须选上"+name+"选项");
					opt.focus();
					return false;
				}
			}
		}
		else
		{
			//一个checkbox组
			var checkboxes=fm.all[name];
			var check_count=0;
			for(var j=0;j<checkboxes.length;j++)
			{
				if(checkboxes[j].checked)check_count++;
			}
			if(min!=null)
			{
				if(min[1]>check_count)
				{
					alert(info+"\n至少需要选择"+min[1]+"个选项");
					opt.focus();
					return false;
				}
			}
			if(max!=null)
			{
				if(max[1]<check_count)
				{
					alert(info+"\n至多可以选择"+max[1]+"个选项");
					opt.focus();
					return false;
				}
			}
		}
		return true;
	}
/**
 * 除去字符串变量s两端的空格。
 */
	function trim(s)
	{
		s=s.replace(/^ */,"");
		s=s.replace(/ *$/,"");
		return s;
	}
/**
 * 除去字符串表示的数值变量开头的所有的"0"。
 * 比如
 * 	trim0("01")将返回"1"
 * 	trim0("1")将返回"1"
 * 	trim0("10")将返回"10"
 * 	trim0("000")将返回"0"
 */
	function trim0(s)
	{
		if(s.length==0)return s;
		s=s.replace(/^0*/,"");
		if(s.length==0)s="0";
		return s;
	}
/**
 * 取得一个form对象所提交时内部提交参数的QueryString
 * 形如:
 * ?accountName=&userName=&email=&area=0&credit_low=&credit_high=&age_low=&age_high=&userLevel=0
 */
	function getQueryString(fm)
	{
		var qStr="";
		for(var i=0;i<fm.length;i++)
		{
			if(!fm[i].disabled)
			{
				var n=fm[i].name;
				if(n==null)continue;
				if(n.length==0)continue;
				if(fm[i].type=="select-multiple")
				{
					var _vs=fm[i].options;
					for(var _j=0;_j<_vs.length;_j++)
					{
						var _opt=_vs(_j);
						if(_opt.selected)
						{
							var v=_opt.value;
							qStr=qStr+"&"+n+"="+ec(v);
						}
					}
				}
				else
				{
					var v=fm[i].value;
					if(fm[i].type=="radio"||fm[i].type=="checkbox")
					{
						if(!fm[i].checked)continue;
					}
					qStr=qStr+"&"+n+"="+ec(v);
				}
			}
		}
		if(qStr.length>0)qStr="?"+qStr.substr(1);
		return qStr;
	}
	function ec(va)
	{
		return va.replace(/\n/g,"%0D%0A");
	}