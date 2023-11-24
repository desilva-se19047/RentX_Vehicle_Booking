<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.userService.dao.*" %>
<%@ page import="java.util.Properties" %> 
<%@ page import="java.io.InputStream, java.io.IOException" %>   

<% 

	UserServiceDAO service = new UserServiceDAO();

	// Database connection
	String jdbcdbUrl = "jdbc:mysql://172.187.178.153:3306/isec_assessment2";
	String dbUser = "isec"; 
	String dbPassword = "EUHHaYAmtzbv";
	ResultSet pastResultSet = null;
	ResultSet futureResultSet = null;
		
	    
		
	try {
	   	//Form was submitted
   		if (request.getParameter("submit") != null) {
        	String location = request.getParameter("location");
        	String mileageStr = request.getParameter("mileage");
        	String vehicle_no = request.getParameter("vehicle");
        	String message = request.getParameter("message");
        	String userName = request.getParameter("usernameField");
        	String dateStr = request.getParameter("date");
        	String timeStr = request.getParameter("time");
    	
        	// Insert data to the database
        	int rowsInserted =  service.insertData(location,  mileageStr, vehicle_no,  message,  userName,  dateStr,  timeStr);
        	if (rowsInserted > 0) {
        		String successMessage = "Data inserted successfully.";
            	request.setAttribute("successMessage", successMessage);
            	response.sendRedirect(request.getRequestURI() + "#service");
             
         	}
         
         	else if(rowsInserted == -1){
        	 	out.println("Invalid time format. Please enter time in hh:mm format.");
         	}
         
         	else if(rowsInserted == -2){
        	 	out.println("Error parsing time");	 	   
         	}
        
         	else {
        	 	out.println("Failed to insert data.");
         	}
         
   		}
   		
	   	//Delete button is clicked
     	if (request.getParameter("delete") != null){
    	
    		String bookingId = request.getParameter("bookingID");
    	
    		int id = Integer.parseInt(bookingId);
    		//delete the row
    		int rowsAffected = service.deleteServices(id);
    	
    		if (rowsAffected > 0) {
    			//refresh the site  
    		 	response.sendRedirect(request.getRequestURI()); 
	    	}
    		
    		else if(rowsAffected == -1){
	    		out.println("Error in the databse. Try again later");
	    	} 
    		
    		else {
	        out.println("No data found for the given booking ID");
	    	}	
    	
    	} 
   	
    	if (request.getParameter("pastRes") != null){
    	
    	 	String userName = request.getParameter("usernameField2");
    	 	
    	 	//get the past services from the database
    	 	pastResultSet = service.getPastServices(userName);
    	
    	
    	}
    	
    	if (request.getParameter("futureRes") != null){
    	
    	 	String userName = request.getParameter("usernameField3");
    	 
    	 	//get the future services from the database
			futureResultSet = service.getFutureServices(userName);

    	}
   
	
	}catch (ClassNotFoundException e) {
		e.printStackTrace();
			
	 }
		
		
	//Properties object
	Properties properties = new Properties();

	// Load the properties file
	try {
	 	InputStream inputStream = application.getResourceAsStream("/WEB-INF/classes/application.properties");
	 	properties.load(inputStream);
	}catch (IOException e) {
	    e.printStackTrace();
	 }
		
