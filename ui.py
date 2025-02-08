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
        self.create_ui()

    def create_ui(self):  #Create UI elements including buttons and labels.
        # Message label
        self.message_label = tk.Label(self.window, text="Player X's turn", font=('Arial', 14), bg="#2C3E50", fg="white")
        self.message_label.grid(row=0, column=0, columnspan=3, pady=10)
        # Tic Tac Toe buttons (Grid)
        for row in range(3):
            for col in range(3):
                self.buttons[row][col] = tk.Button(self.window, text='', font=('Arial', 20), height=2, width=5,
                                                   bg="#ECF0F1", fg="black",
                                                   command=lambda r=row, c=col: self.on_click(r, c))
                self.buttons[row][col].grid(row=row+1, column=col, padx=5, pady=5)
        # Reset button
        self.reset_button = tk.Button(self.window, text="Reset", font=('Arial', 14), bg="#E74C3C", fg="white",
                                      command=self.reset_game)
        self.reset_button.grid(row=4, column=0, columnspan=3, pady=10)
