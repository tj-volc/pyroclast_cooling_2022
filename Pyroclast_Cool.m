function Pyroclast_Cool
% This code has been adpated from Gerald Recktenwald. 
% The original citation is: Recktenwald, Gerald, 2006, Transient, one-dimensional heat conduction in a convectively cooled sphere, Portland State University, Department of Mechanical and Materials Engineering, accessed 11 August 2011 at http://web.cecs.pdx.edu/~gerry/epub/pdf/transientConductionSphere.pdf and permanent link http://www.webcitation.org/60nDyv3Yy.
% Please cite this original work when using this code.


% --- Specify constants %USER DEFINED 
        h = 15.04508498; %  heat transfer coefficent,  W/m^2/C
        k = 2;          %  thermal conductivity,  W/m/K
        alfa = 1e-5;     %  thermal diffusivity,  m^2/s
        ro = 0.005;       %  radius of sphere,  m
        tmax = 40;        %  stop time, s
% -------------------- 

r = linspace(0,ro); % generates row vector of 100 linearly equally spaced points
t = linspace(0,tmax);

% --- Compute theta at center and at the surface of the sphere.
%     Characteristic length is r0 for the exact solution.
Bi = h*ro/k
Fo = alfa*t/ro^2;
theta = Tsphere(Bi,Fo,2);  %  nr = 2 for r*=0 and r*=1 

% --- Convert to temperature and plot
Ti = 1244;   Tinf = 100;    %USER DEFINED %Ti is the initial pyroclast temperature, and Tinf is the surrounding air temp              
T = Tinf + theta*(Ti-Tinf);
semilogx(t,T(1,:),'b-')
hold on
semilogx(t,T(2,:),'r--')
axis([0 max(t) 20 Ti+20]);
xlabel('Time, {\it{t}} (s)');    ylabel('Pyroclast Temperature, {\it{T}} ({}^\circ C)');
legend('Center','Surface','Location','NorthEast');
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',16)
hold off
saveas(gcf, 'T-t_plot', 'fig')

end
