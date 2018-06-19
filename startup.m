
fprintf('You are jtesch!\n');

wfsc_dir = '~/wfsc/';
mljat_dir = '~/matlab_jat/';
exfig_dir = '~/Documents/MATLAB/export_fig';


% WFSC directory
fprintf('Adding %s\n',wfsc_dir);
addpath(genpath(wfsc_dir));

% Add my stuff
fprintf('Adding %s\n',mljat_dir);
addpath(mljat_dir);

% Add export_fig directory
fprintf('Adding %s\n',exfig_dir);
addpath(exfig_dir);

% Figure defaults
set(0,'DefaultFigureColor','w')
set(0,'DefaultAxesXGrid','on');
set(0,'DefaultAxesYGrid','on');
set(0,'DefaultAxesFontSize',12);

% set(0,'defaulttextinterpreter','latex')

% Set default colormap
%set(groot,'DefaultFigureColormap',jet)
%close all;

% shut up
beep off;

% Import wfsc/+util
import util.*;      % import wfsc/+util functions

fprintf('\n\n');


