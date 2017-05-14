function fname = unique_fname(fdir,stem)
% Creats a unique file of the form stem_#.mat

files = dir([fdir,stem,'_*.mat']);

if isempty(files)
    idx = num2str(1);
else 
    tmp = files(end).name(length(stem)+2:end-4);
    idx = num2str(str2double(tmp)+1);
end
    

fname = [stem,'_',idx];
