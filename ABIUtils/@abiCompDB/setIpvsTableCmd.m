function setIpvsTableCmd(obj)
    % Override the base class to name many input parameters for clarity
    obj.createIpvsTableCmd = ['CREATE TABLE ipvs (' ...
        'ipvIDX int(11) NOT NULL AUTO_INCREMENT, ' ...
        'expDataSetIDX int(11) NOT NULL, ' ...
        'tstop double, ' ...
        'tstep double, ' ... 
        'taum double, ' ...
        'p04 char(100), ' ...
        'p05 char(100), ' ...
        'rM double, ' ...
        'vRest double, ' ...
        'thresholdHeight double, ' ...
        'spikeHeight double, ' ...
        'p10 char(100), ' ...
        'stimulusType char(100), ' ...
        'p12 char(100), ' ...
        'stimulusStartTime double, ' ...
        'pulseWidth double, ' ...
        'pulseCurrent double, ' ...
        'p16 char(100), ' ...
        'p17 char(100), ' ...
        'p18 char(100), ' ...
        'p19 char(100), ' ...
        'p20 char(100), ' ...
        'p21 char(100), ' ...
        'FOREIGN KEY (expDataSetIDX) REFERENCES expDataSets(expDataSetIDX), ' ...
        'PRIMARY KEY (ipvIDX)) ENGINE=InnoDB'];
end
