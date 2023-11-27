<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

      
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Login</title>
  <link rel="stylesheet" href="css/login.css">
  <link rel="stylesheet" href="css/nav.css">
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
      <h3>Rent_X Vehicle Service</h3>
      <br>
      <p>"Experience seamless servicing with Rent_X! 
      Easily service vehicles for any journey, from quick 
      commutes to road trip adventures. Your hassle-free 
      travel starts!"</p>
      <br><br>
      <h4>Login With Your Asgardio Account.</h4>
      <br>
      <div class="link">
      	<a href="https://api.asgardeo.io/t/orge2kzg/oauth2/authorize?response_type=code&client_id=AEfeCImfp7MSrxVRF995sDMsYUsa&scope=openid%20address%20email%20phone%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A8082%2FRentX_Vehicle_Booking_App%2Fauthorize.jsp" class="login"><b>Login</b></a>
      <!-- 
      	var redirectUrl = authorizeEndpoint + '?response_type=code' +
        '&client_id=' + clientId +
        '&scope='+scope+
        '&redirect_uri=' + redirectUri;
       
       	Above properties from '/WEB-INF/classes/application.properties' file.
       -->	
      </div> 	
      <div class="signup"><h4>Don't you have an Asgardio account? 
          <a href="https://console.asgardeo.io/">Signup Now</a></h4>
      </div>
    </div>
    
  </div>
</body>
</html>