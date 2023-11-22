package com.userService.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class UserServiceDAO {

	String jdbcUrl = "jdbc:mysql://172.187.178.153:3306/isec_assessment2";
	String dbUser = "isec";
	String dbPassword = "EUHHaYAmtzbv";
	
    public int insertData(String location, String mileageStr, String vehicle_no, String message, String userName, String dateStr, String timeStr) throws ParseException, ClassNotFoundException {
  	  
   	 	int mileage = Integer.parseInt(mileageStr);
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = dateFormat.parse(dateStr);
	    Time time = null;

	    try {
	        // Check if the timeStr matches the expected format "hh:mm"
	        if (timeStr.matches("^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$")) {
	            // If it matches, add ":00" to the end of the string to match SQL TIME format
	            timeStr += ":00";
	            // Create a Time object
	            time = Time.valueOf(timeStr);
	        }else {
	            // Handle invalid time format
	        	return -1;
	         }
	    }catch (IllegalArgumentException e) {
	    	return -2;
	     }
	    

        try {
       	 Class.forName("com.mysql.cj.jdbc.Driver");
		    
    		// Database connection
    		Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
    			
            
    		// INSERT query
             String sql = "INSERT INTO vehicle_service (date, time, location, mileage, vehicle_no, message, username) VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            
            // Set the parameter values
            preparedStatement.setDate(1, new java.sql.Date(date.getTime())); // Current date
            preparedStatement.setTime(2, time); // Current time
            preparedStatement.setString(3, location);
            preparedStatement.setInt(4, mileage);
            preparedStatement.setString(5, vehicle_no);
            preparedStatement.setString(6, message);
            preparedStatement.setString(7, userName);
            
            // Execute the INSERT statement
            int rowsInserted = preparedStatement.executeUpdate();
            conn.close();
            
            // Check if the insertion was successful
            return rowsInserted;
            // Close resources (Connection, Statements, ResultSet) here
          
        }catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions here
            return -1;
         }
        
    }
   
    public ResultSet getFutureServices(String username) throws ClassNotFoundException, SQLException{
    	
		ResultSet futureResultSet = null;
		Connection conn = null;

	try {
		 // Load the MySQL JDBC driver
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    
	    // Database connection
	    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
	  

	    // SELECT query for future reservations
	    String futureSql = "SELECT * FROM vehicle_service WHERE username = ? AND CONCAT(date, ' ', time) >= ? ORDER BY date, time";
	    
	    PreparedStatement futurePreparedStatement = conn.prepareStatement(futureSql);
	    futurePreparedStatement.setString(1, username);
	    
	    // Set the parameter value (current date and time)
	    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String currentDateTime = dateTimeFormat.format(new Date());
	    futurePreparedStatement.setString(2, currentDateTime);
	    
	    // Execute the SELECT queries for future reservations
		futureResultSet = futurePreparedStatement.executeQuery();
		 
	
		}catch (ClassNotFoundException |SQLException e) {
			e.printStackTrace();
			
		 }finally {
            // Do not close resources here; the ResultSet should be closed by the caller.
          }
	return futureResultSet;
        
    }
    
    public ResultSet getPastServices(String username) throws ClassNotFoundException, SQLException {
    	
			ResultSet pastResultSet = null;
			Connection conn = null;
		
		try {
		
		Class.forName("com.mysql.cj.jdbc.Driver");
			    
		// Database connection
		conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
			  

		// SELECT query for past reservations
		String pastSql = "SELECT * FROM vehicle_service WHERE username = ? AND CONCAT(date, ' ', time) < ? ORDER BY date, time";
		
		PreparedStatement pastPreparedStatement = conn.prepareStatement(pastSql);
	
		pastPreparedStatement.setString(1, username);
		
		// Set the parameter value (current date and time)
		SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentDateTime = dateTimeFormat.format(new Date());
		pastPreparedStatement.setString(2, currentDateTime);
		
		// Execute the SELECT queries for past reservations
		pastResultSet = pastPreparedStatement.executeQuery();
		
		
		}catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			
		 }finally {
	            // Do not close resources here; the ResultSet should be closed by the caller.
	      }
		return pastResultSet;
        
    }
    
    public int deleteServices(int bookingId) throws ClassNotFoundException {
    	
    	PreparedStatement preparedStatement = null;

    	try {
    		Class.forName("com.mysql.cj.jdbc.Driver");
		    
    		// Database connection
    		Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
    			  
    	    // DELETE query
    	    String sql = "DELETE FROM vehicle_service WHERE booking_id = ?";

    	    preparedStatement = conn.prepareStatement(sql);

    	    // Set the parameter value (booking id)
    	    preparedStatement.setInt(1, bookingId);

    	    // Execute the DELETE query
    	    int rowsAffected = preparedStatement.executeUpdate();
    	    
    	    // Verify the success of the delete operation by examining the number of affected rows
    	    conn.close();
    	    
    	    return rowsAffected;
    	    // Close resources (Connection, Statements, ResultSet) here
    	    
    	}catch (ClassNotFoundException | SQLException e) {
    	    e.printStackTrace();
    	    // Handle exceptions here
    	    return -1;
    	 } 
    }
    
}