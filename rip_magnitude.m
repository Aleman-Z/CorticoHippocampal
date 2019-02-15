function [q]=rip_magnitude(q,w)

for j=1:length(q)
    q{j}(w,:)=q{j}(w,:)*0.195;
end

end