# Never Again forget how to set-up a `python` virtual environment and use it with `jupyter-notebook`

- `python3 -m venv tensorflow` Create the venv.
- `source ./tensorflow/bin/activate` Activate it. All packages from now on are now local.
  + If you want to go out of environment type `deactivate`.
- `pip install ipykernel` Install the ipykernel module to have a kernel available for this venv.
- `python -m ipykernel install --user --name=tensorflow` Install the kernel globally *(--user)* so that jupyter can detect it.
- `pip install tensorflow` Enjoy installing big packages without messing up your system. =)
