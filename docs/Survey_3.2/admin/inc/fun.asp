<%
function StrCat(str,strlen)
  if len(str)>cint(strlen) then
    StrCat=left(str,cint(strlen)-3)+"..."
  else 
    StrCat=str
  end if
end function
%>
