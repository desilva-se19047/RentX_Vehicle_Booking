<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Home</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
  <div class="container2">
    <header>
    <nav>
      <div class="logo">
        <a href="#"><b>Rent</b><span><b>_X.</b></span></a>
      </div>
    </nav>
    </header>
    <div class="content">
      <h3>Hello, Tom !</h3>
      <div class="user-info">
        <ul>
            <li><strong>User Name:</strong> tom23</li>
            <li><strong>Name:</strong> Tom</li>
            <li><strong>Email:</strong> tom@gmail.com</li>
            <li><strong>Contact Number:</strong> 0112456455</li>
            <li><strong>Country:</strong> India</li>
        </ul>
      </div>
    </div>
  </div>
  <div class="reservation-form">
        <h2>Schedule Booking</h2>
        <form>
          <div class="row">
        	<div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
          </div>
          <div class="row">
            <div class="form-group">
                <label for="contactNumber">Contact Number:</label>
                <input type="tel" id="contactNumber" name="contactNumber" required>
            </div>
            <div class="form-group">
                <label for="date">Date of Service:</label>
                <input type="date" id="date" name="date" required>
            </div>
          </div>
          <div class="row">
            <div class="form-group">
                <label for="time">Time:</label>
                <select id="time" name="time" required>
                    <option selected>Choose...</option>
                    <option value="10 AM">10 AM</option>
                    <option value="11 AM">11 AM</option>
                    <option value="12 PM">12 PM</option>
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
                <label for="vehicleNumber">Vehicle Registration Number:</label>
                <input type="text" id="vehicleNumber" name="vehicleNumber" required>
            </div>
            <div class="form-group">
                <label for="mileage">Current Mileage:</label>
                <input type="number" id="mileage" name="mileage" required>
            </div>
          </div>
          <div class="row">
            <div class="form-group">
                <label for="message">Message:</label>
                <textarea id="message" name="message"></textarea>
            </div>
          </div>
            <div class="form-group-1">
                <button type="submit" class="login-button">Submit</button>
                <button type="button" class="login-button" onclick="handleReset()">Reset</button>
            </div>
        </form>
    </div>
    <script>
        function handleReset() {
            document.querySelector("form").reset();
        }
    </script>
</body>
</html>