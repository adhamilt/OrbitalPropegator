function ImportAtm()
M=importfile('Atmosphere.csv');

global Alt
global ScaleHeight
global MeanRho
global MaxRho

Alt=M(:,1);
ScaleHeight=M(:,2);
MeanRho=M(:,3);
MaxRho=M(:,4);

clearvars('M');

end