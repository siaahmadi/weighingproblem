function weighingProblem12(balls)
%WEIGHINGPROBLEM12 Find the oddball (heavier/lighter) in a set of 12
%otherwise indistinguishable balls
%
% You are given 12 balls and a balance. One of the balls is either heavier
% or lighter than the rest. The balls are distinguishable only by weighing
% with the given balance. The balance can be used as many times as desired
% but you wish to find the oddball (and determine whether it's heavier or
% lighter) in as few weighings as possible.
%
% The balance gives you one of 3 outcomes: a) balanced, b) left side
% heavier, c) right side heavier. Therefore, the weighing problem can be
% modeled as a random variable with three outcomes (a ternanry alphabet).
% The information content of a set of 12 balls with such a random variable
% would be log3(12) ~= 2.261859 (I guess if the unit for a binary alphabet
% is bits, then the unit for a ternary alphabet would be "tits?" Anyway...)
% Therefore, on average log3(12) comparisons are required to find the
% oddball, which in reality means 3 comparisons are necessary.
% 
% Information theory dictates that to reach this limit, at each step of the
% way, the random variable (i.e. weighing) must be made in such a way that
% it follows a probability distribution that maximizes the entropy of the
% random variable. This is exactly what is illustrated by this simple
% script.
%
% USAGE:
% Takes in an vector of 12 real numbers with 11 of those numbers being the
% same. The 12th number, which can be placed at any position, must be
% either larger or smaller than the 11 identical numbers. This script will
% display messages for each comparison made on the way to finding the
% distinct number.
%
% The script is blind to the actual numbers. It makes exactly 3 comparisons
% between subsets of the input without knowing what the actual numbers are.
% This can be verified by inspecting the code. There is nothing magical
% about this code. It is meant to demonstrate the optimal algorithm for
% the 12-ball special case of the weighing problem.
%
% The script does not validate the input. If the input does not follow the
% expected format, either an error or the wrong answer will be displayed.


if sum(balls(1:4)) == sum(balls(5:8)) % first comparison -- oddball in 9:12
	fprintf('First Comparison -->\tOddball one of [9,10,11,12]\n');
	if sum(balls(9:10)) == sum(balls([1,11])) % second comparison
		fprintf('Second Comparison -->\tOddball is 12]\n');
		if balls(12) < balls(1)
			fprintf('Third Comparison -->\t Oddball Found: 12 (Lighter)\n');
		else
			fprintf('Third Comparison -->\t Oddball Found: 12 (Heavier)\n');
		end
	elseif sum(balls(9:10)) > sum(balls([1,11]))
		fprintf('Second Comparison -->\tOddball one of [9(H),10(H),11(L)]\n');
		if sum(balls(10:11)) < sum(balls(1:2))
			fprintf('Third Comparison -->\t Oddball Found: 11 (Lighter)\n');
		elseif sum(balls(10:11)) > sum(balls(1:2))
			fprintf('Third Comparison -->\t Oddball Found: 10 (Heavier)\n');
		else
			fprintf('Third Comparison -->\t Oddball Found: 9 (Heavier)\n');
		end
	else
		fprintf('Second Comparison -->\tOddball one of [9(L),10(L),11(H)]\n');
		if sum(balls(10:11)) < sum(balls(1:2))
			fprintf('Third Comparison -->\t Oddball Found: 10 (Lighter)\n');
		elseif sum(balls(10:11)) > sum(balls(1:2))
			fprintf('Third Comparison -->\t Oddball Found: 11 (Heavier)\n');
		else
			fprintf('Third Comparison -->\t Oddball Found: 9 (Lighter)\n');
		end
	end
elseif sum(balls(1:4)) > sum(balls(5:8)) % first comparison -- 9:12 are good
	fprintf('First Comparison -->\t Oddball one of [1(H),2(H),3(H),4(H),5(L),6(L),7(L),8(L)]\n');
	if sum(balls([1,2,5])) > sum(balls([3,4,6])) % second comparison
		fprintf('Second Comparison -->\t Oddball one of [1(H),2(H),6(L)]\n');
		if sum(balls([1, 6])) > sum(balls([9, 10]))
			fprintf('Third Comparison -->\t Oddball found: 1 (Heavier)\n');
		elseif sum(balls([1, 6])) < sum(balls([9, 10]))
			fprintf('Third Comparison -->\t Oddball found: 6 (Lighter)\n');
		else
			fprintf('Third Comparison -->\t Oddball found: 2 (Heavier)\n');
		end
	elseif sum(balls([1,2,5])) < sum(balls([3,4,6]))
		fprintf('Second Comparison -->\t Oddball one of [3(H),4(H),5(L)]\n');
		if sum(balls([3, 5])) > sum(balls([9, 10]))
			fprintf('Third Comparison -->\t Oddball found: 3 (Heavier)\n');
		elseif sum(balls([3, 5])) < sum(balls([9, 10]))
			fprintf('Third Comparison -->\t Oddball found: 5 (Lighter)\n');
		else
			fprintf('Third Comparison -->\t Oddball found: 4 (Heavier)\n');
		end
	else
		fprintf('Second Comparison -->\t Oddball one of [7,8] (Lighter) \n');
		if balls(7) > balls(8)
			fprintf('Third Comparison -->\t Oddball found: 8 (Lighter) \n');
		else
			fprintf('Third Comparison -->\t Oddball found: 7 (Lighter) \n');
		end
	end
else % first comparison -- 9:12 are good
	fprintf('First Comparison -->\t Oddball one of [1(L),2(L),3(L),4(L),5(H),6(H),7(H),8(H)]\n');
	if sum(balls([1,5,6])) > sum(balls([2,7,8])) % second comparison
		fprintf('Second Comparison -->\t Oddball one of [2(L),5(H),6(H)]\n');
		if sum(balls([2, 5])) > sum(balls([9, 10]))
			fprintf('Third Comparison -->\t Oddball found: 5 (Heavier)\n');
		elseif sum(balls([2, 5])) < sum(balls([9, 10]))
			fprintf('Third Comparison -->\t Oddball found: 2 (Lighter)\n');
		else
			fprintf('Third Comparison -->\t Oddball found: 6 (Heavier)\n');
		end
	elseif sum(balls([1,5,6])) < sum(balls([2,7,8])) % second comparison
		fprintf('Second Comparison -->\t Oddball one of [1(L),7(H),8(H)]\n');
		if sum(balls([1, 7])) > sum(balls([9, 10]))
			fprintf('Third Comparison -->\t Oddball found: 7 (Heavier)\n');
		elseif sum(balls([1, 7])) < sum(balls([9, 10]))
			fprintf('Third Comparison -->\t Oddball found: 1 (Lighter)\n');
		else
			fprintf('Third Comparison -->\t Oddball found: 8 (Heavier)\n');
		end
	else
		fprintf('Second Comparison -->\t Oddball one of [3,4] (Lighter) \n');
		if balls(3) > balls(4)
			fprintf('Third Comparison -->\t Oddball found: 4 (Lighter) \n');
		else
			fprintf('Third Comparison -->\t Oddball found: 3 (Lighter) \n');
		end
	end
end