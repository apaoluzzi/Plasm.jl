using LARVIEW
using PyCall
@pyimport larlib as p
include("./utilities.jl")


V,(VV,EV,FV,CV) = LARLIB.larCuboids([3,2,1],true)

Z = hcat(V[:,1],V)
W = PyCall.PyObject([Any[Z[h,k] for h=1:size(Z,1)] for k=1:size(Z,2)])

VV,EV,FV,CV = map(LARVIEW.doublefirst, [VV+1,EV+1,FV+1,CV+1])
WW,EW,FW,CW = map(LARVIEW.array2list,[VV,EV,FV,CV])
PyCall.PyObject([WW,EW,FW,CW])
model = p.MKPOL(PyCall.PyObject([W,EW,[]]))

VV,EV,FV,CV = VV-1,EV-1,FV-1,CV-1
WW,EW,FW,CW = map(LARVIEW.array2list,[VV,EV,FV,CV])
hpc = p.larModelNumbering(1,1,1)(W,PyCall.PyObject([WW,EW,FW,CW]),model,1.0)
p.VIEW(hpc)
