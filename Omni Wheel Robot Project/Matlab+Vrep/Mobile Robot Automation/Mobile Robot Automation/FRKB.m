function [XRB,YRB,THRB,XTRG,YTRG,THTRG]=FRKB(VR,VL)
vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
	vrep.simxFinish(-1); % just in case, close all opened connections
	clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
    Motors = [-1 -1]; % left, right
    [res, Joint(1)] = vrep.simxGetObjectHandle(clientID, 'ML', vrep.simx_opmode_oneshot_wait);
    [res, Joint(2)] = vrep.simxGetObjectHandle(clientID, 'MR', vrep.simx_opmode_oneshot_wait);
    [res, Base] = vrep.simxGetObjectHandle(clientID, 'RB', vrep.simx_opmode_oneshot_wait);
    [res, Head] = vrep.simxGetObjectHandle(clientID, 'HD', vrep.simx_opmode_oneshot_wait);
    [res, TRG] = vrep.simxGetObjectHandle(clientID, 'TR', vrep.simx_opmode_oneshot_wait);
    %[res, TRG(2)] = vrep.simxGetObjectHandle(clientID, 'TR0', vrep.simx_opmode_oneshot_wait);
    %[res, TRG(3)] = vrep.simxGetObjectHandle(clientID, 'TR1', vrep.simx_opmode_oneshot_wait);
    %[res, TRG(4)] = vrep.simxGetObjectHandle(clientID, 'TR2', vrep.simx_opmode_oneshot_wait);
  
    if (clientID>-1)
         vrep.simxSetJointTargetVelocity(clientID,Joint(1),(VL),vrep.simx_opmode_oneshot); 
         vrep.simxSetJointTargetVelocity(clientID,Joint(2),(VR),vrep.simx_opmode_oneshot);   
   end
 t=clock;
        startTime=t(6);
        currentTime=t(6);
        vrep.simxGetObjectPosition(clientID,Base,-1,vrep.simx_opmode_streaming);
        vrep.simxGetObjectOrientation(clientID,Base,-1,vrep.simx_opmode_streaming);
         vrep.simxGetObjectPosition(clientID,TRG,-1,vrep.simx_opmode_streaming);
        while (currentTime-startTime < 0.5)   
          [returnCode,data1]=vrep.simxGetObjectPosition(clientID,Base,-1,vrep.simx_opmode_buffer);
          [returnCode,data2]=vrep.simxGetObjectOrientation(clientID,Base,-1,vrep.simx_opmode_buffer);
          [returnCode,data3]=vrep.simxGetObjectPosition(clientID,TRG,-1,vrep.simx_opmode_buffer);
            % Try to retrieve the streamed data
            if (returnCode==vrep.simx_return_ok) % After initialization of streaming, it will take a few ms before the first value arrives, so check the return code
             PRB= (data1)*100;% cm
             XRB=(PRB(1));
             YRB=(PRB(2));
             THRB=(data2(3)*180/pi);
             if THRB<0
              THRB=THRB+360;% degree
             end
              PTRG= (data3)*100;% cm
             XTRG=(PTRG(1));
             YTRG=(PTRG(2));
            THTRG=nearest((atan2(YTRG-YRB,XTRG-XRB))*180/pi)+180;
            end
            t=clock;
            currentTime=t(6);
        end 
end