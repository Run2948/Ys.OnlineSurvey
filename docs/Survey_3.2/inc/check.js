    function checkForm(fm)
	{
		for(var i=0;i<fm.length;i++)
		{
			var title=fm[i].title;
			if(title=="")continue;//����δ����title��Ԫ��
			var p=title.lastIndexOf("~");
			if(p<0)continue;//����title��δ�������ʽ��Ԫ��
			var info=title.substring(0,p);
			var format=title.substring(p+1,title.length);
			var name=fm[i].name;
			if(name=="")continue;//����û�����ֵ�Ԫ��
			var value=trim(fm[i].value);
			//fm[i].value=value;//�Զ���ȥ�ύ������˵Ŀո�
			
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
		if(title=="")return true;//����δ����title��Ԫ��
		var p=title.lastIndexOf("~");
		if(p<0)return true;//����title��δ�������ʽ��Ԫ��
		var info=title.substring(0,p);
		var format=title.substring(p+1,title.length);
		var name=opt.name;
		if(name=="")return true;//����û�����ֵ�Ԫ��
		if(format=="!")
		{
			//����ѡ��һ��ѡ��
			if(typeof(fm.all[name].length)=="undefined")
			{
				//ͬ��radioֻ��һ��
				if(opt.checked)
				{
					return true;
				}
				else
				{
					alert(info+"\n����ѡ��"+name);
					opt.focus();
					return false;
				}
			}
			else
			{
				//��һ��radio��
				var radios=fm[name];
				for(var j=0;j<radios.length;j++)
				{
					if(radios[j].checked==true)return true;
				}
				alert(info+"\n����ѡ�����");
				opt.focus();
				return false;
			}
		}
		else
		{
			//����һ��ѡ��Ҳ��ѡ
			return true;
		}
	}
	
	
	function checkCheckbox(fm,opt)
	{
		var title=opt.title;
		if(title=="")return true;//����δ����title��Ԫ��
		var p=title.lastIndexOf("~");
		if(p<0)return true;//����title��δ�������ʽ��Ԫ��
		var info=title.substring(0,p);
		var format=title.substring(p+1,title.length);
		var name=opt.name;
		if(name=="")return true;//����û�����ֵ�Ԫ��

		var min=format.match(/min:(\d+)\w*/);
		var max=format.match(/\w*max:(\d+)/);

		if(typeof(fm.all[name].length)=="undefined")
		{
			//ֻ��һ��ͬ��checkbox
			if(min!=null)
			{
				if(min[1]==1&&!opt.checked)
				{
					alert(info+"\n����ѡ��"+name+"ѡ��");
					opt.focus();
					return false;
				}
			}
		}
		else
		{
			//һ��checkbox��
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
					alert(info+"\n������Ҫѡ��"+min[1]+"��ѡ��");
					opt.focus();
					return false;
				}
			}
			if(max!=null)
			{
				if(max[1]<check_count)
				{
					alert(info+"\n�������ѡ��"+max[1]+"��ѡ��");
					opt.focus();
					return false;
				}
			}
		}
		return true;
	}
/**
 * ��ȥ�ַ�������s���˵Ŀո�
 */
	function trim(s)
	{
		s=s.replace(/^ */,"");
		s=s.replace(/ *$/,"");
		return s;
	}
/**
 * ��ȥ�ַ�����ʾ����ֵ������ͷ�����е�"0"��
 * ����
 * 	trim0("01")������"1"
 * 	trim0("1")������"1"
 * 	trim0("10")������"10"
 * 	trim0("000")������"0"
 */
	function trim0(s)
	{
		if(s.length==0)return s;
		s=s.replace(/^0*/,"");
		if(s.length==0)s="0";
		return s;
	}
/**
 * ȡ��һ��form�������ύʱ�ڲ��ύ������QueryString
 * ����:
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