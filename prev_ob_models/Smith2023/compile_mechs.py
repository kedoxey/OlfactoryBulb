import os

# change directory to where mod mechanism files are located
os.chdir(f"{os.path.dirname(os.path.abspath(__file__))}/Mechanisms")

# compile mod files
os.system('nrnivmodl .')
