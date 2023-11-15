<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div className ="login-container">
      <h1>RenteX Vehicle Booking</h1>
      <button className ="login-button" onClick={loginWithAuth0}>Login</button>
      <p>Don't have an account? <a href={`https://${auth0Domain}/signup`}>Create Account</a></p>
    </div>
</body>
</html>