<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.FileInputStream, java.io.IOException, java.util.Properties" %>
<%@ page import="java.io.InputStream, java.io.IOException" %>

<%
		 // Initialize a Properties object
	    Properties properties = new Properties();

	    // Load the properties file
	    try {
	        InputStream inputStream = application.getResourceAsStream("/WEB-INF/classes/application.properties");
	        properties.load(inputStream);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	

%>
      
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Login</title>
  <link rel="stylesheet" href="../css/login.css">
  <link rel="stylesheet" href="../css/nav.css">
  
  <script type="text/javascript">
	function authorize() {
    	var authorizeEndpoint = '<%= properties.getProperty("authorizeEndpoint") %>';
    	var clientId = '<%= properties.getProperty("client_id") %>';
    	var redirectUri = encodeURIComponent('<%= properties.getProperty("baseurl") %>/RentX_Vehicle_Booking_App/authorize.jsp');

    	var redirectUrl = authorizeEndpoint + '?response_type=code' +
        	'&client_id=' + clientId +
        	'&scope=openid email phone profile' +
        	'&redirect_uri=' + redirectUri;

    	window.location.href = redirectUrl;
	}
	</script>

</head>
<body>
  <div class="container1">
    <nav>
      <div class="logo">
        <a href="#"><b>Rent</b><span><b>_X.</b></span></a>
      </div>
    </nav>
    <div class="content">
      <h2>Welcome !</h2>
      <h3>Rent_X Vehicle Booking</h3>
      <br>
      <p>"Experience seamless booking with Rent_X! 
      Easily reserve vehicles for any journey, from quick 
      commutes to road trip adventures. Your hassle-free 
      travel starts here!"</p>
      <br><br>
      <h4>Login With Your Asgardio Account.</h4>
      <br>
      <div class="link">
      	<a href="#" onclick="authorize()" class="login"><b>Login</b></a>
      </div>
      <div class="signup"><h4>Don't you have an Asgardio account?
          <a href="https://console.asgardeo.io/">Signup Now</a></h4>
      </div>
    </div>
    
  </div>
</body>
</html>