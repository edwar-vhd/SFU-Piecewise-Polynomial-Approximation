# SFU - Piecewise Polynomial Approximation

Special Function Units (SFUs) are hardware accelerators, their implementation helps improve the performance of GPUs to process some of the most complex operations. This SFU implements the Piecewise Polynomial Approximation, which provides high performance, low area costs and good accuracy for real implementation of hardware.

The SFU can also be integrated and used as a stand-alone accelerator or coprocessor in a processor-based system.

Please feel free to use.

The SFU can operate input values in the floating-point format IEEE-754 and the supported functions are:

Sin function: sin(x)
Cos function: cos(x)
Binary log: log_2(x)
Reciprocal: 1/x
Square root: √x
Reciprocal of the square root: 1/√x
Power of 2: 2^x.
The model was checked in the simulation environments: ModelSim-Altera Starter Edition and Octave (golden model).

The model was synthetized in the DE2-115 FPGA platform by Intel-Altera.

This module was developed by the Robotics and Industrial Automation (GIRA) Research group in Universidad Pedagogica y Tecnologica de Colombia (UPTC), in the Electronics Engineering School. Sogamoso-Tunja, Colombia in cooperation with CAD group in Politecnico di Torino, Turin, Italy.

Authors{email}:
Edwar Javier Patiño Núñez {edward.patino@uptc.edu.co}
Juan David Guerrero Balaguera {juandavid.guerrero@polito.it}
Josie Esteban Rodriguez Condia {josie.rodriguez@polito.it}
