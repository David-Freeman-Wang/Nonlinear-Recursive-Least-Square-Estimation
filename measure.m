%% Measure function
function y = measure(x,varargin)
       x1 = x(1);
    x2 = x(2);
    if nargin == 1
         y = [x1*x2; x1^2-x2];
    end
    if nargin == 2
        R = varargin{1};
        y = [x1*x2; x1^2-x2] + mvnrnd(zeros(2,1),R)';
    end
     
   

end