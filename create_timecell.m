%create Time cell
function [C]=create_timecell(ro)
    fn=1000;
    vec=-ro/fn:1/fn:ro/fn;
    C    = cell(1, 1000);
    C(:) = {vec};
end


