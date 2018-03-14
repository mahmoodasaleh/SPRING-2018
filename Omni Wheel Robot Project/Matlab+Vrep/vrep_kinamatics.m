
clc
%% Simulation of Kinimatics of omniwheel Drive mobile robot
%Robotics and visoin Course OPT08
x_init = 0; %[m]
y_init = 0; %[m]
r=0.5; % Wheel radius m
a=0.54;% distance between wheel and CG m
W1=-1;% wheel 1 angular velociy
W2=1;% wheel 2 angular velociy
W3=0;% wheel 3 angular velociy

TH_init=180; %[degree]
v_1 = r*W1; %[m/s]
v_2 = r*W2; %[m/s]
v_3 = r*W3; %[m/s]

timestep = 0.5; %[s]
% Intial Values
sample_no = 1;
x_robot(sample_no) = x_init;
y_robot(sample_no) = y_init;
TH_robot(sample_no) = TH_init;
timestamps(sample_no) = 0;
while (sample_no) < 1000
%increase timestep
sample_no = sample_no + 1;
% calculate Linear and angular velocities .

v_x=(cos(TH_robot(sample_no))*((2*v_2-v_1-v_3)/3))-(sin(TH_robot(sample_no))*((sqrt(3)*v_3)-((sqrt(3)*v_1))));
v_y=(sin(TH_robot(sample_no))*((2*v_2-v_1-v_3)/3))-(cos(TH_robot(sample_no))*((sqrt(3)*v_3)-((sqrt(3)*v_1))));
v_phi= ((v_1/a)+(v_2/a)+(v_3/a));
% v_x=(v_3-(v_1*cos(60))- (v_2*cos(60)));
% v_y=((v_1*sin(60))- (v_2*sin(60)));
% v_phi= ((v_1/a)+(v_2/a)+(v_3/a));

x_robot(sample_no) = x_robot(sample_no - 1) +  v_x * timestep;
y_robot(sample_no) = y_robot(sample_no - 1) + v_y * timestep;
TH_robot(sample_no) = TH_robot(sample_no-1) + v_phi * timestep;

%store timestep
timestamps(sample_no) = timestamps(sample_no - 1) + timestep;
end

%vrep simulation
Sample_NO=1;
X=0;
Y=0;
vrep=remApi('remoteApi'); 
vrep.simxFinish(-1);   
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
[Code, M1] = vrep.simxGetObjectHandle(clientID, 'M1', vrep.simx_opmode_oneshot_wait);
[Code, M2] = vrep.simxGetObjectHandle(clientID, 'M2', vrep.simx_opmode_oneshot_wait);
[Code, M3] = vrep.simxGetObjectHandle(clientID, 'M3', vrep.simx_opmode_oneshot_wait);
[Code, RB] = vrep.simxGetObjectHandle(clientID, 'RB', vrep.simx_opmode_oneshot_wait);
 if (clientID>-1)
vrep.simxSetJointTargetVelocity(clientID,M1,(1),vrep.simx_opmode_oneshot); 
vrep.simxSetJointTargetVelocity(clientID,M2,(-1),vrep.simx_opmode_oneshot); 
vrep.simxSetJointTargetVelocity(clientID,M3,(0),vrep.simx_opmode_oneshot);
 end
vrep.simxGetObjectPosition(clientID,RB,-1,vrep.simx_opmode_streaming);
vrep.simxGetObjectOrientation(clientID,RB,-1,vrep.simx_opmode_streaming);
while (Sample_NO<1000)
[Code,data1]=vrep.simxGetObjectPosition(clientID,RB,-1,vrep.simx_opmode_buffer);
[Code,data2]=vrep.simxGetObjectOrientation(clientID,RB,-1,vrep.simx_opmode_buffer);
X(Sample_NO)=data1(1);
Y(Sample_NO)=data1(2);
TH(Sample_NO)=data2(3)*180/pi;
Sample_NO=Sample_NO+1;
pause(0.1);
end
plot(X,Y,'*',x_robot,y_robot,'b-');
legend ('V_rep','kinamatics');



