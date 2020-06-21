<%@page import="java.net.URLDecoder"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��Ű ���ڵ�</title>
</head>
<body>
<!-- 
JSESSIONID
1. TOMCAT �����̳ʿ��� ������ �����ϱ� ���� �߱� �ϴ� Ű
2. �������� ���� ���ٽ� TOMCAT�� Response ����� JSSESSIONID���� �߱޵ȴ�.
��) Set-Cookie : JSESSIONID: D143E160959E1566560826EFEF57D547
3. ������ ���û�� Response�� ���� ���� JSESSIONID�� Request �����
	��Ű�� ���� �־� ������ ��û�Ѵ�.
	��Ű�� ���� JSESSIONID���� ���� �ް� �Ǹ�
	������ ���ο� JSESSIONID  ���� Response ����� �߱޵��� �ʴ´�.
4. Ŭ���̾�Ʈ�κ��� ���޹��� JSESSIONID���� ��������
	���������� ���� �޸� ������ ���¸� ������ ������ ������ �� �ְ� �ȴ�.(HttpSession ��)
5. ������ Full ������(���굵������ �ٸ� ��� ��Ű�� �������� ����)
	��Ʈ��ȣ�� �޶� ����
6. TOMCAT �����̳ʸ� 2�� �̻� ����ϰ� �� ��� ������ ������ �� ����.
	��, �����ϱ� ���ؼ��� ���� Ŭ�����͸� ȯ���� �����ؾ� �Ѵ�.
	Ŭ����Ʈ�� ȯ�� : �������� �ٸ��������� ��û�� ������ �������� 
	Ŭ����Ʈ������ ������ ���ָ� ������ ������ �ϰ���( ROBIN , ��������)

 -->


<!-- 
��Ű(Cookie)
1. �⺻������ Ŭ���̾�Ʈ ���� : ���������� ���� ��ġ�� �ٸ���.
2. ������ ��û�� Response ����� �ڵ����� �����ؼ� Ŭ���̾�Ʈ�� ���۵�
��) Set-Cookie : JSESSIONID: D143E160959E1566560826EFEF57D547
3. �����ܿ��� �ʿ信 ���� Ŭ���̾�Ʈ�� �����ϵ��� ����(Set-Cookie) : JSESSIONID
4. HttpOnly, Secure �Ӽ�
	���� -> Ŭ���̾�Ʈ�� �����ָ�, Ŭ���̾�Ʈ -> ������ ���� ���� ����.
	����� â����  Response �Ӽ����θ� Ȯ�� ����
5. ���� ��Ű, ������ ��Ű
1) ����ð��� �����ϸ� ������ ��Ű, ��������
2) ����ð��� ������ ������Ű, �޸�����, ������ ������ ������


 -->
<h2> ��Ű �ѱ� �Է½� ���ڵ� ó�� ����, �׷��� ���</h2>
<%


	Cookie user = new Cookie("username", URLEncoder.encode("�̿��", "EUC-KR"));
	Cookie pass = new Cookie("password", URLEncoder.encode("�̿��1234", "EUC-KR"));
	
	//����ð��� �������ش�.(zero�� ���� �� �������ڸ��� �����ȴ�.)
	//setMaxAge(-1) :
	//setMaxAge(0) :
	//setMaxAge(60*60*24) : �� * �ð� * ����
	//user.setMaxAge(60*60*24);
	//pass.setMaxAge(60*60*24);
	
	//2��
	user.setMaxAge(60*2);
	pass.setMaxAge(60*2);
	response.addCookie(user);
	response.addCookie(pass);
	System.out.println("user >>> " + user);
	System.out.println("pass >>> " + pass);
	
	//HttpOnly ���� (domain.cookie�� �̿��ؼ� �������� ��Ű�� ���� ���ϵ��� �ϴ� ��.)
	//�� �������� HttpOnly �� �����ϴ� ��� ��.
	//���������� ũ�ν� ����Ʈ ��ũ��Ʈ(XSS) ������ �����ϸ� ��Ű���� ������ �� �ִ�.
	//������ SetCookie ����� ������ HttpOnly �ɼ��� �־� ��Ű ���� ����
	//web.xml ����
	//<session-config>
	//<cookie-cofign>
	//<http-only>true</http-only>
	//</cookie-config>
	//</session-config>
	//<server.xml
	//<Context path="" useHttpOnly="true">
	
	String sessionID = request.getSession().getId();
	response.setHeader("SET-COOKIE", "JSESSIONID="+sessionID+";HttpOnly");
	
	Cookie[] ckVal = request.getCookies();
	System.out.println("ckVal >>> " + request.getCookies());
	if (ckVal != null){
		for(Cookie cook: ckVal){
			out.println(cook.getName() + ":");
			out.println(cook.getValue() + "<br>");
			System.out.println("cookie >>> " + cook.getName() + ":");
			System.out.println("cookie >>> " + cook.getValue() + ":");
		}
	}//end of if
%>
<h2> ��Ű �ѱ۷� ���ڵ��Ͽ� ���</h2>
<%
	if(ckVal != null){
		for(Cookie cook: ckVal){
			out.println(cook.getName() + ":");
			out.println(URLDecoder.decode(cook.getValue(), "EUC-KR") + "<br>");
			System.out.println("cookie >>> " + cook.getName() + ": " + URLDecoder.decode(cook.getValue(), "EUC-KR"));
		}
	}//end of if
%>
</body>
</html>