TITLE K-A
: K-A current for Mitral Cells from Wang et al (1996)
: M.Migliore Jan. 2002

NEURON {
	SUFFIX KA
	USEION k READ ek WRITE ik
	RANGE  gbar, ik, m, h, sha,shi, k_tauH,sh_tauH
	GLOBAL minf, mtau, hinf, htau
}

PARAMETER {
	gbar = 0.0002   	(mho/cm2)	
								
	celsius  (degC)
	ek	= -70	(mV)            : must be explicitly def. in hoc
	v 		(mV)
	a0m=0.04
	vhalfm=-45
	zetam=0.1
	gmm=0.75

	a0h=0.018
	vhalfh=-70
	zetah=0.2
	gmh=0.99

	sha=9.9
	shi=5.7
	
	q10=3
	
	k_tauH=1.0    : 2.5; added by GL
	sh_tauH=-0    : -20; added by GL
}


UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
	(pS) = (picosiemens)
	(um) = (micron)
} 

ASSIGNED {
	ik 		(mA/cm2)
	minf 		mtau (ms)	 	
	hinf 		htau (ms)
	qt
}
 

STATE { m h}

BREAKPOINT {
	SOLVE states METHOD cnexp
	ik = gbar*m*h*(v - ek)
} 

INITIAL {
	qt=q10^((celsius-24(degC))/10(degC))
	trates(v)
	m=minf  
	h=hinf  
}

DERIVATIVE states {   
    trates(v)
    m' = (minf-m)/mtau
    h' = (hinf-h)/htau
}

PROCEDURE trates(v (mV)) {  
	minf = 1/(1 + exp(-(v/1(mV)-sha-7.6)/14))
	mtau = betm(v)/(qt*a0m*(1+alpm(v)))*1(ms)

	hinf = 1/(1 + exp((v/1(mV)-shi+47.4)/6))
	htau = k_tauH*beth(v)/(qt*a0h*(1+alph(v)))*1(ms)
}

FUNCTION alpm(v(mV)) {
	alpm = exp(zetam*(v/1(mV)-vhalfm))
}

FUNCTION betm(v(mV)) {
    betm = exp(zetam*gmm*(v/1(mV)-vhalfm))
}

FUNCTION alph(v(mV)) {
    alph = exp(zetah*(v/1(mV)-vhalfh-sh_tauH))
}

FUNCTION beth(v(mV)) {
    beth = exp(zetah*gmh*(v/1(mV)-vhalfh-sh_tauH))
}
