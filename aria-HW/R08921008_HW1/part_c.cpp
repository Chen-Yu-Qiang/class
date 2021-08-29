#include "Aria.h"

//----------------------------------------------------------------------
//    Class Declaration
//----------------------------------------------------------------------
class MotionHandler {
public:
   MotionHandler(ArRobot* r = 0, double v = 0, double rotV = 0, double absMaxV = 0, double absMaxRotV = 0)
      : _robot(r), _vel(v), _rotVel(rotV), _absMaxVel(absMaxV), _absMaxRotVel(absMaxRotV) {}
   ~MotionHandler() {}

   // Basic access methods
   double getVel()            { return _vel;          }
   double getRotVel()         { return _rotVel;       }
   double getAbsMaxVel()      { return _absMaxVel;    }
   double getAbsMaxRotVel()   { return _absMaxRotVel; }

   // Basic setting methods
   void setVel(double v)                     { _vel = v;                   }
   void setRotVel(double rotV)               { _rotVel = rotV;             }
   void setAbsMaxVel(double absMaxV)         { _absMaxVel = absMaxV;       }
   void setAbsMaxRotVel(double absMaxRotV)   { _absMaxRotVel = absMaxRotV; }

   // Information message
   void robotMsg() { printf("%f\t%f\t%f\t%f\t%f\n", _robot->getVel(), _robot->getRotVel()
                                                 , _robot->getX(), _robot->getY(), _robot->getTh()); }
   void sonarMsg() { printf("%d\t%d\n", _robot->getClosestSonarRange(0, -1), _robot->getClosestSonarNumber(0, -1)); }

   // Dealing with keyboard input
   void forward();
   void backward();
   void leftward();
   void rightward();
   
   // Collision Avoidance
   void sonarInfoUpdate();
   bool autoSlowForward();
   bool autoSlowBackward();

   // Reset functions
   void resetRotVel();

private:
   ArRobot* _robot;
   double   _vel;
   double   _rotVel;
   double   _absMaxVel;
   double   _absMaxRotVel;
   int      _closestDis;
   int      _closestSonarNum;
};

//----------------------------------------------------------------------
//    Main Body
//----------------------------------------------------------------------
int main(int argc, char** argv) {
   // Initialization
   Aria::init();

   // This object parses program options from the command line
   ArArgumentParser parser(&argc, argv);

   // Load some default values for command line arguments from /etc/Aria.args
   // (Linux) or the ARIAARGS environment variable.
   parser.loadDefaultArguments();

   ArRobot robot;

   //Object that handles all motions
   MotionHandler motionHandler(&robot);

   // Object that connects to the robot or simulator using program options
   ArRobotConnector robotConnector(&parser, &robot);

   if (!robotConnector.connectRobot(&robot)) {
		printf("Could not connect to robot... exiting\n");
		Aria::shutdown();
		Aria::exit(1);
	}

   ArSonarDevice sonar;
   // Add the sonar to the robot
   robot.addRangeDevice(&sonar);

   // set the robots maximum velocity (sonar don't work at all well if you're
   // going faster)
   motionHandler.setAbsMaxVel(360);
   motionHandler.setAbsMaxRotVel(50);
   ArUtil::sleep(300);

   // Lock the robot
   robot.lock();
   // Turn on the motors
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

   // Unlock the robot
   robot.unlock();
   
   // Start to do control
   int key = 0;
   while(true) {
      key = keyHandler.getKey();
      // Update closest distance
      motionHandler.sonarInfoUpdate();
      // If no input from keyboard
      if(key == -1) {
         if(motionHandler.getVel() > 0)
            motionHandler.autoSlowForward();
         else
            motionHandler.autoSlowBackward();
         motionHandler.resetRotVel();
         motionHandler.robotMsg();
         continue;
      }
      else if(key == ArKeyHandler::ESCAPE)
         break;
      // Based on the input, do the corresponding action
      switch (key)
      {
      case ArKeyHandler::UP:
         motionHandler.forward();
         break;
      case ArKeyHandler::DOWN:
         motionHandler.backward();
         break;
      case ArKeyHandler::LEFT:
         motionHandler.leftward();
         break;
      case ArKeyHandler::RIGHT:
         motionHandler.rightward();
         break;
      default:
         break;
      }
   }

   // End of controling

   Aria::shutdown();
   Aria::exit(0);

   return 0;
}


//----------------------------------------------------------------------
//    Class member functions for Dealing with Keyboard Input
//----------------------------------------------------------------------
void
MotionHandler::forward()
{
   if(autoSlowForward());
   else {
      _vel += 30;
      if(abs(_vel) >= _absMaxVel) _vel = _absMaxVel;
      _robot->setVel(_vel);
      ArUtil::sleep(100);
   }
   robotMsg();
}

void
MotionHandler::backward()
{
   if(autoSlowBackward());
   else {
      _vel -= 30;
      if(abs(_vel) >= _absMaxVel) _vel = -1 * _absMaxVel;
      _robot->setVel(_vel);
      ArUtil::sleep(100);
   }
   robotMsg();
}

void
MotionHandler::leftward()
{
   _rotVel += 10;
   if(abs(_rotVel) >= _absMaxRotVel) _rotVel = _absMaxRotVel;
   _robot->setRotVel(_rotVel);
   ArUtil::sleep(100);
   robotMsg();
}

void
MotionHandler::rightward()
{
   _rotVel -= 10;
   if(abs(_rotVel) >= _absMaxRotVel) _rotVel = -1 * _absMaxRotVel;
   _robot->setRotVel(_rotVel);
   ArUtil::sleep(100);
   robotMsg();
}

//----------------------------------------------------------------------
//    Class member functions for Collision Avoidance
//----------------------------------------------------------------------
void
MotionHandler::sonarInfoUpdate()
{
   _closestDis = _robot->getClosestSonarRange(0, -1);
   _closestSonarNum =  _robot->getClosestSonarNumber(0, -1);
}

bool
MotionHandler::autoSlowForward()
{
   if(_closestDis <= 750)
      if(_closestSonarNum >= 1 && _closestSonarNum <= 6) {
         if(_vel > 0) {
            _vel *= 0.95;
            _robot->setVel(_vel);
            ArUtil::sleep(100);
            return true;
         }
      }
   return false;
}

bool
MotionHandler::autoSlowBackward()
{
   if(_closestDis <= 750)
      if(_closestSonarNum >= 9 && _closestSonarNum <= 14) {   
         if(_vel < 0) {
            _vel *= 0.95;
            _robot->setVel(_vel);
            ArUtil::sleep(100);
            return true;
         }
      }
   return false;
}

//----------------------------------------------------------------------
//    Class member functions to Reset Rotation Velocity
//----------------------------------------------------------------------
void
MotionHandler::resetRotVel()
{
   if(_rotVel == 0) return;
   _rotVel = 0;
   _robot->setRotVel(_rotVel);
   ArUtil::sleep(100);
}