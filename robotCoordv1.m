function [deltaX, deltaY, rotation] = robotCoordv1 (x0, y0, x1, y1)
% DESCRIPTION
%{
Robot Coordinate Computation Algorithm
====================================
This function takes in the cartesian of two inputs with fixed locations on
a robot and calculates the cartesian change in the robot and the rotation
of the robot.

Created by tlee753
Version 1.0
%}

% SETUP CONSTANTS
xPos0 = 0;
yPos0 = 1;
xPos1 = 0;
yPos1 = -1;
% coordinates of mice locations relative to origin of the robot
% measurement is in inches

orientPos0 = 0;
orientPos1 = pi;
% angled orientation of the mice relative to the robot
% basically, the angle between the x axis of the robot and the x axis of each mouse sensor
% orientation of zero is facing forward
% measurement is in radians


% CONSTANT MATRICIES
xMatrix = [xPos0, xPos1];
yMatrix = [yPos0, yPos1];
% creates matricies of x and y positions of mouse sensors

orientMatrix = [orientPos0, orientPos1];
% creates matrix of orientation of mouse sensors

Ax = [sin(orientMatrix)', cos(orientMatrix)', -yMatrix'];
Ay = [cos(orientMatrix)', -sin(orientMatrix)', xMatrix'];

A = [Ax; Ay];
% creates tranformation matrix based on trigonometry

pinvA = (A'*A) \ A';
% creates psuedo inverse matrix of transformation matrix


% COORDINATE INPUTS
xInput = [x0, x1];
yInput = [y0, y1];
% creates matrix of x and y mouse inputs for calculation use


% CALCULATIONS
result = pinvA * [xMatrix'; yMatrix'];
% calculates resulting robot transformation matrix

deltaX = result(2);
deltaY = result(1);
rotation = result(3);
% separates results into robot components


% ROUNDING CORRECTIONS
if deltaX > -0.00000000001 && deltaX < 0.00000000001
    deltaX = 0;
end
if deltaY > -0.00000000001 && deltaY < 0.00000000001
    deltaY = 0;
end
if rotation > -0.00000000001 && rotation < 0.00000000001
    rotation = 0;
end
% if statements to adjust for computer error

end