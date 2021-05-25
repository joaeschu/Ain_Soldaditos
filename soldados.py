import json
import math
import random
import sys
import pygomas
from pygomas.map import TerrainMap
from loguru import logger
from spade.behaviour import OneShotBehaviour
from spade.template import Template
from spade.message import Message
from pygomas.bditroop import BDITroop
from pygomas.bdisoldier import BDISoldier
from pygomas.bdimedic import BDIMedic
from pygomas.bdifieldop import BDIFieldOp
from agentspeak import Actions
from agentspeak import grounded
from agentspeak.stdlib import actions
from pygomas.ontology import HEALTH

from pygomas.agent import LONG_RECEIVE_WAIT


class BDIGeneral(BDITroop):
    def add_custom_actions(self, actions):
        super().add_custom_actions(actions)
        
    #funcion para eliminar un elemento de una lista
    @actions.add_function(".quitar", (int, tuple))
    def _quitar(i, l):
        #si estuviese en medio, se concatenan 2 listas, sin el elemento nº i
        if (i!=0) and (i!=(len(l)-1)):
            return tuple(l[0:i] + l[i+1:])
            
        #si esta al principio, se quita el 1er elemento
        if i == 0:
            return l[1:]
            
        #si esta al final, solo se quita el ultimo
        elif i == (len(l) - 1):
            return l[:i]
    
        
        

    


class SoldadoPropio(BDISoldier):
    def add_custom_actions(self, actions):
        super().add_custom_actions(actions)
