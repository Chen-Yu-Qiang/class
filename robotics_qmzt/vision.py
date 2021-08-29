# -*- coding: utf-8 -*-
"""
Created on Wed Jun  3 10:28:07 2020

@author: joe19
"""

# pose estimation
# https://medium.com/@dc.aihub/3d-reconstruction-with-stereo-images-part-2-pose-estimation-1bcfbba61b26
# https://docs.opencv.org/master/d9/db7/tutorial_py_table_of_contents_calib3d.html


import numpy as np
import math
import cv2
import csv
import time
import threading
import serial

flag1 = True
flag2 = False

# build communication serial of arduino (down-right socket)
ser = serial.Serial('/dev/ttyUSB0',57600,timeout = 0.1)


CHECKERBOARD = (9, 6)

# Load previously saved data

#with np.load('B.npz') as X:
#    mtx, dist, _, _ = [X[i] for i in ('mtx','dist','rvecs','tvecs')]


marker1_transform = np.array([[1,0,0,0], [0,1,0,0], [0,0,1,0], [0,0,0,1]])

mtx = [[659.32600587, 0., 331.77320354],
 [0., 655.74441046, 268.98896041],
 [0., 0., 1., ]]

dist = [[0.0921015, -0.33639816, 0.01776708, 0.00568066, 1.08561026]]


rotation_mtx = np.array(mtx, dtype="float32")
dist = np.array(dist, dtype="float32")
bottom = np.array([[0,0,0,1]])
transform_mtx = np.concatenate((rotation_mtx, dist), axis = 1)
transform_mtx = np.concatenate((transform_mtx, bottom), axis = 0) 


criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 30, 0.001)
objp = np.zeros((9*6,3), np.float32)
objp[:,:2] = np.mgrid[0:9,0:6].T.reshape(-1,2)

axis = np.float32([[3,0,0], [0,3,0], [0,0,-3]]).reshape(-1,3)

def draw(img, corners, imgpts):
    corner = tuple(corners[0].ravel())
    img = cv2.line(img, corner, tuple(imgpts[0].ravel()), (255,0,0), 5)
    img = cv2.line(img, corner, tuple(imgpts[1].ravel()), (0,255,0), 5)
    img = cv2.line(img, corner, tuple(imgpts[2].ravel()), (0,0,255), 5)
    return img

def Capturing():
    #count = 0
    global transform_mtx
    global flag1
    global flag2
    # Open the device at the ID 0
    cap = cv2.VideoCapture(0)
    
    #Check whether user selected camera is opened successfully.
    if not (cap.isOpened()):
    	print("Could not open video device”")
    
    print('Capture Starting')
    
    #To set the resolution
    #Decrease frame size
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 600)
    #cap.set(cv2.cv.CV_CAP_PROP_FRAME_WIDTH, 640)
    
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
    
    
    while(True):
    	#for fname in glob.glob('./chessboard/c*.jpg'):
    	# Capture frame-by-frame
    
    	ret, frame = cap.read()
    	gray = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
    
    	#img = cv2.imread(fname)
    	#gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    	ret, corners = cv2.findChessboardCorners(gray, CHECKERBOARD,None)
        
    	if ret == True:
            flag2 = True
    		corners2 = cv2.cornerSubPix(gray, corners,(11,11),(-1,-1),criteria)
    
    		# Find the rotation and translation vectors.
    		_, rvecs, tvecs, inliers = cv2.solvePnPRansac(objp, corners2, mtx, dist)
            rotation_mtx, Jacob = cv2.Rodrigues(rvecs)
            """
    		# project 3D points to image plane
    		imgpts, jac = cv2.projectPoints(axis, rvecs, tvecs, mtx, dist)
    
    		img = draw(frame, corners2, imgpts)
    		#cv2.imshow('img',img)
    		count = count + 1
    		filePath = "./test_image/i" + str(count) + ".png"
    		cv2.imwrite(filePath, img)
    		
    		k = cv2.waitKey(0) & 0xff
    		if k == 's':
    		    cv2.imwrite(fname[:6]+'.png', img)
    		
    		break
    		"""
            bottom = np.array([[0,0,0,1]])
    		transform_mtx = np.concatenate((rotation_mtx, tvecs), axis = 1)
    		transform_mtx = np.concatenate((transform_mtx, bottom), axis = 0)
            print(transform_mtx)
    		time.sleep(0.1)
		if (flag):
			break
    cv2.destroyAllWindows()
    

cap = threading.Thread(target = Capturing)

with open('output.csv', 'w', newline='') as f
    writer = csv.writer(f,delimiter = ' ')
    fieldnames = ['c_pos_x','c_pos_y','c_pos_z','c_yaw','e_pos_x','e_pos_y','e_pos_z','e_yaw']
    writer = csv.DictWriter(f,fieldnames =fieldnames)
    writer.writeheader()
    cap.start()
    try:
        while True:
            if flag2:
                # total transform matrix from world to marker to camera (world -> camera)
                total_trans = transform_mtx * marker1_transform
                
                # get inversed transform matrix  (camera -> world)
                rotation_mtx = total_trans[0:3,0:3]
                transition_mtx = total_trans[0:3,3]
                inverse_trans = np.concatenate((rotation_mtx.transpose(), -rotation_mtx*transition_mtx), axis = 1)
                inverse_trans = np.concatenate((inverse_trans, bottom), axis = 0) 
                
                # output camera's world coordinate
                camera_pose = inverse_trans[0:3,3]
                camera_pose = camera_pose.tolist()
                c_yaw = 180/pi*math.atan2(inverse_trans[1,0], inverse_trans[0,0])
                
                writer.writerow({'c_pos_x':camera_pose[0],'c_pos_y':camera_pose[1],'c_pos_z':camera_pose[2], 'c_yaw':c_yaw})
                
                # send camera position to arduino
                ser.write(str(camera_pose[0]).encode())
                ser.write(str(camera_pose[1]).encode())
                ser.write(str(camera_pose[2]).encode())
                ser.write(str(c_yaw).encode())
                
                # turn off flag2
                flag2 = False
            
            # get encoder's world coordinate
            e_pose = ser.readline().decode().split()
            
            # output encoder's world coordinate
            writer.writerow({'e_pos_x':e_pose[0],'e_pos_y':e_pose[1],'e_pos_z':e_pose[2], 'e_yaw':e_pose[3]})
    # type ctrl + C to stop the program
    except KeyboardInterrupt:
        pass
    
    flag1 = False
    cap.join()


