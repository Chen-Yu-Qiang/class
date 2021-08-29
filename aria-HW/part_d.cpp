
#include "Aria.h"

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

	// 4. Sleep a while and let the robot move
	while (true)
	{
		int ch = keyHandler.getKey();

		int front1 = robot.getSonarRange(3);
		int front2 = robot.getSonarRange(4);
		int back1 = robot.getSonarRange(11);
		int back2 = robot.getSonarRange(12);
		int limdis=800;
		printf("%f %f %f push key:%d f1:%d, f2:%d, b1:%d, b2:%d\n", robot.getX(), robot.getY(), robot.getTh(), ch, front1, front2, back1, back2);

		if (ch == 256)
		{
			if(front1<limdis||front2<limdis){
				robot.setVel(50);
				robot.setRotVel(0);

			}else{
				robot.setVel(150);
				robot.setRotVel(0);
			}
			
		}
		else if (ch == 257)
		{
			if(back1<limdis||back2<limdis){
				robot.setVel(-50);
				robot.setRotVel(0);

			}else{
				robot.setVel(-150);
				robot.setRotVel(0);
			}
		}
		else if (ch == 258)
		{
			robot.setVel(0);
			robot.setRotVel(50);
		}
		else if (ch == 259)
		{
			robot.setVel(0);
			robot.setRotVel(-50);
		}
		else
		{
			robot.setVel(0);
			robot.setRotVel(0);
		}

		ArUtil::sleep(100);
	}

	// End of controling

	Aria::shutdown();

	Aria::exit(0);
}
