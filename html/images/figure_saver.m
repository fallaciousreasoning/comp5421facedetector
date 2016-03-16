files = dir( fullfile('', '*.fig') );

for i = 1:size(files)
    figure = openfig(files(i).name, 'invisible');
    [path, name, ext] = fileparts(files(i).name);
    saveas(figure, strcat(name, '.png'));
end