import tkinter as tk
from tkinter import messagebox
from services.game_logic import GameLogic
from config.messages import Messages

class GameUI:   #Handles the graphical user interface of the Battleship Game.
    def __init__(self, root):
        self.root = root
        self.root.title("Battleship Game")
        self.logic = GameLogic()
        self.is_player2_turn = False  # Track player turn
        self.setup_ui()
        self.update_message(Messages.PLACE_SHIPS.format(self.logic.max_ships))
