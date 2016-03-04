<%@ page language="java" pageEncoding="gb2312"%>
<%@ include file="/commons/taglibs.jsp" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>${CompanyName}--${ProjectName}</title>
    <%@ include file="/commons/meta.jsp" %>
	
	<script src="script/windows.js"></script>
	<script type="text/javascript">

	function addItem() {
		window.self.location = "user.do?p=edit&pageNo=${userForm.pageNo}";
	}
	
	function modifyItem() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ�޸ĵ��û���");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ���޸�һ���û���");
			return;
		}
		if (count == 1) {
			window.self.location = "user.do?p=edit&id=" + 
			                        document.getElementsByName("selectFlag")[j].value + 
			                        "&pageNo=${userForm.pageNo}";
		}
	}
	
	function deleteItem() {
		var flag = false;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				flag = true;
			}		
		}
		if (!flag) {
			alert("��ѡ����Ҫɾ�����û���");
			return;
		}
		if (window.confirm("ȷ��ɾ����")) {
			with (document.getElementById("userForm")) {
				method = "post";
				action = "user.do?p=delete&pageNo=${userForm.pageNo}";
				submit();
			}
		}
	}
	
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}
	
	function queryItem() {
		with (document.getElementById("userForm")) {
			method = "post";
			action = "user.do?p=list&pageNo=1";
			submit();
		}
	}
	
	function resetItem() {
		document.getElementsByName("name").value = "";
	}
	
	function myOnkeypress() {
		if (window.event.keyCode == 13) {
			queryItem();
		}
	}
	
	function topPage() {
		window.self.location = "user.do?p=list&pageNo=${pageModel.topPageNo}&name=${ userForm.name }"
	}
	
	function previousPage() {
		window.self.location = "user.do?p=list&pageNo=${pageModel.previousPageNo}&name=${ userForm.name }"
	}	
	
	function nextPage() {
		window.self.location = "user.do?p=list&pageNo=${pageModel.nextPageNo}&name=${ userForm.name }"
	}
	
	function bottomPage() {
		window.self.location = "user.do?p=list&pageNo=${pageModel.bottomPageNo}&name=${ userForm.name }"
	}
	
	</script>
  </head>
  
  <body>

    <div id="content">
    
    <TABLE cellSpacing="1" cellPadding="2" width="60%" align="center" border="0">
      <TBODY>
      <TR>
        <TD width="522" class="p1" height="2" nowrap><img src="images/mark_arrow_02.gif" width="14" height="14">&nbsp;<b>�û�����</B></TD>
      </TR>
      </TBODY>
    </TABLE>
    
    <hr width="60%">
    
	<%@ include file="/commons/messages.jsp" %>
    
    <form name="userForm" id="userForm" >
    
    <input type="hidden" name="flag" id="flag" value="true">
    	
    <TABLE class=small cellSpacing="1" cellPadding="2" width="60%" align="center" bgColor="#000000" border="0">
      <TBODY>  
      <TR>
          <TD class=TableData align=center>
            <font color="#FF0000">�û���:</font>&nbsp;&nbsp;<input type="text" name="name" id="name" class="BigInput" onkeypress="myOnkeypress()" size="40" maxlength="40" >
            <input name="btnQuery" type="button" class="BigButton" id="btnQuery"  value="��ѯ" onClick="queryItem()">
            <input name="btnReset" type="button" class="BigButton" id="btnReset"  value="����" onClick="resetItem()">
          </TD>
      </TR> 
      </TBODY>
    </TABLE>
    
    <p>
     
    <TABLE class=small cellSpacing="1" cellPadding="2" width="60%" align="center" bgColor="#000000" border="0">
      <TBODY>
      <TR>
      	  <TD class="TableSeparator" width="5%" align="center"><input type="checkbox" name="ifAll" onClick="checkAll()" ></TD>
      	  <TD class="TableSeparator" width="25%" align="center"><strong>�û���</strong></TD>
          <TD class="TableSeparator" width="25%" align="center"><strong>����</strong></TD>
          <TD class="TableSeparator" width="25%" align="center"><strong>��ʦ</strong></TD>
      </TR>
      
      <c:forEach items="${pageModel.list}" var="item">
      <TR>
      	  <TD class=TableData align="center" ><input type="checkbox" name="selectFlag" id="selectFlag" class="checkbox1" value="${item.id }"></td>
	      <TD class=TableData align="center"><font color="#FF0000">${item.name}</font></td>
          <TD class=TableData align="center">${item.password}</TD>
          <TD class=TableData align="center">${item.teacher.name}</TD>
      </TR>
      </c:forEach>
      
      </TBODY>
    </TABLE>
        
    <p>
    <TABLE border="0">
      <TBODY>
      <TR>
      	  <TD class=TableData align="right">
      	     ��${pageModel.totalRecords }����¼&nbsp;&nbsp;��${pageModel.totalPages }ҳ&nbsp;&nbsp;��${pageModel.pageNo }ҳ&nbsp;&nbsp;&nbsp;&nbsp;
      	    <input name="btnTopPage" type="button" class="BigButton" id="btnTopPage" value="��ҳ"  title="��ҳ" onClick="topPage()">
            <input name="btnPreviousPage" type="button" class="BigButton" id="btnPreviousPage" value="��һҳ"  title="��һҳ" onClick="previousPage()">
            <input name="btnNext" type="button" class="BigButton" id="btnNext" value="��һҳ"  title="��һҳ" onClick="nextPage()">
            <input name="btnBottomPage" type="button" class="BigButton" id="btnBottomPage" value="βҳ"  title="βҳ" onClick="bottomPage()">
      	    <input name="btnAdd" type="button" class="BigButton" id="btnAdd"  value="����" onClick="addItem()">
        	<input name="btnDelete" type="button" class="BigButton" id="btnDelete" value="ɾ��" onClick="deleteItem()">
        	<input name="btnModify" type="button" class="BigButton" id="btnModify" value="�޸�"  onClick="modifyItem()">
      	  </TD>
      </TR>
     </TBODY>
	</TABLE>
	</form>
  </body>
</html>