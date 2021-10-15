function [files, labels] = hmdb51Files(dataFolder)

fileExtension = ".avi";
listing = dir(fullfile(dataFolder, "*", "*" + fileExtension));

numObservations = numel(listing);
files = strings(numObservations,1);
labels = cell(numObservations,1);

for i = 1:numObservations
    name = listing(i).name;
    folder = listing(i).folder;
    
    [~,labels{i}] = fileparts(folder);
    files(i) = fullfile(folder,name);
end

labels = categorical(labels);

end
