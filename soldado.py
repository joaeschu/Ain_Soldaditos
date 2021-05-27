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


class comandante(BDITroop):
    def add_custom_actions(self, actions):
        super().add_custom_actions(actions)
        
    #funcion para eliminar un elemento de una lista
    @actions.add_function(".quitar", (int, tuple))
    def _quitar(i, l):
        #si estuviese en medio, se concatenan 2 listas, sin el elemento n? i
        if (i!=0) and (i!=(len(l)-1)):
            return tuple(l[0:i] + l[i+1:])
            
        #si esta al principio, se quita el 1er elemento
        if i == 0:
            return l[1:]
            
        #si esta al final, solo se quita el ultimo
        elif i == (len(l) - 1):
            return l[:i]
            
    #funcion para calcular las posiciones de los defensores
    @actions.add_function(".pDefensiva", (tuple))
    def _pDefensiva(posBan):
       
       #Vamos a calcular cuatro posiciones alrededor de la bandera. 
       #Tienen que estar a una distancia entre ellos que les permita tener un buen rango de visi?n y acudir en ayuda del otro r?pidamente.
       #Si hay muros y no se puede estar a la distancia idea, esta se reducir?.
       
        fX, fY, fZ = posBan
        
        #Distancia base entre soldados
        dist = 25
        
        # Posicion arriba a la izquierda
        i = 0
        x = fX - dist
        z = fZ + dist
        while not self.map.can_walk(x,z):
            x = fX - dist + i
            z = fZ + dist - i
            i += 1
        pos1 = (x, 0, z)    

        i = 0
        # Posicion arriba a la derecha
        x = fX + dist
        z = fZ + dist
        while not self.map.can_walk(x,z):
            x = fX + dist - i
            z = fZ + dist - i
            i += 1
        pos2 = (x, 0, z) 

        i = 0
        # Posicion abajo a la izquierda
        x = fX - dist
        z = fZ - dist
        while not self.map.can_walk(x,z):
            x = fX - dist + i
            z = fZ - dist + i
            i += 1
        pos4 = (x, 0, z) 

        i = 0
        # Posicion abajo a la derecha
        x = fX + dist
        z = fZ - dist
        while not self.map.can_walk(x,z):
            x = fX + dist - i
            z = fZ - dist + i
            i += 1
        pos3 = (x, 0, z) 

        return (pos1, pos2, pos3, pos4)
        