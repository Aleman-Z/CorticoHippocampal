function nolearn_ripples
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,timeasleep2,RipFreq3]=newest_only_ripple_nl_level(level);
ripple3=ripple_nl;

[p_nl,q_nl,timecell_nl,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),CHTM2(level+1));

if selectripples==1

[ran_nl]=rip_select(p_nl);

p_nl=p_nl([ran_nl]);
q_nl=q_nl([ran_nl]);
timecell_nl=timecell_nl([ran_nl]);
end