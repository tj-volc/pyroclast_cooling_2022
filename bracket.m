function xb = bracket(fun,xmin,xmax,nx,varargin)
% brackPlot  Find brackets for roots of a function.
%
% Synopsis:  xb = bracket(fun,xmin,xmax)
%            xb = bracket(fun,xmin,xmax,nx)
%
% Input:  fun = (string) name of function for which roots are sought
%         xmin,xmax = endpoints of interval to subdivide into brackets.
%         nx = (optional) number of subintervals.  Default:  nx = 20.
%
% Output:  xb = 2-column matrix of bracket limits.  xb(k,1) is the left
%               bracket and xb(k,2) is the right bracket for the kth
%               potential root.  If no brackets are found, xb = [].

if nargin<4, nx=20; end

x = linspace(xmin,xmax,nx);    %  Test f(x) at these x values
f = feval(fun,x,varargin{:});
nb = 0;
xbtemp = zeros(nx,2);   %  Temporary storage for brackets as they are found

for k = 1:length(f)-1
  if sign(f(k))~=sign(f(k+1))  %  True if f(x) changes sign in interval
    nb = nb + 1;
    xbtemp(nb,:) = x(k:k+1);
  end
end

% -- Return nb-by-2 matrix of brackets.
if nb == 0
	warning('bracket:NoSignChange','No brackets found. Change [xmin,xmax] or nx');
  xb = [];
else
  xb = xbtemp(1:nb,:);
end

end