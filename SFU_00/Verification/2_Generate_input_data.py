import random
import myFunctions as mf
import numpy as np
import matplotlib.pyplot as plt
import os
import subprocess
from datetime import datetime

now = datetime.now()
 
dir_name_result = "SFU_Input_data_"+now.strftime("%d_%m_%Y_%H_%M_%S")

current_path=os.getcwd()
os.system("Xcopy /E /I SFU_Input_data"+" "+dir_name_result)

os.system("rmdir /s /q SFU_Input_data")
os.system("mkdir SFU_Input_data")


N_DATA=20000

sin_ran_dat=np.sort(np.float32(np.pi*np.random.uniform(-47.0,47.0,N_DATA)))
cos_ran_dat=np.sort(np.float32(np.pi*np.random.uniform(-47.0,47.0,N_DATA)))
rsqrt_ran_dat=np.sort(np.float32(np.random.uniform(0.0,47.0,N_DATA)))
log2_ran_dat=np.sort(np.float32(np.random.uniform(0.0,47.0,N_DATA)))
exp2_ran_dat=np.sort(np.float32(np.random.uniform(-47.0,47.0,N_DATA)))
rcp_ran_dat=np.sort(np.float32(np.random.uniform(-47.0,47.0,N_DATA)))
sqrt_ran_dat=np.sort(np.float32(np.random.uniform(0.0,47.0,N_DATA)))

#plt.plot(sqrt_ran_dat)
#plt.show()


# random data generation for sine operation test of SFU
Special_conditions=[]
Special_conditions.append("ffffffff") #NAN
Special_conditions.append("ff800000") #-inf
Special_conditions.append("80000001") #-subnorm
Special_conditions.append("80000000") #-0
Special_conditions.append("00000000") #+0
Special_conditions.append("00000001") #+subnorm
Special_conditions.append("7f800000") #+inf
Special_conditions.append("7fffffff") #NAN

X=[]
X.extend(Special_conditions)
X.extend(mf.float2hex(sin_ran_dat))
X.insert(0,"celldata")
mf.write_files("./SFU_Input_data/input_sin.csv",X)

X.clear()
X.extend(Special_conditions)
X.extend(mf.float2hex(cos_ran_dat))
X.insert(0,"celldata")
mf.write_files("./SFU_Input_data/input_cos.csv",X)

X.clear()
X.extend(Special_conditions)
X.extend(mf.float2hex(rsqrt_ran_dat))
X.insert(0,"celldata")
mf.write_files("./SFU_Input_data/input_rsqrt.csv",X)

X.clear()
X.extend(Special_conditions)
X.extend(mf.float2hex(log2_ran_dat))
X.insert(0,"celldata")
mf.write_files("./SFU_Input_data/input_log2.csv",X)

X.clear()
X.extend(Special_conditions)
X.extend(mf.float2hex(exp2_ran_dat))
X.insert(0,"celldata")
mf.write_files("./SFU_Input_data/input_ex2.csv",X)

X.clear()
X.extend(Special_conditions)
X.extend(mf.float2hex(rcp_ran_dat))
X.insert(0,"celldata")
mf.write_files("./SFU_Input_data/input_rcp.csv",X)

X.clear()
X.extend(Special_conditions)
X.extend(mf.float2hex(sqrt_ran_dat))
X.insert(0,"celldata")
mf.write_files("./SFU_Input_data/input_sqrt.csv",X)

print("data generated sucessfully....\r\n")
