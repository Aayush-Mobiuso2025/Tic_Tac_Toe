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


    def on_click(self, row, col):  #Handles user click based on game phase.
        if not self.is_player2_turn:  # Player 1 placing ships
            if self.logic.place_ship(row, col):
                self.update_board()
                remaining_ships = self.logic.max_ships - self.logic.ships_placed
                self.update_message(Messages.PLACE_SHIPS.format(remaining_ships))
                self.update_ship_count()
                if self.logic.ships_placed == self.logic.max_ships:
                    self.turn_button.config(state=tk.NORMAL)

        elif self.is_player2_turn:  # Player 2 firing at Player 1
            result = self.logic.fire_at(row, col)
            self.update_board()
            self.update_message(f"Player 2: {result}")
            self.update_ship_count()
            if self.logic.is_game_over():
                self.update_message(Messages.GAME_OVER)
                messagebox.showinfo("Game Over", "Player 2 Wins!")

    def change_turn(self):  #Changes the turn from Player 1 to Player 2.
        self.is_player2_turn = True
        self.update_message(Messages.PLAYER2_FIRE)
        self.turn_button.config(state=tk.DISABLED)
        self.update_board()


   def restart_game(self):  #Restarts the game, resetting the board and UI.
        self.logic.reset_game()
        self.is_player2_turn = False
        self.update_board()
        self.update_message(Messages.PLACE_SHIPS.format(self.logic.max_ships))
        self.turn_button.config(state=tk.DISABLED)
        self.update_ship_count()

    def update_board(self):  #Updates button colors and text based on game state.
        for row in range(self.logic.board_size):
            for col in range(self.logic.board_size):
                button = self.buttons[row][col]
                state = self.logic.board.board[row][col]

                if not self.is_player2_turn:  # Player 1's turn - ships visible
                    if state == 'S':
                        button.config(text="S", bg="blue")  # Show placed ships
                    else:
                        button.config(text=" ", bg="white")  # Empty spaces

                else:  # Player 2's turn - hide Player 1's ships
                    if state == 'H':
                        button.config(text="H", bg="red")  # Hit
                    elif state == 'M':
                        button.config(text="M", bg="gray")  # Miss
                    else:
                        button.config(text=" ", bg="white")  # Hide ships



