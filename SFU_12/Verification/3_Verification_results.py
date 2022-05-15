import random
import myFunctions as mf
import numpy as np
import matplotlib.pyplot as plt
import os
import subprocess



def absolute_error(real,actual):
    eabs=[]
    for i in range(0,len(real)):
        eabs.append(abs(real[i]-actual[i]))
    return eabs

def relative_error(real,actual):
    rerr=[]
    for i in range(0,len(real)):
        if real[i]==0:
            rerr.append(abs(abs((real[i]+1)-actual[i])/(real[i]+1)))
        else:
            rerr.append(abs(abs((real[i])-actual[i])/(real[i])))
    return rerr
    

print("verifing data in progress.........")


output_sin=mf.read_files("./SFU_Input_data/output_sin.csv");
output_cos=mf.read_files("./SFU_Input_data/output_cos.csv");
output_rsqrt=mf.read_files("./SFU_Input_data/output_rsqrt.csv");
output_log2=mf.read_files("./SFU_Input_data/output_log2.csv");
output_ex2=mf.read_files("./SFU_Input_data/output_ex2.csv");
output_rcp=mf.read_files("./SFU_Input_data/output_rcp.csv");
output_sqrt=mf.read_files("./SFU_Input_data/output_sqrt.csv");

Tmp_in_oper=[]
Tmp_out_oper=[]
for index in output_sin[9:]:
    W=index.split(',')
    Tmp_in_oper.append(W[0])
    Tmp_out_oper.append(W[1])

sine_data_in=np.float32(mf.hex2float(Tmp_in_oper))
sine_SFU_result=np.float32(mf.hex2float(Tmp_out_oper))


Tmp_in_oper=[]
Tmp_out_oper=[]
for index in output_cos[9:]:
    W=index.split(',')
    Tmp_in_oper.append(W[0])
    Tmp_out_oper.append(W[1])

cosine_data_in=np.float32(mf.hex2float(Tmp_in_oper))
cosine_SFU_result=np.float32(mf.hex2float(Tmp_out_oper))



Tmp_in_oper=[]
Tmp_out_oper=[]
for index in output_rsqrt[9:]:
    W=index.split(',')
    Tmp_in_oper.append(W[0])
    Tmp_out_oper.append(W[1])

rsqrt_data_in=np.float32(mf.hex2float(Tmp_in_oper))
rsqrt_SFU_result=np.float32(mf.hex2float(Tmp_out_oper))



Tmp_in_oper=[]
Tmp_out_oper=[]
for index in output_log2[9:]:
    W=index.split(',')
    Tmp_in_oper.append(W[0])
    Tmp_out_oper.append(W[1])

log2_data_in=np.float32(mf.hex2float(Tmp_in_oper))
log2_SFU_result=np.float32(mf.hex2float(Tmp_out_oper))


Tmp_in_oper=[]
Tmp_out_oper=[]
for index in output_ex2[9:]:
    W=index.split(',')
    Tmp_in_oper.append(W[0])
    Tmp_out_oper.append(W[1])

ex2_data_in=np.float32(mf.hex2float(Tmp_in_oper))
ex2_SFU_result=np.float32(mf.hex2float(Tmp_out_oper))


Tmp_in_oper=[]
Tmp_out_oper=[]
for index in output_rcp[9:]:
    W=index.split(',')
    Tmp_in_oper.append(W[0])
    Tmp_out_oper.append(W[1])

rcp_data_in=np.float32(mf.hex2float(Tmp_in_oper))
rcp_SFU_result=np.float32(mf.hex2float(Tmp_out_oper))



Tmp_in_oper=[]
Tmp_out_oper=[]
for index in output_sqrt[9:]:
    W=index.split(',')
    Tmp_in_oper.append(W[0])
    Tmp_out_oper.append(W[1])

sqrt_data_in=np.float32(mf.hex2float(Tmp_in_oper))
sqrt_SFU_result=np.float32(mf.hex2float(Tmp_out_oper))

