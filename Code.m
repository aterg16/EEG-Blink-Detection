% Load eeglab
EEG = eeglab;

%load data into eeglab
EEG = pop_fileio('C:\Users\%ADD PATH%');
EEG = eeg_checkset( EEG );

%eventlist
EEG  = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' } ); 
EEG = eeg_checkset( EEG );

%event_latencies = [EEG.event.latency];
event_timings = [EEG.event.latency] / EEG.srate;

% Extract start and end times
start_time = EEG.event(3).latency / EEG.srate;
end_time = EEG.event(4).latency / EEG.srate;

% parameter
params = checkBlinkerDefaults(struct(), getBlinkerDefaults(EEG));
params.subjectID = '0000';
params.experiment = 'feedback';
params.uniqueName = '0000';
params.task = 'Maths';
params.blinkerSaveFile = 'C:\Users\%ADD PATH%';
params.dumpBlinkerStructures = true;
params.dumpBlinkImages = true;
params.dumpBlinkPositions = true;
params.keepSignals = false;
params.showMaxDistribution = true;
params.verbose = true;

% Select data between the start and end times
EEG = pop_select(EEG, 'time', [start_time end_time]);

% Use Blinker add-on to detect blinks
[EEG, com, blinks, blinkFits, blinkProperties, blinkStatistics, params] = ...
    pop_blinker(EEG, params);
