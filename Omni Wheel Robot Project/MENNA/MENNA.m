Sample_NO=1;
X=0;
Y=0;
vrep=remApi('remoteApi'); 
vrep.simxFinish(-1);   
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
[Code, ML] = vrep.simxGetObjectHandle(clientID, 'ML', vrep.simx_opmode_oneshot_wait);
[Code, MR] = vrep.simxGetObjectHandle(clientID, 'MR', vrep.simx_opmode_oneshot_wait);
[Code, RB] = vrep.simxGetObjectHandle(clientID, 'Robot', vrep.simx_opmode_oneshot_wait);
 if (clientID>-1)
vrep.simxSetJointTargetVelocity(clientID,ML,(0.5),vrep.simx_opmode_oneshot); 
vrep.simxSetJointTargetVelocity(clientID,MR,(0.45),vrep.simx_opmode_oneshot); 
 end
vrep.simxGetObjectPosition(clientID,RB,-1,vrep.simx_opmode_streaming);
vrep.simxGetObjectOrientation(clientID,RB,-1,vrep.simx_opmode_streaming);
while (Sample_NO<500)
[Code,data1]=vrep.simxGetObjectPosition(clientID,RB,-1,vrep.simx_opmode_buffer);
[Code,data2]=vrep.simxGetObjectOrientation(clientID,RB,-1,vrep.simx_opmode_buffer);
X(Sample_NO)=data1(1);
Y(Sample_NO)=data1(2);
TH(Sample_NO)=data2(3)*180/pi;
Sample_NO=Sample_NO+1;
pause(0.1);
end
plot(X,Y,'*');