%% Example for nonlinear least squation estimation
clc;
clear;
close all;

%%  Set up initial conditons
rng(2020) % for repeatable results

x0 = [4;2];
x0Bar = [10;10];
P0 = diag([20 20]);
R = diag([0.1 0.1]);

numMeasure = 5;

tolerance = 1e-5; % Iteration tolerance


%% Generate five measurements and set up variables
yFull = NaN(2*numMeasure,1); % pre-allocate a 5*2-by-1 space to save the measurement vectors

for i =1:1:numMeasure
    yFull(2*i-1:2*i) = measure(x0,R);   
end

RFull = diag(repmat(diag(R),5,1));

xSave = x0Bar; % Save all the estimate history

xHat = x0Bar;
P = P0;

d = 10* tolerance;% save the distance beteween consecutive estimates

maxNumIter = 1000;
counter = 0;

%% Iteration 
while d > tolerance
    H = jacob(xHat); % jacobian for one measurement
    HFull = repmat(H,numMeasure,1); % jacobian for five measurements
    
    hHat = measure(xHat); % one reference measurement
    hHatFull = repmat(hHat,numMeasure,1); % five referenc emeasurements
    
    xHatNew = xHat + inv(HFull' * inv(RFull)  * HFull +  inv(P)) * HFull' / RFull * (yFull - hHatFull);
    
    HNew = jacob(xHatNew);
    HFullNew = repmat(HNew,numMeasure,1);
    P = inv(HFullNew' * inv(RFull) * HFullNew + inv(P));
    
    d = norm(xHatNew - xHat);
    
    xHat = xHatNew;
    
    xSave = [xSave xHat]; % <#okag>  
    
    counter = counter + 1;
    if counter == maxNumIter
        disp('Iteration limit reached! Guess better or be less demanding!')
        break;
    end
    
end


%% Visualization
figure()
plot(xSave(1,:),xSave(2,:),'d','DisplayName','Estimates')

hold on;

plot(x0Bar(1),x0Bar(2),'g*','DisplayName','Initial guess')
plot(x0(1),x0(2),'ro','DisplayName','Truth')
xlim([2 11]);ylim([1 11])
axis square
legend("Location","NorthWest")
xlabel('x1')
ylabel('x2')
title('Nonlinear LSE example')

xHat 
error = norm(xHat-x0)




























