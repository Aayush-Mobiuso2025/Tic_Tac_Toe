import tkinter as tk
from tkinter import messagebox

class GameBoard:
    def __init__(self, size):
        self.size = size
        self.reset_board()

    def reset_board(self):
        self.board = [[' ' for _ in range(self.size)] for _ in range(self.size)]
        self.ships = 0
        self.hits = 0

    def place_ship(self, row, col):
        if self.board[row][col] == ' ':
            self.board[row][col] = 'S'
            self.ships += 1
        else:
            raise ValueError("Ship already placed here.")

    def fire_at(self, row, col):
        if self.board[row][col] == 'S':
            self.board[row][col] = 'H'
            self.hits += 1
            return "Hit"
        elif self.board[row][col] == ' ':
            self.board[row][col] = 'M'
            return "Miss"
        else:
            return "Already fired"

    def is_game_over(self):
        return self.hits == self.ships


class BattleshipGame:
    def __init__(self, root):
        self.root = root
        self.root.title("Battleship Game")
        self.board_size = 10
        self.board = GameBoard(self.board_size)
        self.phase = "placing"  # Either "placing" or "firing"
        self.max_ships = 5
        self.ships_placed = 0
        self.setup_game_interface()
        self.update_message("Player 1: Place your ships (5 remaining).")

    def setup_game_interface(self):
        self.message_label = tk.Label(self.root, text="", font=("Arial", 14))
        self.message_label.grid(row=0, column=0, columnspan=self.board_size)

        self.buttons = [[None for _ in range(self.board_size)] for _ in range(self.board_size)]
        for row in range(self.board_size):
            for col in range(self.board_size):
                button = tk.Button(self.root, text=" ", width=3, height=1,
                                   command=lambda r=row, c=col: self.handle_button_click(r, c))
                button.grid(row=row + 1, column=col)
                self.buttons[row][col] = button

        self.turn_button = tk.Button(self.root, text="Change Turn", command=self.change_turn, state=tk.DISABLED)
        self.turn_button.grid(row=self.board_size + 1, column=0, columnspan=self.board_size // 2)

        self.restart_button = tk.Button(self.root, text="Restart Game", command=self.restart_game)
        self.restart_button.grid(row=self.board_size + 1, column=self.board_size // 2, columnspan=self.board_size // 2)

        self.info_label = tk.Label(self.root, text="Ships Placed: 0 | Ships Hit: 0", font=("Arial", 12))
        self.info_label.grid(row=self.board_size + 2, column=0, columnspan=self.board_size)

    def handle_button_click(self, row, col):
        if self.phase == "placing":
            try:
                if self.ships_placed < self.max_ships:
                    self.board.place_ship(row, col)
                    self.ships_placed += 1
                    ships_remaining = self.max_ships - self.ships_placed
                    self.update_message(f"Player 1: Place your ships ({ships_remaining} remaining).")
                    self.update_board()

                    if self.ships_placed == self.max_ships:
                        self.turn_button.config(state=tk.NORMAL)
                        self.update_message("All ships placed! Press 'Change Turn' to continue.")
                else:
                    self.update_message("All ships have been placed. Press 'Change Turn' to proceed.")
            except ValueError as e:
                self.update_message(str(e))

        elif self.phase == "firing":
            result = self.board.fire_at(row, col)
            self.update_message(f"Player 2: {result}.")
            self.update_board()

            if self.board.is_game_over():
                self.update_message("Game Over! Player 2 Wins!")
                messagebox.showinfo("Game Over", "Player 2 Wins!")
                self.disable_all_buttons()

        self.update_info()

    def change_turn(self):
        if self.phase == "placing":
            self.phase = "firing"
            self.update_message("Player 2: Fire at Player 1's board.")
            self.turn_button.config(state=tk.DISABLED)
            self.update_board()

    def restart_game(self):
        self.board.reset_board()
        self.phase = "placing"
        self.ships_placed = 0
        self.update_message("Player 1: Place your ships (5 remaining).")
        self.update_board()
        self.update_info()

        for row in self.buttons:
            for button in row:
                button.config(state=tk.NORMAL, text=" ", bg="white")

        self.turn_button.config(state=tk.DISABLED)

    def update_board(self):
        for row in range(self.board.size):
            for col in range(self.board.size):
                button = self.buttons[row][col]
                state = self.board.board[row][col]

                if self.phase == "placing":
                    if state == 'S':
                        button.config(text="S", bg="blue")
                    else:
                        button.config(text=" ", bg="white")
                elif self.phase == "firing":
                    if state == 'H':
                        button.config(text="H", bg="red")
                    elif state == 'M':
                        button.config(text="M", bg="gray")
                    else:
                        button.config(text=" ", bg="white")

    def update_message(self, message):
        self.message_label.config(text=message)

    def update_info(self):
        self.info_label.config(text=f"Ships Placed: {self.ships_placed} | Ships Hit: {self.board.hits}")

    def disable_all_buttons(self):
        for row in self.buttons:
            for button in row:
                button.config(state=tk.DISABLED)

def main():
    root = tk.Tk()
    game = BattleshipGame(root)
    root.mainloop()

if __name__ == "__main__":
    main()


