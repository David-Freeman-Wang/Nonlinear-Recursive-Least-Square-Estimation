% Jacobian matrix
function H = jacob(x)
    x1 = x(1);
    x2 = x(2);
    
    H = [x2   x1;
          2*x1 -1];
end