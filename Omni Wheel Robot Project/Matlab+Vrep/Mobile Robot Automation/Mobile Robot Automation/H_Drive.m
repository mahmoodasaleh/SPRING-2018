%% Basem Allah Allrahman Elrahim
%P-Contorller For Go-to-Goal Differential Drive Mobile Robot.
%Multi Points
%Prof.Dr\M.I.Mahmoud
%Hossam Hassan
function D =H_Drive(KP1,KI1,KD1,KP2,KI2,KD2)
t=0;
i=0;
dT=0.1;
E_THO=0;
E_DO=0;
INT_TH=0;
DRif_TH=0;
INT_D=0;
DRif_D=0;
[XR,YR,THR,XT,YT,THT,F_D,L_D,R_D]=FRKH(0,0);
E_D=nearest(sqrt(((XT-XR)^2)+((YT-YR)^2)));
Err_TH=THT-THR;
[XR,YR,THR,XT,YT,THT,F_D,L_D,R_D]=FRKH(0,0);
E_D=sqrt(((XT-XR)^2)+((YT-YR)^2));
Err_TH=THT-THR;
fismat = readfis('moyo_sugeno_flcR2.fis');
while(abs(E_D)>5) 
      Err_TH=THT-THR;
      E_D=nearest(sqrt(((XT-XR)^2)+((YT-YR)^2)))
     INT_TH=INT_TH+(Err_TH*dT);
    DRif_TH=(Err_TH-E_THO)/dT;
    W=KP1*Err_TH+KD1*DRif_TH+KI1*INT_TH;
     INT_D=INT_D+(E_D*dT);
    DRif_D=(E_D-E_DO)/dT;
    V=KP2*E_D+KD2*DRif_D+KI2*INT_D;
  S = evalfis([F_D, L_D, F_D],fismat); 
    VR=-4*S(1);
    %((-V-W)/2)-(0.15/(L_D));
    VL=-4*S(2);
    %((-V+W)/2)+(0.15/(R_D));
   [XR,YR,THR,XT,YT,THT,F_D,L_D,R_D]=FRKH(VL,VR);
    D='Go';
end
  [XR,YR,THR,XT,YT,THT,F_D,L_D,R_D]=FRKH(0,0);
 D='Done';
end