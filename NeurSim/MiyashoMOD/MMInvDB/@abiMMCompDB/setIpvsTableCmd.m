function setIpvsTableCmd(obj)
    % Override the base class to name many input parameters for clarity
    obj.createIpvsTableCmd = ['CREATE TABLE ipvs (' ...
        'ipvIDX int(11) NOT NULL AUTO_INCREMENT, ' ...
        'expDataSetIDX int(11) NOT NULL, ' ...
        'curr double, ' ...
		'vinit double, ' ...
		'delay double, ' ...
        'stimdur double, ' ...
        'tstep double, ' ... 
        'tstop double, ' ...
		'rcdintvl double, ' ...
        'Kh_soma double, ' ...
        'Kh_smooth double, ' ...
        'Kh_spiny double, ' ...
        'CaE_soma double, ' ...
        'CaE_smooth double, ' ...
        'CaE_spiny double, ' ...
        'KD_soma double, ' ...
        'KD_smooth double, ' ...
        'KD_spiny double, ' ...
        'p17 double, ' ...
        'p18 double, ' ...
        'p19 double, ' ...
        'p20 double, ' ...
        'p21 double, ' ...
        'FOREIGN KEY (expDataSetIDX) REFERENCES expDataSets(expDataSetIDX), ' ...
        'PRIMARY KEY (ipvIDX)) ENGINE=InnoDB'];
end
