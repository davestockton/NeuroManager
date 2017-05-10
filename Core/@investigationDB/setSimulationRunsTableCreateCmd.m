function setSimulationRunsTableCreateCmd(obj)
    % This version may be suitable for many applications but is easily
    % overridden to add columns.  See the abiCompDB subclass for a
    % minor override.
    obj.createSimulationRunsTableCmd = ...
        ['CREATE TABLE simulationRuns (' ... 
        'runIDX int(11) NOT NULL AUTO_INCREMENT, ' ...
        'ipvIDX int(11) NOT NULL, ' ...
        'simulatorIDX int(11), ' ...
        'sessionIDX int(11) NOT NULL, ' ...
        'fxIDX int(11), ' ...
        'simSetID char(100), ' ...
        'simID char(100), ' ...
        'simSampleRate double, ' ...
        'simulationDuration double, ' ...
        'state char(100), ' ...
        'simSpecFilename char(100), ' ...
        'resultsDir varchar(400), ' ...
        'stimulusFilename char(100), ' ...
        'voltageFilename char(100), ' ...
        'timeFilename char(100), ' ...
        'other01Filename char(100), ' ...
        'other02Filename char(100), ' ...
        'runtime double, ' ...
        'result char(20), ' ...
        'FOREIGN KEY (ipvIDX) REFERENCES ipvs(ipvIDX), ' ...
        'FOREIGN KEY (simulatorIDX) REFERENCES simulators(simulatorIDX), ' ...
        'FOREIGN KEY (sessionIDX) REFERENCES sessions(sessionIDX), ' ...
        'FOREIGN KEY (fxIDX) REFERENCES simFeatureExtractions(fxIDX), ' ...
        'PRIMARY KEY (runIDX)) ENGINE=InnoDB'];
end