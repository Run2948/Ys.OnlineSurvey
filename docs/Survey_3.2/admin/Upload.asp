<!--#include file="inc/right.asp"--> 
<!--#include file="UPLOAD.INC"-->
<style type="text/css">
<style type="text/css">
<!--
body,td,th {
	font-size: 12px;
}
-->
</style>
<%
dim arr(3)
dim upload,file,formName,formPath,iCount,filename,fileExt,i
set upload=new upload_Xiao5u
						
formPath="../upload/"

	''�г������ϴ��˵��ļ�
    for each formName in upload.file
      set file=upload.file(formName)
	  if file.filesize>0 then
      if file.filesize>1000000 then
		response.write "<font size=2>ͼƬ��С����������[<a href=# onclick=history.go(-1)>�����ϴ�</a>]</font>"
		response.end
      end if
	  fileExt=lcase(right(file.filename,4))
	  if fileExt<>".jpg" and fileExt<>".gif" and fileExt<>".bmp" and fileExt<>".png" then
         response.write "<font size=2>�ļ���ʽ���ƣ���֧��gif,jpg,jpeg,png,bmp[<a href=# onclick=history.go(-1)>�������ϴ�</a>]</font>"
         response.end
      end if
	end if
    NewName = file.FileName
    fileNew = mid(NewName, InStrRev(NewName, ".") + 1)
			
	filename=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)& "." & fileNew
	
    if file.FileSize>0 then
       file.SaveAs Server.mappath(formpath&filename)
       response.write "�ϴ��ɹ� <a href=# onclick=history.go(-1)>�뷵��</a>" 

	   end if
set file=nothing
next
set upload=nothing

getpath_frist=split(right(request.ServerVariables("URL"),len(request.ServerVariables("URL"))-1),"/")  
for ii=lbound(getpath_frist) to ubound(getpath_frist)-2 
    getpath_full=getpath_full&"/"&getpath_frist(ii)  
next  
fullurlpath="http://"&request.ServerVariables("HTTP_HOST")&getpath_full&"/" 
Response.Write "<script>parent.add.pic.value='<img src="&fullurlpath&"upload/"&FileName&">'</script>"
%>
