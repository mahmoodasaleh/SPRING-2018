%% Basem Allah Allrahman Elrahim
%P-Contorller For Go-to-Goal Differential Drive Mobile Robot.
%Multi Points
%Prof.Dr\M.I.Mahmoud
%Hossam Hassan
function D=G_Drive(KP1,KI1,KD1,KP2,KI2,KD2)
dT=0.25;
E_THO=0;
E_DO=0;
INT_TH=0;
DRif_TH=0;
INT_D=0;
DRif_D=0;
[XR,YR,THR,XT,YT,THT]=FRKB(0,0);
E_D=nearest(sqrt(((XT-XR)^2)+((YT-YR)^2)));
Err_TH=THT-THR;
[XR,YR,THR,XT,YT,THT]=FRKB(0,0);
E_D=sqrt(((XT-XR)^2)+((YT-YR)^2));
Err_TH=THT-THR;
 while(abs(Err_TH)>0.1) 
      Err_TH=THT-THR;
     INT_TH=INT_TH+(Err_TH*dT);
    DRif_TH=(Err_TH-E_THO)/dT;
    W=KP1*Err_TH+KD1*DRif_TH+KI1*INT_TH;
      VL=W;
      VR=-W;
       [XR,YR,THR,XT,YT,THT]=FRKB(VL,VR);
 end
 while(abs(E_D)>10) 
     E_D=nearest(sqrt(((XT-XR)^2)+((YT-YR)^2)))
     INT_D=INT_D+(E_D*dT);
    DRif_D=(E_D-E_DO)/dT;
    V=KP2*E_D+KD2*DRif_D+KI2*INT_D;
    VL=-2*V;
    VR=-2*V;
    [XR,YR,THR,XT,YT,THT]=FRKB(VL,VR);
    D='Go';
 end
 [XR,YR,THR,XT,YT,THT]=FRKB(0,0);
D='Done';
end