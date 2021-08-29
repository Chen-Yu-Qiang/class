
#include "Aria.h"
#include <cmath>
#include <iostream>
int realX;
int realY;
int realTh;


int main(int argc, char **argv)
{
	std::cout<<"where you want to go????\n x y theta(in rad)\n";
	float xd,yd,td;
	std::cin>>xd>>yd>>td;
	ArRobot robot;
	ArSonarDevice sonar;

	robot.addRangeDevice(&sonar);

	Aria::init();

	ArSimpleConnector connector(&argc, argv);

	if (!connector.connectRobot(&robot))
	{
		printf("Could not connect to robot... exiting\n");
		Aria::shutdown();
		Aria::exit(1);
	}

	robot.comInt(ArCommands::ENABLE, 1);
	robot.runAsync(false);

	// Used to perform actions when keyboard keys are pressed
	ArKeyHandler keyHandler;
	Aria::setKeyHandler(&keyHandler);

	// ArRobot contains an exit action for the Escape key. It also
	// stores a pointer to the keyhandler so that other parts of the program can
	// use the same keyhandler.
	robot.attachKeyHandler(&keyHandler);

	
	printf("You may press escape to exit\n");

	// TODO: control the robot

	// Start of controling

	// 1. Lock the robot
	robot.lock();

	// 2. Write your control code here,
	//    e.g. robot.setVel(150);
	robot.setVel(0);

	// 3. Unlock the robot
	robot.unlock();

	int statu=0;
	// 4. Sleep a while and let the robot move
	while (true)
	{
		int ch = keyHandler.getKey();
		int front1 = robot.getSonarRange(3);
		int front2 = robot.getSonarRange(4);
		int back1 = robot.getSonarRange(11);
		int back2 = robot.getSonarRange(12);
		int limdis = 800;
		float x=robot.getX();
		float y=robot.getY();
		float t=robot.getTh();
		if(t<0){
			t=t+360;
		}
		t=t/57.295779;
		std::cout<<x<<","<<y<<","<<t<<"\n";
		//printf("%f %f %f %d %d %d push key:%d f1:%d, f2:%d, b1:%d, b2:%d\n", robot.getX(), robot.getY(), robot.getTh(),realX,realY,realTh, ch, front1, front2, back1, back2);
		if(statu==0){
			float omg=atan2((yd-y),(xd-x));
			if(omg<0){
				omg=omg+6.28318;
			}
			omg=omg-t;

			if(abs(omg+6.28318)<=abs(omg) && abs(omg+6.28318)<=abs(omg-6.28318)){
				robot.setRotVel(10*(omg+6.28318));
			}else if(abs(omg)<=abs(omg+6.28318) && abs(omg)<=abs(omg-6.28318)){
				robot.setRotVel(10*omg);
			}else{
				robot.setRotVel(10*(omg-6.28318));
			}
			
			robot.setVel(0);
			std::cout<<"s1:"<<omg<<std::endl;
			if(omg<0.05 && omg>-0.05){
				statu=1;
			}
		}else if(statu==1){
			float v=sqrt((xd-x)*(xd-x)+(yd-y)*(yd-y));
			float omg=atan2((yd-y),(xd-x));
			if(omg<0){
				omg=omg+6.28318;
			}
			omg=omg-t;
			if(abs(omg+6.28318)<=abs(omg) && abs(omg+6.28318)<=abs(omg-6.28318)){
				robot.setRotVel((omg+6.28318));
			}else if(abs(omg)<=abs(omg+6.28318) && abs(omg)<=abs(omg-6.28318)){
				robot.setRotVel(omg);
			}else{
				robot.setRotVel((omg-6.28318));
			}

			if(omg>=-0.7853 && omg<=0.7853){
				robot.setVel(v);
			}else{
				robot.setVel(-v);
			}
			std::cout<<"s2:"<<v<<","<<omg<<std::endl;
			if(v<=5){
				statu=2;
			}
		}else if(statu==2){
			float omg=td-t;
			if(abs(omg+6.28318)<=abs(omg) && abs(omg+6.28318)<=abs(omg-6.28318)){
				robot.setRotVel(5*(omg+6.28318));
			}else if(abs(omg)<=abs(omg+6.28318) && abs(omg)<=abs(omg-6.28318)){
				robot.setRotVel(5*omg);
			}else{
				robot.setRotVel(5*(omg-6.28318));
			}

			robot.setVel(0);
			std::cout<<"s3"<<omg<<std::endl;
			if(omg<0.01 && omg>-0.01){
				robot.setRotVel(0);
				robot.setVel(0);
				statu=3;
				std::cout<<"finish!!";
			}
		}

		

		ArUtil::sleep(1);
	}

	// End of controling

	Aria::shutdown();

	Aria::exit(0);
}
