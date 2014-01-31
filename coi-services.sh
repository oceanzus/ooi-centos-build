mkdir ooi
virtualenv-2.7 --no-site-packages ooi
source ooi/bin/activate
pip install numpy
git clone https://github.com/ooici/coi-services.git
cd coi-services/
git submodule update --init
python bootstrap.py -v 2.2.0
export C_INCLUDE_PATH=/usr/include/udunits2:$C_INCLUDE_PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
bin/buildout
bin/generate_interfaces
#bin/pycc --rel res/deploy/r2deploy.yml -fc -s brian
