Visualization frontend for neuroNER
========

Author: renaud.richardet@epfl.ch



### Installation

* Python 2.7 with Canopy (see [https://www.enthought.com/downloads/])

    wget https://www.enthought.com/downloads/canopy/rh5-64/free/ -O canopy.sh
    bash canopy.sh (then follow the instructions)
    ./Canopy/canopy --no-gui-setup
    echo 'export PATH=/home/XXXXX/Enthought/Canopy_64bit/User/bin:$PATH' >> .bashrc
    touch .bashrc (better: log out / in)
    echo $PATH
    which python (should give Enthought's python)
    enpkg ipython pandas matplotlib scipy

* MySQL server (5.5 or higher)
* Python dependencies
    * pip install pymysql
    * pip install simplejson
    * pip install tornado

* install database from zip in db/ folder
* configure connection details in config.json

### Start

    python server.py
    then browse to port 8875
