import numpy as np
import struct

def read_files(filename):
    file=open(filename,'r')
    data=[]
    for linea in file:
        data.append(linea) 
    file.close()
    return data
    
def write_files(filename,data):
    file=open(filename,'w')
    for data_index in data:
        file.write(data_index+'\n')
    file.close()

def float_to_hex(f):
    h=hex(struct.unpack('<I', struct.pack('<f', f))[0])
    return h[2:len(h)]


def hex_to_float(h):
    return np.float32(struct.unpack(">f",struct.pack(">I",int(h,16)))[0])


def float2hex(data):
    x=[]
    for dt in data:
        x.append(float_to_hex(dt))
    return x
    
def hex2float(data):
    x=[]
    for dt in data:
        x.append(hex_to_float(dt))
    return x

def range_reduction_aprox(data):
    K1=1.5703125
    K2=0.000483826792333
    C=0.63661975   
    out=[]
    aprox=[]
    angles=[]
    K=[]
    Q=[]
    Reduced=[]
    operation=[]
    real_function=[]
    for angle in data:
        f=np.float32(angle)
        m=np.float32(abs(f)*C)
        #m=m+np.float32(abs(f)*0.0038072722964)
        l=np.float32(np.floor(m))
        r=np.float32(abs(f) - (l*K1))
        r=np.float32(r-l*K2)
        N=[]
        N.append(l)
        
        for j in range(0,0):
            f=np.float32(r)
            m=np.float32(abs(f)*C)
            #m=m+np.float32(abs(f)*0.0038072722964)
            l=np.float32(np.floor(m))
            r=np.float32(abs(f) - (l*K1))
            r=np.float32(r-l*K2)
            N.append(l)
        
        #print(N)            
        j=0
        for dx in N:
            if (dx!=0):
                j=j+1
        #reduced=r
        if f<0:
            Reduced.append(-r) 
        else:
            Reduced.append(r) 
        Q.append((N[j-1]%4))            
        K.append(N[j-1])  
    
    return(Reduced,Q)
    '''   
        if (N[j-1]%4)==0:
            if op=='cos':
                fucntion=np.float32(np.cos(reduced))
            else:
                fucntion=np.float32(np.sin(reduced))
        elif (N[j-1]%4)==1:
            if op=='cos':
                fucntion=-np.float32(np.sin(reduced))
            else:
                fucntion=np.float32(np.cos(reduced))
        elif (N[j-1]%4)==2:
            if op=='cos':
                fucntion=-np.float32(np.cos(reduced))
            else:
                fucntion=-np.float32(np.sin(reduced))
        else:
            if op=='cos':
                fucntion=np.float32(np.sin(reduced))
            else:
                fucntion=-np.float32(np.cos(reduced))
                
        if angle<0:
            out.append(-reduced) 
            if op=='cos':
                fucntion=fucntion
            else:
                fucntion=-fucntion
        else:
            out.append(reduced)
            
            
        operation.append(fucntion)
        if op=='cos':
            real_function.append(np.float32(np.cos(np.float32(angle))))
        else:
            real_function.append(np.float32(np.sin(np.float32(angle))))
    '''    
    #return(out,data,real_function,operation)


def relative_error(real, actual):
    err=np.zeros(len(real))
    for i in range(0,len(real)-1):
        if real[i]==0:
            err[i]=np.absolute(((1+real[i])-(1+actual[i]))/(1+real[i]))
        else:
            err[i]=np.absolute((real[i]-actual[i])/real[i])
    #K=err.tolist()
    #write_files('./err.txt',K)
    #print(np.amax(err))
    return(err)