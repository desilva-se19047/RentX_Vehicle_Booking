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
      	<a href="https://api.asgardeo.io/t/orge2kzg/oauth2/authorize?response_type=code&client_id=mDFEsWzT3K8kf11sbJFs2Opjex8a&scope=openid%20email%20phone%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2FRentX_Vehicle_Booking_App%2Fauthorize.jsp" class="login"><b>Login</b></a>
      </div>
      <div class="signup"><h4>Don't you have an Asgardio account?
          <a href="https://console.asgardeo.io/">Signup Now</a></h4>
      </div>
    </div>
    
  </div>
</body>
</html>