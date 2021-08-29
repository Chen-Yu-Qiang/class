import serial
#ser = serial.Serial('/dev/ttyUSB0',57600,timeout = 0.1)


def send2mega(m1,m2,m3):
    global ser
    s="%03d,%03d,%03d"%(m1,m2,m3)
    print(s.encode(),s)
    #ser.write(s.encode())
    #e_pose = ser.readline().decode().split()



send2mega(1,23,456)