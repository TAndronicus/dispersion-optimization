function [ geometryType ] = getGeometryTypeFromShort( geometryTypeShort )
%GETGEOMETRYTYPEFROMSHORT Summary of this function goes here
%   Detailed explanation goes here
if(geometryTypeShort == 'h')
    geometryType = 'Hexagon';
elseif(geometryTypeShort == 'k')
    geometryType = 'Kagome';
elseif(geometryTypeShort == 'b')
    geometryType = 'Hybrid';
else
    disp('Wrong geometry type.');
end

end

