function z = zRoots(Bi,zmax,verbose)
% zRoots  Find all roots to 1 - z*cot(z) - Bi over a range of z
%
% Synopsis:  z = zRoots
%            z = zRoots(Bi)
%            z = zRoots(Bi,zmax)
%            z = zRoots(Bi,zmax,verbose)
%
% Input:     Bi = Biot number.  Default:  Bi = 10
%            zmax = upper limit of a range.  Roots are sought in the
%                   range 0 < zeta <= zmax.  Default: zmax=50
%            verbose = flag to control print out
%                      Default:  verbose = 0  (no extra print out)
%
% Output:    z = Vector of roots in the interval 0 < z <= zmax

if nargin<1 || isempty(Bi),       Bi = 10;      end
if nargin<2 || isempty(zmax),     zmax = 50;    end
if nargin<3 || isempty(verbose),  verbose = 0;  end

% --- Find brackets for zeros of 1 - z*cot(z) - Bi
nzb = max([250 50*zmax]);
zb = bracket(@zfun,10*eps,zmax,nzb,Bi);   %  zb is a 2 column matrix

% --- Find the zero (or singularity) contained in each bracket pair
mb = size(zb,1);  zall = zeros(mb,1);  %  Preallocate array for roots
%  Call optimset to create the data structure that controls fzero
%  Use no messages ('Display','Off') and tight tolerance ('TolX',5e-9)
fzopts = optimset('Display','Off','TolX',5e-9);
for k=1:mb
  zall(k) = fzero(@zfun,zb(k,:),fzopts,Bi);
end

% --- Sort out roots and singularities.  Singularites are "roots"
%     returned from fzero that have f(z) greater than a tolerance.
fall = zfun(zall,Bi);          %  evaluate f(z) at all potential roots
igood = find(abs(fall)<5e-4);     %  vector of indices of good roots
ngood = length(igood);
z = zall(igood);   f = fall(igood);
zbad = zall(:);    ibad = (1:length(zbad))';  %  First copy all data
zbad(igood) = [];  ibad(igood) = [];          %  then throw away good parts
nbad = length(ibad);
fprintf('%d good zeta values found in zSphereRoots()\n',ngood);
if nbad>0
  fprintf('%d potential zeros are suspected to be singularities\n',nbad);
end

% --- Verbose output:  lists of good and bad roots, plot of f(zeta)
if verbose
  % --- Print list of all roots and singularities.
  fprintf('\nAll roots found by fzero\n');
  fprintf('   k     zleft       z        zright       f(z)\n');
  for k=1:length(zall)
    fprintf('%4d  %8.4f   %8.4f   %8.4f  %12.3e\n',k,zb(k,1),zall(k),zb(k,2),fall(k));
  end
  % --- Print list of good roots.
  fprintf('\nGood roots returned by zRoots\n');
  fprintf('   n      z         f(z)\n');
  for k=1:length(z)
    fprintf('%4d  %8.4f  %12.3e\n',igood(k),z(k),f(k));
  end
  % --- Print list of bad roots, i.e. singularities.
  fprintf('\nSingularities eliminated from list of roots\n');
  fprintf('   n     zbad       f(zbad)\n');
  for k=1:length(zbad)
    fprintf('%4d  %8.4f  %12.3e\n',ibad(k),zbad(k),fall(ibad(k)));
  end
  % --- Plot f(z) and identify roots and singularities.
  dz = 0.05;
  nall = length(zall);  iall = zeros(nall,1);  iall(igood) = ones(size(igood));
  hold('on');
  for k=1:nall
    if iall(k)~=0    %  Interval contains a root
      % -- Deal with ends of zeta range: avoid index out of bounds
      if k==1,     zstart = eps;       % zstart=0 causes 1/0 error
      else         zstart = zall(k-1) + dz;  end
      if k==nall,  zstop = zmax;
      else         zstop = zall(k+1) - dz;   end
      x = linspace(zstart,zstop);
      g = zfun(x,Bi);
      plot(x,g,'b-',zall(k),fall(k),'r*');
      
    else  %  Interval contains a singularity
      plot([zall(k) zall(k)],[-100 100],'r--',zall(k),0,'ro');
    end
  end
  plot([0 zmax],[0 0],'k-');  hold off
  axis([0 zmax -30 30]); xlabel('\zeta');  ylabel('f(\zeta)','Rotation',0);
end

end