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

   def setup_ui(self):  #Sets up the UI components including buttons and labels.
        self.message_label = tk.Label(self.root, text="", font=("Arial", 12), wraplength=400)
        self.message_label.grid(row=0, column=0, columnspan=self.logic.board_size)

        # Create game grid buttons
        self.buttons = [[None for _ in range(self.logic.board_size)] for _ in range(self.logic.board_size)]
        for row in range(self.logic.board_size):
            for col in range(self.logic.board_size):
                button = tk.Button(self.root, text=" ", width=3, height=1,
                                   command=lambda r=row, c=col: self.on_click(r, c))
                button.grid(row=row + 1, column=col)
                self.buttons[row][col] = button

        # Turn and restart buttons
        self.turn_button = tk.Button(self.root, text="Change Turn", command=self.change_turn, state=tk.DISABLED)
        self.turn_button.grid(row=self.logic.board_size + 1, column=0, columnspan=5)

        self.restart_button = tk.Button(self.root, text="Restart Game", command=self.restart_game)
        self.restart_button.grid(row=self.logic.board_size + 1, column=5, columnspan=5)

        # Display ships placed and hit count
        self.info_label = tk.Label(self.root, text="Ships Placed: 0 | Ships Hit: 0", font=("Arial", 12))
        self.info_label.grid(row=self.logic.board_size + 2, column=0, columnspan=self.logic.board_size)
