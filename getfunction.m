function [func]=getfunction(function_name)
  switch function_name
    case "Rastrigin"
      func = @Rastrigin;
    case "Ackley"
      func = @Ackley;
    case "Sphere"
      func = @Sphere;
    case "Rosenbrock"
      func = @Rosenbrock;
    case "Bukin"      func = @Bukin;
    case "CrossInTray"
      func = @CrossInTray;
    case "Bohachevsky"
      func = @Bohachevsky
    case "Perm"
      func = @Perm;
    case "Booth"
      func = @Booth;
    case "Matyas"
      func = @Matyas;
    case "McCormick"
      func = @McCormick;
  endswitch
end

function [output]=Rastrigin(x)
  d = length(x);
  output = 10 * d;
  for i = 1:d
    output = output + (x(i)^2 - 10*cosd(2*pi*x(i)));
  end
 end
 
function [output]=Ackley(x)
  output = -20 * exp(-0.2*sqrt(0.5 * (x(1)^2 + x(2)^2))) - exp(0.5 * (cos(2 * pi * x(1))...
  + cos(2 * pi * x(2)))) + exp(1) + 20;
 end
 
 function [output]=Sphere(x)
   output = sum(x.^2);
 end

 function [output]=Rosenbrock(x)
   n = length(x);
   output = 0;
   for i=1:n-1
     output = 100 * (x(i+1) - x(i)^2)^2 + (1-x(i))^2;
   endfor
 end
 
 function [degree_angle]=cosd(angle)
   degree_angle = angle * pi /180;
 endfunction
 
 function [output]=Bukin(x)
  term1 = 100 * sqrt(abs(x(2) - 0.01*x(1)^2));
  term2 = 0.01 * abs(x(1)+10);
  output = term1 + term2;
 endfunction
 
 function [output]=CrossInTray(x)
   output = -0.0001 * (abs(sin(x(1)) * sin(x(2)) * exp(abs(100 - sqrt(x(1)^2 + x(2)^2)/pi))) + 1)^0.1; 
 endfunction
 
 function [output]=Bohachevsky(x)
   output = x(1)^2 + 2 * x(2)^2 - 0.3 * cos(3 * pi * x(1)) - 0.4 * cos(4 * pi * x(2)) + 0.7;
 endfunction
 
 function [output]=Perm(x)
   d = length(x);
   output = 0;
   for i = 1:d
     tempSum = 0;
     for j = 1:d
       tempSum = tempSum + ((j + 10) * (x(j)^i - 1/j^i))^2;
     endfor
     output = output + tempSum;
   endfor
 endfunction
 
 function [output] =Booth(x)
   output = (x(1) + 2 * x(2) - 7)^2 + (2 * x(1) + x(2) - 5)^2;
 endfunction
 
 function [output]=Matyas(x)
   output = 0.25 * (x(1)^2 + x(2)^2) - 0.48 * x(1) * x(2);
 endfunction
 
 function [output]=McCormick(x)
   output = sin(x(1) + x(2)) + (x(1) - x(2))^2 - 1.5 * x(1) + 2.5 * x(2) + 1;
 endfunction
 
 
 