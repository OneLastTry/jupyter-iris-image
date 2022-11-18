FROM jupyter/minimal-notebook:latest

## deploy iris module
COPY iris-py/intersystems_irispython-3.2.0-py3-none-any.whl /tmp/.
COPY iris-py/*.ipynb /home/jovyan/work/.
WORKDIR /tmp
RUN pip install intersystems_irispython-3.2.0-py3-none-any.whl

## install things I'm not sure are necessary
WORKDIR /home/jovyan
RUN pip install matplotlib
RUN pip install pandas
RUN pip install xmltodict

## define default password
RUN pip install ipython==7.9
RUN echo "c.NotebookApp.password='$(python3 -c "from IPython.lib.security import passwd; print(passwd(passphrase='admin', algorithm='sha1'))")'" >> ~/.jupyter/jupyter_notebook_config.py
RUN pip uninstall ipython -y
RUN pip install ipython==8.6.0