##calculates absolute error
abs_err_sin=absolute_error(np.float32(np.sin(sine_data_in)),sine_SFU_result)
abs_err_cos=absolute_error(np.float32(np.cos(cosine_data_in)),cosine_SFU_result)
abs_err_rsqrt=absolute_error(np.float32(1/np.sqrt(rsqrt_data_in)),rsqrt_SFU_result)
abs_err_log2=absolute_error(np.float32(np.log2(log2_data_in)),log2_SFU_result)
abs_err_ex2=absolute_error(np.float32(2**(ex2_data_in)),ex2_SFU_result)
abs_err_rcp=absolute_error(np.float32(1/(rcp_data_in)),rcp_SFU_result)
abs_err_sqrt=absolute_error(np.float32(np.sqrt(sqrt_data_in)),sqrt_SFU_result)

## calculates relative error
rel_err_sin=relative_error(np.float32(np.sin(sine_data_in)),sine_SFU_result)
rel_err_cos=relative_error(np.float32(np.cos(cosine_data_in)),cosine_SFU_result)
rel_err_rsqrt=relative_error(np.float32(1/np.sqrt(rsqrt_data_in)),rsqrt_SFU_result)
rel_err_log2=relative_error(np.float32(np.log2(log2_data_in)),log2_SFU_result)
rel_err_ex2=relative_error(np.float32(2**(ex2_data_in)),ex2_SFU_result)
rel_err_rcp=relative_error(np.float32(1/(rcp_data_in)),rcp_SFU_result)
rel_err_sqrt=relative_error(np.float32(np.sqrt(sqrt_data_in)),sqrt_SFU_result)

Rdata=[]
Rdata.append("sin abs mean error=   "+str(np.mean((abs_err_sin)))+"   Std="+str(np.std((abs_err_sin)))+"  sin rel mean error=   "+str(np.mean((rel_err_sin)))+"   Std="+str(np.std((rel_err_sin))))
Rdata.append("cos abs mean error=   "+str(np.mean((abs_err_cos)))+"   Std="+str(np.std((abs_err_cos)))+"  cos rel mean error=   "+str(np.mean((rel_err_cos)))+"  Std="+str(np.std((rel_err_cos))))
Rdata.append("rsqrt abs mean error= "+str(np.mean((abs_err_rsqrt)))+"   Std="+str(np.std((abs_err_rsqrt)))+"  rsqrt rel mean error= "+str(np.mean((rel_err_rsqrt)))+"  Std="+str(np.std((rel_err_rsqrt))))
Rdata.append("log2 abs mean error=  "+str(np.mean((abs_err_log2)))+"   Std="+str(np.std((abs_err_log2)))+"  log2 rel mean error=  "+str(np.mean((rel_err_log2)))+"  Std="+str(np.std((rel_err_log2))))
Rdata.append("ex2 abs mean error=   "+str(np.mean((abs_err_ex2)))+"   Std="+str(np.std((abs_err_ex2)))+"  ex2 rel mean error=   "+str(np.mean((rel_err_ex2)))+"  Std="+str(np.std((rel_err_ex2))))
Rdata.append("rcp abs mean error=   "+str(np.mean((abs_err_rcp)))+"   Std="+str(np.std((abs_err_rcp)))+"  rcp rel mean error=   "+str(np.mean((rel_err_rcp)))+"  Std="+str(np.std((rel_err_rcp))))
Rdata.append("sqrt abs mean error=  "+str(np.mean((abs_err_sqrt)))+"   Std="+str(np.std((abs_err_sqrt)))+"  sqrt rel mean error=  "+str(np.mean((rel_err_sqrt)))+"  Std="+str(np.std((rel_err_sqrt))))

mf.write_files("./SFU_Input_data/Error_analysis.txt",Rdata)
print("\r\n\r\n\r\n\r\n\r\n")
#np.mean((rel_err_sin))
print(Rdata[0])
print(Rdata[1])
print(Rdata[2])
print(Rdata[3])
print(Rdata[4])
print(Rdata[5])
print(Rdata[6])