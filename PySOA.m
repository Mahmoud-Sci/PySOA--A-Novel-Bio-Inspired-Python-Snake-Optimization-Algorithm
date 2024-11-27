
function [best_pos, Python_Score, PySOA_curve] = PySOA(SearchAgents_no, maxIter, max_distance, lb, ub, dim, fobj)
    % Initialize parameters
    best_pos = zeros(1, dim);
    Python_Score = inf;
    Python_pos = initialization(SearchAgents_no, dim, ub, lb);
    PySOA_curve = zeros(1, maxIter);
    t = 0; % Loop counter
    
    % Main loop
    while t < maxIter
        Temp = 1 - t / maxIter;  % Eq.(3) Ambient temperature variable descreace from 1 to 0
        
        for i = 1:SearchAgents_no
            % Apply boundary conditions only if agent is outside bounds
            Python_pos(i, :) = max(min(Python_pos(i, :), ub), lb);
            
            % Calculate fitness and update the best position if improved
            fitness = fobj(Python_pos(i, :));
            if fitness < Python_Score
                Python_Score = fitness;
                best_pos = Python_pos(i, :);
            end
            
            % Calculate distance
            D(i, :) = abs(best_pos - Python_pos(i, :));
        end
        
        % Update each agent's position based on exploration or exploitation
        for i = 1:SearchAgents_no
            hum = rand;
            k=rand;
            light=rand;
            Air_poll = rand;
            for j = 1:dim
                hidden = randi([0, 1]); % Hidden is binary
                rwo = (Temp) / (D(i, j) + exp((hum + Air_poll))); % Eq.(2) Density of phormones
                %Eq.(4)
                if D(i, j) <= max_distance
                    S = k * (light / cos(D(i, j))); %Sight increases as Python approaches prey
                else
                    S = 0;
                end
                
                IR = Infrared_Radiation(light, Temp);
                
                if hidden == 0 % Prey doesn't detect Python
                    if abs(rwo) < 0.5 % Exploration Phase(Searching phase)
                        r=rand;
                        %Moving Forward or backward the prey
                        if r < 0.5
                            Python_pos(i, j) = best_pos(j) + r * Python_pos(i, j); 
                        else
                            Python_pos(i, j) = best_pos(j) - r * Python_pos(i, j);
                        end
                    else % Exploitation Phase(Attacking Phase)
                        Python_pos(i, j) = best_pos(j) - rwo * log10(IR) * S * Python_pos(i, j);
                    end
                else % Prey detects Python (Hidden=1)
                    rand_index = randi([1, SearchAgents_no]);
                    Python_pos(i, j) = best_pos(j) - rwo * log10(IR) * S * Python_pos(rand_index, j);
                end
            end
        end
        
        % Update iteration counter and store best score
        t = t + 1;
        PySOA_curve(t) = Python_Score;
    end
end
