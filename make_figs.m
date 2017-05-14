function make_figs(dname,ftype,opts)

if nargin==2, opts = []; end;
if ~strcmp(dname(end),'/'), dname = [dname,'/']; end;

f = dir([dname,'*.fig']);

fprintf('\nMaking figures for %g plots:\n',length(f));

for k=1:length(f)
    
    fname = [dname,f(k).name(1:end-4),'.',ftype];
    fprintf('\t%s\n',fname);
    cmd = sprintf('export_fig %s -%s %s',fname,ftype,opts);
    open([dname,f(k).name]);
    eval(cmd);
    close gcf;
end

fprintf('\n');