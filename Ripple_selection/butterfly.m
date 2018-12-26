function butterfly(p,w)
 
    for j=1:length(p)
      plot(p{j}(w,:))
      hold on
      pause(0.01)
      title(j)
    end

end