%>


    
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Home</title>
	<link rel="stylesheet" href="../css/home.css">
	<link rel="stylesheet" href="../css/nav.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<script type="text/javascript">
		//set the user info
		const accessToken = localStorage.getItem('access_token');
	    
	    if(accessToken){
	    	
	    var settings = {
	        "url": infoUrl,
	        "method": "GET",
	        "timeout": 0,
	        "headers": {
	            "Authorization": "Bearer " + accessToken
	        },
	    };
	
	    $.ajax(settings)
	        .done(function (response) {
	            console.log(response);
	            var username =  response.username;
	            var given_name = response.given_name;
	            var phone = response.phone_number;
	            var email = response.email;
	            var parts = given_name.split(' ');
	            var firstName = parts[0];
	            var address = response.address;
	            var country = address.country;
	            console.log(country);
	            document.getElementById('givenName').textContent = response;
	            document.getElementById('name').textContent = firstName;
	            document.getElementById('email').textContent = email;
	            document.getElementById('phone').textContent = phone;
	            document.getElementById('country').textContent = country;
	            
	            document.getElementById('submit').addEventListener('click', function () {
	                // Set the username as a hidden field value in the form
	                document.getElementById('usernameField').value = username;
	             });
	            
	            document.getElementById('pastRes').addEventListener('click', function () {
	                // Set the username as a hidden field value in the form
	                document.getElementById('usernameField2').value = username;
	               
	            });
	            
	            document.getElementById('futureRes').addEventListener('click', function () {
	                // Set the username as a hidden field value in the form
	                document.getElementById('usernameField3').value = username;
	               
	            });
	             
	         
	        })
	        
	        .fail(function (jqXHR, textStatus, errorThrown) {
	            // Handle any errors here
	            console.error('Error:', errorThrown);
	            alert("Error in the authorization. Login again!");
	            window.location.href = "../login.jsp";
	        });
	    }
	    
	    else{
	    	window.location.href = "../login.jsp";	
	    }
	</script>
	
	<script type="text/javascript">
		//set the logout
		const idToken = localStorage.getItem('access_token');	
		const state = localStorage.getItem('state');	
		
	   	document.getElementById("client-id").value = client_Id;
	   	document.getElementById("post-logout-redirect-uri").value = postLogoutRedirectUri;
	   	document.getElementById("state").value = state;
	</script>
	
	<script type="text/javascript">
		//set the globle parameters
		const infoUrl = '<%= properties.getProperty("userinfoEndpoint") %>';
		const client_Id = '<%= properties.getProperty("client_id") %>';
		const client_secret = '<%= properties.getProperty("client_secret") %>';
		const postLogoutRedirectUri = '<%= properties.getProperty("baseurl") %>' + '/RentX_Vehicle_Booking_App/login.jsp';
		const introspectionEndpointUrl ='<%= properties.getProperty("introspectionEndpoint") %>';	
	</script>
	
</head>

