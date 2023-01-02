function [Gbest, best, plotting_vector]=Modified_Bat_algorithm(fn_name, fmin, fmax, MaxItr, population_size...
  , Gama, Alpha, UB, LB, d, prop_limit = 0.3)
  clc;
  pkg load statistics;
  fn = getfunction(fn_name);
  A = ones(1, population_size);
  % Initial velocities for each bat
  v = zeros(population_size, d);
  % Intial emession rate for each bat
  r = rand(population_size);
  % Bat Algorithm
  % Initial population
  r0 = 0.3;
  % vector(minimum, maximum, dimension, rows)
  population = vector(LB, UB, d, population_size);
  % Calculate fitness
  k = 0;
  
  %sol_eval = zeros(MaxItr, population_size);
  for i=1:population_size
    fitness(i) = fn(population(i,:));
  end
  [best, index] = min(fitness);
  Gbest = population(index,:);
  for i=1:MaxItr
    for j=1:population_size
      % Generate Frequency
      pop_seq = 1:population_size;
      randidx = randsample(pop_seq(pop_seq != j),1);
      f = fmin + rand * (fmax - fmin);
      % Change position using velocity
      % نسبة بين أفضل قيمة وجدت و قيمة الحل الحالي
      prop = best/fitness(j);
      % هل النسبة أقل من النسبة المقدرة و التي وضعت من ضمن مدخلات الخوارزمية
      if prop <= prop_limit
        % التحويل لنسبة كبيرة عن طريق الطرح من واحد
        fitness_frac = 1 - prop;
        % توليد رقم عشوائي ما بين النسبة المحسوبة في الخطوة السابقة و بين رقم واحد
        rn = fitness_frac + rand * (1 - fitness_frac);
        % يتم ضرب الرقم العشوائي في المسافة بين الحل الأفضل و الحل الحالي
        v(j,:) = rn * (Gbest - population(j,:)) + rn * (Gbest - population(randidx,:));
        % يتم توليد حل بإستخدام السرعة المولد في الخطوة السابقة عن طريق جمع السرعة مع الحل الحالي
        modified = population(j,:) + v(j,:);
        % في حالة أن النسبة كانت أعلى من النسبة المقدرة
      else
        % توليد رقم عشوائي بدايته النسبة المولدة في السطر رقم ٣٢ و أعلى قيمة النسبة المقدرة
        rn = prop + rand * (prop_limit - prop);
        % نفس التعليق في السطر رقم ٣٧
        v(j,:) = rn * (Gbest - population(j,:)) + rn * (Gbest - population(randidx,:));
        % نفس الخطوة رقم ٣٩
        modified = population(j,:) + v(j,:);
      endif
      clc;
      % Local search
      % Information_vector
      modified = fixbounds(modified, UB, LB);
      Information_vector = zeros(1,d);
      for k = 1:d
        if rand >= r(j)
          Information_vector(k) = modified(k);
        else
##          Information_vector(k) = population(j,k);
          Information_vector(k) = Gbest(k);
        endif 
      endfor
           
      bateval = fn(Information_vector);
      % Update emession rate, loudness, and position
      if A(j) >= rand || bateval <= fitness(j)
        population(j,:) = Information_vector;
        fitness(j) = bateval;
        r(j) = r0 * (1 - exp(-Gama * i));        
        A(j) = Alpha * A(j);
      endif
      
      if bateval <= best
        Gbest = Information_vector;
        best = bateval;
      end      
        
    endfor
      %k = k + 1;
      %disp(Gbest);
##      plotting_vector(i) = best;    
  endfor
##  plot(plotting_vector);
