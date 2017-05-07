classdef CmpMM < Comparator
    properties
    end
    methods
        function obj = CmpMM(expDBConn, simDB, expDataDir, cURLBinDir)
            obj = obj@Comparator(expDBConn, simDB, expDataDir, cURLBinDir);
            obj.numScoresUsed = 3;
            obj.name = 'CMP03';  
        end
        
        % This comparator type compares only one specimen/exp with each
        % simulation in the simulation list.
        % simulation.
        % Features compared: 
        %       hasSpikes T/F, ISIMean (score1)
        %       hasSpikes T/F, latency, ISIMean (score2)
        %       hasSpikes T/F, latency, ISIMean, adaptation  (score3)
        % Measure: L2 norm
        function results = compare(obj, specIDList, expIDList, simList)
            specID = specIDList{1};
            expID = expIDList{1};
            
            %% Get the experimental features for comparison
            expFX = obj.getExpExpFXData(specID, expID);
            expHasSpikes = expFX.hasSpikes;
            expMeanISI = expFX.ISIMean;
            expStimulusLatency = expFX.latency;
            expAdaptation = expFX.adaptation;
            
            %% Do the comparison for each simulation in the list
            for i=1:size(simList,1)
                %% Get the simulation features
                simFX = obj.simDB.getSimFeatureExtraction(...
                                    simList{i}.sessionID, ...
                                    simList{i}.simSetID, simList{i}.simID);
                if ~isstruct(simFX)
                    results = {};
                    return;
                end
                simHasSpikes = simFX.hasSpikes;
                % have to convert to seconds for the comparison
                simStimulusLatency = simFX.stimulusLatency/1000.0;
                % have to convert to seconds for the comparison
                simMeanISI = simFX.ISIMean/1000.0;
                simAdaptation = simFX.adaptation;
                runIndex = simFX.runIDX;

                %% Perform the subclass-specific comparisons
                results{i} = simList{i,1}; %#ok<*AGROW>
                % This comparator requires spikes in both
                if ~(expHasSpikes && simHasSpikes)
                    results{i}.score1 = realmax('double');
                    results{i}.score2 = realmax('double');
                    results{i}.score3 = realmax('double');
                else
                    results{i}.score1 = ...
                             abs((simMeanISI - expMeanISI) ...
                                / expMeanISI ...
                                 );
                    results{i}.score2 = ...
                        sqrt( ...
                             ((simStimulusLatency - expStimulusLatency) ...
                                / expStimulusLatency ...
                              )^2 * 0.5 + ...
                             ((simMeanISI - expMeanISI) ...
                                / expMeanISI ...
                              )^2 * 0.5 ...
                             );

                    results{i}.score3 = ...
                        sqrt( ...
                             ((simStimulusLatency - expStimulusLatency) ...
                                / expStimulusLatency ...
                              )^2 / 3.0 + ...
                             ((simAdaptation - expAdaptation) ...
                                / expAdaptation * 1.0 ...
                              )^2 / 3.0 + ...
                             ((simMeanISI - expMeanISI) ...
                                / expMeanISI * 1.0 ...
                              )^2 / 3.0 ...
                             );
                end
                results{i}.score4 = NaN;
                results{i}.score5 = NaN;

                %% Add the results to the investigation database  
                results{i}.compIndex = ...
                    obj.simDB.addComparison(runIndex, obj.name, ...
                            results{i}.score1, results{i}.score2, ...
                            results{i}.score3, results{i}.score4, ...
                            results{i}.score5);
            end            
        end
    end
end
