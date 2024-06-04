# Odometric-Position-Estimation-and-Error-Propagation
This code implements the odometry error model for a differential drive robot (TurtleBot_Burger).

Key Features:

    Customizable left and right wheel speeds
    Realistic error model for odometry (incorporates distance and angular errors)
    User-defined covariance matrix for error tuning
    Visualization of uncertainty ellipses 

Functionality:

    Simulates robot movement for 10 seconds with 0.1s time steps
    Calculates robot position and orientation based on odometry data
    Incorporates error model to account for distance and angular inaccuracies
    Updates covariance matrix to represent position uncertainty
    Generates uncertainty ellipses to visualize robot's position distribution (once per second)

Benefits:

    Analyzes robot's position uncertainty over time


Note: Requires user-defined TurtleBot dimensions and covariance matrix adjustment for optimal results.
![Q1_Uncertaint_Elipses_curved_movement](https://github.com/AlpMercan/Odometric-Position-Estimation-and-Error-Propagation/assets/112685013/5b7e2108-21f2-481f-8371-569037a98b79)
![Q1_Uncertaint_Elipses_straight_movement](https://github.com/AlpMercan/Odometric-Position-Estimation-and-Error-Propagation/assets/112685013/bb97d77e-9ba0-43d5-af87-d6402162748b)


