
#include "Aria.h"
#include <cmath>
#include <iostream>
int realX;
int realY;
int realTh;


int main(int argc, char **argv)
{

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
	robot.runAsync(true);

	// Used to perform actions when keyboard keys are pressed
	ArKeyHandler keyHandler;
	Aria::setKeyHandler(&keyHandler);

	// ArRobot contains an exit action for the Escape key. It also
	// stores a pointer to the keyhandler so that other parts of the program can
	// use the same keyhandler.
	robot.attachKeyHandler(&keyHandler);

	//robot.addPacketHandler(new ArGlobalRetFunctor1<bool, ArRobotPacket*>(&handleSimStatPacket));
	
	printf("You may press escape to exit\n");
	ArActionGoto gotoPoseAction("goto");
	gotoPoseAction.setGoal(ArPose(12000, 12000));
	ArActionLimiterForwards limiterAction("speed limiter near", 300, 600, 250);
  	ArActionAvoidFront myActionAvoidFront("Avoid Front Near", 300, 1);
	ArActionAvoidSide myActionAvoidSide("Avoid side", 300, 1);
	robot.addAction(&gotoPoseAction, 89);
	//robot.addAction(&limiterAction, 95);
	robot.addAction(&myActionAvoidSide, 40);
	robot.addAction(&myActionAvoidFront, 90);
	robot.enableMotors();
	// TODO: control the robot

	// Start of controling

	// 1. Lock the robot
	robot.lock();

	// 2. Write your control code here,
	//    e.g. robot.setVel(150);


	// 3. Unlock the robot
	robot.unlock();


	// 4. Sleep a while and let the robot move
	while (Aria::getRunning())
	{
		//robot.comInt(ArCommands::SIM_STAT, 1);

		float x=robot.getX();
		float y=robot.getY();
		float t=robot.getTh();
		if(t<0){
			t=t+360;
		}
		t=t/57.295779;
		std::cout<<x<<","<<y<<","<<t<<"\n";
		

		

		ArUtil::sleep(100);
	}

	// End of controling

	Aria::shutdown();

	Aria::exit(0);
}
