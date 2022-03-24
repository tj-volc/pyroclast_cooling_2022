function [T,r] = Tsphere(Bi,Fo,nr,verbose)
% Tsphere  Dimensionless T(r,t) for convective cooling of a sphere
%
% Synopsis:  T = Tsphere(Bi,Fo)
%            T = Tsphere(Bi,Fo,nr)
%            T = Tsphere(Bi,Fo,nr,verbose)
%            [T,r] = Tsphere(...)
%
% Input:  Bi = scalar, Biot number for the sphere
%         Fo = scalar or vector of Fourier numbers (dimensionless time)
%         nr = number of r values at which to evaluate T(r,t).  If nr=1
%              only r=0 is used.  Default: nr=1
%         verbose = flag to control printing.  Default: verbose = false
%
% Output:  T = matrix of dimensionless temperatures (theta).  Column j
%              T(:,j) is a vector of theta values at the nr dimensionless
%              radial locations uniformly spaced in 0 <= rstar <= 1.
%              T(:,j) is the profile at dimensionless time Fo(j).
%          r = dimensionless radial locations: 0 <= r <= 1
%          verbose = flag to control printing.  Default: verbose = false

if nargin<1,     error('You must suppy a value for Bi');    end
if numel(Bi)>1,  error('Bi must be a scalar');              end
if nargin<2,     error('You must supply a value for Fo');   end
if nargin<3,     nr=1;           end
if nargin<4,     verbose=false;  end

% --- Find zeta in range 0<zeta<=50, and compute coefficients of series
zeta = zRoots(Bi,1250);
c = 4*(sin(zeta) - zeta.*cos(zeta))./(2*zeta - sin(2*zeta));

% --- Special handling for nr=1 to avoid creation of a vector
if nr==1
  rstar = 2*eps;                 %  Use eps instead of zero to avoid
else                             %  division by zero in formula for T
  rstar = linspace(2*eps,1,nr)'; %  rstar must be a columnn vector
end
% --- Vectorized loop to evaluate theta = f(Bi,Fo).  T is nr-by-nf
%     matrix, where nf is number of radial locations and nf is number
%     of Fo values.  Construct T by summing outer products of column
%     vector (sin(zeta1*rstar)./(zeta1*rstar)) with row vector
%     exp(-zeta1^2*Fo).
Fov = Fo(:)';   %  Local copy of Fo, guaranteed to be a row vector
T = c(1)*(sin(zeta(1)*rstar)./(zeta(1)*rstar))*exp(-zeta(1)^2*Fov);
for k=2:length(zeta)
  dT = c(k)*(sin(zeta(k)*rstar)./(zeta(k)*rstar))*exp(-zeta(k)^2*Fov);
  T = T + dT;
end

% Check for convergence after all terms are added
dTmax = max(max(abs(dT)));
tol = 0.005;
if dTmax > tol
  % Some dT values exceed the tolerance.  Print a warning message
	warning('oneSphere:NotConverged','Series not converged: dTmax = %g for Bi = %g\n',dTmax,Bi);
  
  %  Print the troublesome locations.
  fprintf('\nConvergence trouble at positions and times:\n   rstar        Fo           dT\n')
  [ibad,jbad] = find( max(abs(dT)>tol) );
  for k=1:length(ibad)
    fprintf('%11.8f  %11.8f  %11.8f\n',rstar(ibad(k)),Fo(jbad(k)),dT(ibad(k),jbad(k)));
  end
end
if nargout>1,  r = rstar;  end   %  create second, optional, output variable
if ~verbose, return;  end
% --- Print results
fprintf('\nDimensionless Temperature Profile\n\tdTmax = %g\n\n',dTmax);
fprintf('         |  Fo =\n    r*   |');  fprintf(' %7.4f',Fo);
fprintf('\n%s\n',['----------',repmat('--------',1,length(Fo))]);
for i=1:size(T,1)
  fprintf(' %7.4f |',r(i));  fprintf(' %7.4f',T(i,:));  fprintf('\n');
end

end