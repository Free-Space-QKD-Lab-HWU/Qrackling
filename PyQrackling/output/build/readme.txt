PyQrackling MATLAB Python Package

1. Prerequisites for Deployment 

Verify that MATLAB Runtime(R2025a) is installed.   
If not, you can run the MATLAB Runtime installer.
To find its location, enter
  
    >>mcrinstaller
      
at the MATLAB prompt.
NOTE: You will need administrator rights to run the MATLAB Runtime installer. 

Alternatively, download and install the Windows version of the MATLAB Runtime for R2025a 
from the following link on the MathWorks website:

    https://www.mathworks.com/products/compiler/mcr/index.html
   
For more information about the MATLAB Runtime and the MATLAB Runtime installer, see 
"Distribute Applications" in the MATLAB Compiler SDK documentation  
in the MathWorks Documentation Center.

Verify that a Windows version of Python 3.9, 3.10, 3.11, and/or 3.12 is installed.

2. Installing the PyQrackling Package

A. Change to the directory that contains the file setup.py and the subdirectory 
PyQrackling. If you do not have write permissions, copy all its contents to a temporary 
location and change to that directory.

B. Execute the command:

    python -m pip install . [options]
   
If you have full administrator privileges, and install to the default location, you do 
not need to specify any options. Otherwise, use --user to install to your home folder, or 
--prefix="installdir" to install to "installdir". In the latter case, add "installdir" to 
the PYTHONPATH environment variable. For details, refer to:

    https://docs.python.org/3/installing/index.html


3. Using the PyQrackling Package

The PyQrackling package is on your Python path. To import it into a Python script or 
session, execute:

    import PyQrackling

If a namespace must be specified for the package, modify the import statement accordingly.
