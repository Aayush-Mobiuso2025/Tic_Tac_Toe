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


   def on_click(self, row, col):   #Handles button clicks and updates the game board.
        if self.buttons[row][col]['text'] == '':  # Ensure cell is empty
            current_player = self.game.current_player  # Store player before move
            message = self.game.make_move(row, col)  # Execute move
            # Update button with the correct player's symbol and color
            self.buttons[row][col].config(text=current_player, fg=("#3498DB" if current_player == 'X' else "#E74C3C"))

            if message:  # If there's a winner or a draw
                self.message_label.config(text=message)
                messagebox.showinfo("Game Over", message)
                self.reset_game()
            else:
                self.message_label.config(text=f"Player {self.game.current_player}'s turn")

    def reset_game(self):   #Resets the game board and UI.
        self.game.reset_game()
        self.message_label.config(text="Player X's turn")
        for row in range(3):
            for col in range(3):
                self.buttons[row][col].config(text='', fg="black", bg="#ECF0F1")

    def run(self):
        self.window.mainloop()

