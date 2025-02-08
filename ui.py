import tkinter as tk
from tkinter import messagebox
from src.game_logic import GameLogic

class TicTacToeUI:
    def __init__(self):  #Initialize the game window and UI components.
        self.window = tk.Tk()
        self.window.title("Tic Tac Toe")
        self.window.configure(bg="#2C3E50")  # Dark background
        self.game = GameLogic()
        self.buttons = [[None] * 3 for _ in range(3)]
