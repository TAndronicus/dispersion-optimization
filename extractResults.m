function [ lambda, dispersion, damping, Aeff, n2eff ] = extractResults( varargin )
%extractResults Function returns matrices with results of calculation
%   Arguments: geometryType, numberOfLayers, doping, coreDiameter,
%   latticeConstant, holeDiameter

if(varargin{1} == 1)
    geometryType = 'h';
elseif(varargin{1} == 2)
    geometryType = 'k';
elseif(varargin{1} == 3)
    geometryType = 'b';
end
numberOfLayers = varargin{2};
doping = varargin{3};
coreDiameter = varargin{4};
latticeConstant = varargin{5};
holeDiameter = varargin{6};
fileName = getNameOfFile(geometryTypeShort, numberOfLayers, doping, coreDiameter, latticeConstant, holeDiameter);
load(fileName);
dispersion = calculateDispersion(neff, lambda);

end

