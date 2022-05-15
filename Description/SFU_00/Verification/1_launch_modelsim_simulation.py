import os
import subprocess
import winsound

print("Executing...\n2_Generate_input_data.py\n")
os.system("2_Generate_input_data.py 1")

File_path = os.getcwd()
command = "C:/altera/13.0sp1/modelsim_ase/win32aloem/vsim.exe -c -do "+File_path+"/testbench.tcl"
print("Executing...\n"+command+"\n")
os.system(command)

print("Executing...\n3_Verification_results.py\n")
os.system("3_Verification_results.py 1")

winsound.MessageBeep()
input ("Press Enter to Finish...")
