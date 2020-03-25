function [state_counts, state_params] = batchTraceAnalysis(traces)
state_counts = NaN(size(traces,1),1,'single');
state_params = cell(size(traces,1),1);
parfor i=1:size(traces,1)
    %get data into the right form
    trace = rmmissing(squeeze(traces(i,:,:)))';
    try
        [Ns, state_param] = cpbic_analysis(trace);
    catch
        warning("something didn't converge? setting the states to -1");
        Ns = -1;
        state_param = [0 -1 -1];
    end
    state_counts(i) = Ns;
    state_params{i} = state_param;
end
end