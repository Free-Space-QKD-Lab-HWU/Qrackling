# Copyright 2015-2024 The MathWorks, Inc.
import sys
import warnings
from shutil import rmtree
from os.path import exists

use_build_msg = '.*Use build and pip and other standards-based tools.*'
excTxt = ''

if 'bdist_wheel' in sys.argv[1:]:
    # If "python setup.py bdist_wheel" is executed, we need to 
    # import from setuptools.
    warnings.filterwarnings('ignore', message=use_build_msg)
    from setuptools import setup
    from setuptools.command.install import install
    try:
        import wheel
    except Exception as exc:
        excTxt = '{}'.format(exc)

if excTxt:
    print("bdist_wheel requires the 'wheel' module, which can be installed via 'python -m pip install wheel'")
    raise ModuleNotFoundError(excTxt)

firstExceptionMessage = ''
secondExceptionMessage = ''

try:
    from setuptools import setup
    from setuptools.command.install import install
except Exception as firstE:
    firstExceptionMessage = str(firstE)

if firstExceptionMessage:
    try:
        # We suppress warnings about deprecation of distutils. If neither is found,
        # we will only mention setuptools, which is the one that should be used.
        warnings.filterwarnings('ignore', message='.*distutils package is deprecated.*', 
            category=DeprecationWarning)
        from distutils.core import setup
        from distutils.command.install import install
    except Exception as secondE:
        secondExceptionMessage = str(secondE)

if secondExceptionMessage:
    raise EnvironmentError("Installation failed. Install setuptools using 'python -m pip install setuptools', then try again.")

class InstallAndCleanBuildArea(install):
    # Directories with these names are created during installation, but are 
    # not needed afterward (unless bdist_wheel is being executed, in which 
    # case we skip this step).
    clean_dirs = ["./build", "./dist"]

    def clean_up(self):
        for dir in self.clean_dirs:
            if exists(dir):
                rmtree(dir, ignore_errors=True) 

    def run(self):
        install.run(self)
        self.clean_up()
    
if __name__ == '__main__':
    setup_dict = {
        'name': 'PyQrackling-R2025a',
        'version': '25.1',
        'description': 'A Python interface to PyQrackling',
        'author': 'MathWorks',
        'url': 'https://www.mathworks.com/',
        'platforms': ['Linux', 'Windows', 'macOS'],
        'packages': [
            'PyQrackling'
        ],
        'package_data': {'PyQrackling': ['*.ctf']}
    }
    
    if not 'bdist_wheel' in sys.argv[1:]:
        setup_dict['cmdclass'] = {'install': InstallAndCleanBuildArea}
    
    setup(**setup_dict)


