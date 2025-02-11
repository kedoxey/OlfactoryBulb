TITLE nax
: Na current for axon. No slow inact.
: M.Migliore Jul. 1997
: added sh to account for higher threshold M.Migliore, Apr.2002

NEURON {
    THREADSAFE
	SUFFIX Na
	USEION na READ ena WRITE ina
	RANGE  gbar, sh, m, h
	GLOBAL minf, hinf, mtau, htau,thinf, qinf
}

PARAMETER {
	sh   = 5	(mV)
	gbar = 0.010   	(mho/cm2)	
								
	tha  =  -30	(mV)		: v 1/2 for act	
	qa   = 7.2	(mV)		: act slope (4.5)		
	Ra   = 0.4	(/ms)		: open (v)		
	Rb   = 0.124 (/ms)		: close (v)

	thi1 = -45	(mV)		: v 1/2 for inact
	thi2 = -45 	(mV)		: v 1/2 for inact
	qd   = 1.5	(mV)	    : inact tau slope
	qg   = 1.5  (mV)
	mmin = 0.02 (ms)
	hmin = 0.5  (ms)
	q10  = 2.0
	Rg   = 0.01 	(/ms)	: inact recov (v)
	Rd   = .03 	(/ms)		: inact (v)	

	thinf  = -50 	(mV)	: inact inf slope
	qinf  = 4 	(mV)		: inact inf slope 

	ena		(mV)            : must be explicitly def. in hoc
	celsius     (degC)
	v 		(mV)

}


UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
	(pS) = (picosiemens)
	(um) = (micron)
} 

ASSIGNED {
	ina 		(mA/cm2)
	thegna		(mho/cm2)
	minf 		hinf 		
	mtau (ms)	htau (ms)
	qt
}
 

STATE { m h}

BREAKPOINT {
    SOLVE states METHOD cnexp
    thegna = gbar*m*m*m*h
	ina = thegna * (v - ena)
} 

INITIAL {
    qt=q10^((celsius-24(degC))/10(degC))
	trates(v,sh)
	m=minf  
	h=hinf
}

DERIVATIVE states {   
    trates(v,sh)
    m' = (minf-m)/mtau
    h' = (hinf-h)/htau
}

PROCEDURE trates(vm (mV),sh2 (mV)) {  
    LOCAL  a, b

	a = trap0( vm, tha+sh2,Ra,qa)
	b = trap0(-vm,-tha-sh2,Rb,qa)

	mtau = 1(ms)/(a+b)/qt

    if (mtau < mmin) {
        mtau=mmin
    }

	minf = a/(a+b)

	a = trap0( vm, thi1+sh2,Rd,qd)
	b = trap0(-vm,-thi2-sh2,Rg,qg)

	htau =  1(ms)/(a+b)/qt

    if (htau<hmin) {
        htau=hmin
    }

	hinf = 1/(1+exp((vm-thinf-sh2)/qinf))
}

FUNCTION trap0(v (mV),th (mV),a (/ms),q (mV)) {
	if (fabs((v-th)/1(mV)) > 1e-6) {
	        trap0 = a*1(ms) * ((v - th)/1(mV)) / (1 - exp(-(v - th)/q))
	} else {
	        trap0 = a*1(ms) * (q/1(mV))
 	}
}	

        







