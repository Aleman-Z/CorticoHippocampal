function Avero = LL_clean(LL)
    %LL_CLEAN Remove outliers from each cell of a cell array.
    %
    %   Avero = LL_clean(LL)
    %
    %   Input:
    %       LL - Cell array where each element contains a numeric vector.
    %
    %   Output:
    %       Avero - Cell array of the same size, with outliers removed
    %                from each numeric vector using isoutlier.
    %

    % Validate input
    if ~iscell(LL)
        error('Input must be a cell array.');
    end

    % Preallocate output with same size
    Avero = cell(size(LL));

    % Loop over cells
    for v = 1:size(LL,1)
        for j = 1:size(LL,2)
            data = LL{v,j};  % get numeric vector
            if isnumeric(data) && isvector(data)
                Avero{v,j} = data(~isoutlier(data));
            else
                warning('Skipping non-numeric or non-vector at (%d,%d).', v, j);
                Avero{v,j} = [];
            end
        end
    end
end
