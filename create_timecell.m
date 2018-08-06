%create Time cell
function [C]=create_timecell(ro,leng)
    fn=1000;
    vec=-ro/fn:1/fn:ro/fn;
    C    = cell(1, leng);
    C(:) = {vec};
end