<body>
  
  <section id="home">
    <nav>
      <div class="logo">
        <a href="#"><b>Rent</b><span><b>_X.</b></span></a>
      </div>
      <div class="menu">
      	<a href="#"><b>Home</b></a>
      	<a href="#service"><b>Scheduling</b></a>
      	<a href="#history"><b>History</b></a>
      	<a href="#info"><b>Profile</b></a>
      </div>      
    </nav>
  </section>
  
  <section id="info">
    <div class="content">	          	
    	<h3>Hello...!</h3>
    	<h2 id="givenName"></h2>
	    <div class="user-info">
	        <ul>
	            <li>Email : <span id = 'email'></span></li>
	  			<li>Contact: <span id = 'phone'></span></li>
	  			<li>Country: <span id = 'country'></span></li>
	        </ul>
	    </div>
	    <div class="actions">
	  		<form id="logout-form" action="<%= properties.getProperty("logoutEndpoint") %>" method="POST">
	        	<input type="hidden" id="client-id" name="client_id" value="">
	        	<input type="hidden" id="post-logout-redirect-uri" name="post_logout_redirect_uri" value="">
	        	<input type="hidden" id="state" name="state" value="">
	        	<div class="link">
                	<button type="submit">Logout</button>
            	</div>
	    	</form>
	 	</div>
    </div>
  </section>
  
  <section id="service">
  
  <div class="reservation-form">
  	
        <h2>Schedule Booking</h2>
        <form method="post" id="contactForm" name="contactForm">
          
          <div class="row">
            <div class="form-group">
                <label for="date">Date of Service:</label>
                <input type="date" id="date" name="date" min="<%= java.time.LocalDate.now() %>"  required>
            </div>
            <div class="form-group">
                <label for="time">Time:</label>
                <input type="time" id="time" name="time" required>
            </div>
          </div>
          
          <div class="row">           
            <div class="form-group">
                <label for="vehicle">Vehicle:</label>
                <select id="vehicle" name="vehicle" required>
					<option selected>Choose...</option>
					<option value="AD-011"> Suzuki-Alto(2020)</option>
					<option value="BC-022">Dolphin(2011)</option>
					<option value="FGE-004">Suzuki-WagonR(2015)</option>
					<option value="CQA-084">Toyota-Prius(2012)</option>
					<option value="AAA-015">Honda-Fit(2020) </option>
				</select>
            </div>
            <div class="form-group">
                <label for="location">Location:</label>
                <select id="location" name="location" required>
                    <option selected>Choose...</option>
                    <option value="Ampara">Ampara</option>
				    <option value="Anuradhapura">Anuradhapura</option>
            		<option value="Badulla">Badulla</option>
				    <option value="Batticaloa">Batticaloa</option>
					<option value="Colombo">Colombo</option>
				    <option value="Galle">Galle</option>
            		<option value="Gampaha">Gampaha</option>
				    <option value="Hambantota">Hambantota</option>
				    <option value="Jaffna">Jaffna</option>
				    <option value="Kalutara">Kalutara</option>
				    <option value="Kandy">Kandy</option>
            		<option value="Kegalle">Kegalle</option>
            		<option value="Kilinochchi">Kilinochchi</option>
				    <option value="Kurunegala">Kurunegala</option>
				    <option value="Mannar">Mannar</option>
				    <option value="Matale">Matale</option>
            		<option value="Matara">Matara</option>
            		<option value="Monaragala">Monaragala</option>
				    <option value="Mullaitivu">Mullaitivu</option>
				    <option value="Nuwara Eliya">Nuwara Eliya</option>
            		<option value="Polonnaruwa">Polonnaruwa</option>
				    <option value="Puttalam">Puttalam</option>
				    <option value="Ratnapura">Ratnapura</option>
				    <option value="Trincomalee">Trincomalee</option>
				    <option value="Vavuniya">Vavuniya</option>
                </select>
            </div>
          </div>
          
          <div class="row">            
            <div class="form-group">
                <label for="mileage">Current Mileage:</label>
                <input type="number" id="mileage" name="mileage" step="1" min="1" pattern="\d+" placeholder="Enter the total mileage" required>
            </div>
            <input type="hidden" id="usernameField" name="usernameField" value="" >
          </div>
          
          <div class="row">
            <div class="form-group">
                <label for="message">Message:</label>
                <textarea id="message" name="message" cols="20" rows="6"  placeholder="Write your message"></textarea>
            </div>
          </div>
          
          <div class="form-group-1">
              <button type="submit" value="Submit" id="submit" name="submit" class="login-button"><h3>Submit</h3></button>
          </div>
        </form>
    </div>
    </section>
    
    <section id = "history">
	<div class="select-history">
		<h2>See the Reservations. Click below</h2>
	</div>
	
	<div class="foroms">
		<form class="mb" method="post" id="myForm" action="?showFuture=true#history" onclick="document.getElementById('future').style.display='block'"  >		
			<input type="hidden" id="usernameField3" name="usernameField3" value="" >				              
			<input type="submit" class="res" id="futureRes" name="futureRes" value= "Future Reservation" >
		</form>
		<br>
		<form class="mb" method="post" id="myForm"  action="?showPast=true#history" onclick="document.getElementById('past').style.display='block'" >
			<input type="hidden" id="usernameField2" name="usernameField2" value="" >				              
			<input type="submit" class="res" id="pastRes" name= "pastRes" value="Past Reservation" >
		</form>
	</div>
	
	<br><br>
	
	<% if (request.getParameter("showFuture") != null && request.getParameter("showFuture").equals("true")) { %>
	
	<div class="future" id="future">
	<h2 id="tableName">Future Reservations</h2>
	<br>
	<table>
	        <tr>
	            <th>Booking ID</th>
	            <th>Date</th>
	            <th>Time</th>
	            <th>Location</th>
	            <th>Mileage</th>
	            <th>Vehicle_No</th>
	            <th>Message</th>
	            <th>Action</th>
	        </tr>
	        <%
		           
	        Date currentDate = new Date();
	        
	        if (futureResultSet != null) {
	            while (futureResultSet.next()) {
	            	
	            	Date date = futureResultSet.getDate("date");
	            	
	            	if(date.before(currentDate)){
	            		 continue;
	            	}
	                int bookingId = futureResultSet.getInt("booking_id");
	                Time time = futureResultSet.getTime("time");
	                String location = futureResultSet.getString("location");
	                int mileage = futureResultSet.getInt("mileage");
	                String vehicleNo = futureResultSet.getString("vehicle_no");
	                String message0 = futureResultSet.getString("message");
	                
	            
	        %>
	        <tr>
	            <td><%= bookingId %></td>
	            <td><%= date %></td>
	            <td><%= time %></td>
	            <td><%= location %></td>
	            <td><%= mileage %></td>
	            <td><%= vehicleNo %></td>
	            <td><%= message0 %></td>
	            <td><a href="#id01"><button onclick="document.getElementById('id01').style.display='block';  document.getElementById('bookingID').value = <%= bookingId %>;" class="delete">Delete</button></a></td>
	        </tr>
	        <% 
	            }}
	            
	    %>
	    </table>
	    <br>
	    <br>
	</div>
	<% } %>
	
	<% if (request.getParameter("showPast") != null && request.getParameter("showPast").equals("true")) { %>
	<div class="past" id="past">
	<h2 id="tableName">Past Reservations</h2>
	<br>
	 	<table>
		        <tr>
		            <th>Booking ID</th>
		            <th>Date</th>
		            <th>Time</th>
		            <th>Location</th>
		            <th>Mileage</th>
		            <th>Vehicle_No</th>
		            <th>Message</th>
		        </tr>
		        <%
		        
		        Date currentDate = new Date();
			          
		        if (pastResultSet != null) {
		        	
		            while (pastResultSet.next()) {
		            	
		            	Date date = pastResultSet.getDate("date");
		            	if(!date.before(currentDate)){
		            		 continue;
		            	}
		                int bookingId = pastResultSet.getInt("booking_id");
		                Time time = pastResultSet.getTime("time");
		                String location = pastResultSet.getString("location");
		                int mileage = pastResultSet.getInt("mileage");
		                String vehicleNo = pastResultSet.getString("vehicle_no");
		                String message1 = pastResultSet.getString("message");
		                
		            
		        %>
		        <tr>
		            <td><%= bookingId %></td>
		            <td><%= date %></td>
		            <td><%= time %></td>
		            <td><%= location %></td>
		            <td><%= mileage %></td>
		            <td><%= vehicleNo %></td>
		            <td><%= message1 %></td>
		        </tr>
		        <% 
		            }}
		            
		    %>
		    </table>
		    <br>
		    <br>
		    
	</div>
	<% } %>
	
	
	
	
	<div id="id01" class="modal">
	  <form class="modal-content" method="post" >
	    <div class="container2">
	      <h2>Delete Reservation</h2>
	      <p>Are you sure you want to delete your reservation?</p>
	    	<input type="hidden" id="bookingID" name="bookingID" value="" >
	      <div class="clearfix">
	        <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
	        <input type="submit" value="Delete" name="delete" onclick="document.getElementById('id01').style.display='none'" class="deletebtn">
	      </div>
	    </div>
	  </form>
	</div>
	
	</section>
	
	
	<footer>
        <p>Rent_X &copy; 2023. Created by Prasadini De Silva.</p>
        <br>
        <p>Discover the process behind the creation of this by reading my article.</p> 
        <div class="medium">
        <h4><a href="https://medium.com/@deprasadini/rent-x-develop-a-web-application-using-asgardeo-authentication-5f394279bcd4">medium.com</a></h4>
    	</div>
    </footer>
	
	
	<script type="text/javascript">
		// target all anchor link elements
		const links = document.querySelectorAll('nav a');
	
		// Function to scroll to a specific section based on the URL hash
		function scrollToSection() {
    if (window.location.hash === '#service') {
		        var servicesSection = document.getElementById('service');
		        if (servicesSection) {
		            servicesSection.scrollIntoView({ behavior: 'smooth' });
		        }
		    }
		}
	
		// Call the scroll function when the page loads
		window.onload = function() {
		    scrollToSection();
		};
	</script>
	
</body>
</html>