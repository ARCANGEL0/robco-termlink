import fallout as fall
import os

dir = os.path.realpath(os.path.join(
    os.getcwd(), os.path.dirname(__file__)))  # pega o diretorio do arquivo

### iniciar
if fall.iniciar():
    senha = fall.login()
    if senha != None:
        print(fall.menu())
    else:
        fall.bloquearTela()
