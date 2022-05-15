import random
import myFunctions as mf
import numpy as np
import matplotlib.pyplot as plt
import os
import subprocess

File_path = os.getcwd()
command = "C:/altera/13.0sp1/modelsim_ase/win32aloem/vsim.exe -view "+File_path+"/vsim.wlf -do wave.do"
print(command)
os.system(command)
