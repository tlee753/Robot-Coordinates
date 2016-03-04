import struct
from math import *
import numpy

theta0 = 0
phi0 = pi/2
r0 = 1

theta1 = pi
phi1 = pi/2
r1 = 1
# theta is the position of the orgin of the mouse with respect to the x axis of the robot
# phi is based off of the axis created by theta
# in our case phi corrects theta so mouses are pointed straght ahead
# radii are distances mice are from origin (think polar coordinates)
# rotation of the robot is output where positive angle is clockwise direction

x0 = 0
y0 = 1
x1 = 0
y1 = 1
# cartesian inputs where one unit is one radian

alpha0 = theta0 + phi0
alpha1 = theta1 + phi1

A = [[sin(alpha0), -cos(alpha0), r0*cos(phi0)],
	[cos(alpha0), sin(alpha0), r0*sin(phi0)],
	[sin(alpha1), -cos(alpha1), r1*cos(phi1)],
	[cos(alpha1), sin(alpha1), r1*sin(phi1)]
	]
# transformation matrix (see source)

pInvA = numpy.linalg.pinv(A)
inputs = [x0, y0, x1, y1]
deltaX, deltaY, rotation = numpy.dot(pInvA, inputs)
# finds psuedo inverse of matrix for calculation (see source)

if (deltaX < 0.00000000001 and deltaX > -0.00000000001):
    deltaX = 0
if (deltaY < 0.00000000001 and deltaY > -0.00000000001):
    deltaY = 0
if (rotation < 0.00000000001 and rotation > -0.00000000001):
    rotation = 0
# corrects the rounding error for values extremely close to zero

print '\nThe Robot moved %.4f in the X direction.' % deltaX
print 'The Robot moved %.4f in the Y direction.' % deltaY
print 'The Robot rotated %.4f radians.' % rotation
print 'The Robot rotated %.4f degrees.' % degrees(rotation)
# print outputs


# Works Cited
# http://stanford.edu/~sebell/oc_projects/mouse_paper_colloquium_22march11.pdf