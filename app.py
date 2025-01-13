import tkinter as tk
from tkinter import messagebox


class GameBoard:
    def __init__(self, size=10):
        self.size = size
        self.board = [[' ' for _ in range(size)] for _ in range(size)]
        self.ships = []  

    def place_ship(self, row, col):
        if 0 <= row < self.size and 0 <= col < self.size:
            self.board[row][col] = 'S'
            self.ships.append((row, col))
        else:
            raise ValueError("Ship placement is out of bounds")

    def fire(self, row, col):
        if 0 <= row < self.size and 0 <= col < self.size:
            if self.board[row][col] == 'S':
                self.board[row][col] = 'H'  
                return True
            else:
                self.board[row][col] = 'M'  
                return False
        else:
            raise ValueError("Invalid firing coordinates")

    def is_game_over(self, player_ships):
        return len(player_ships) == 0


class Game:
    def __init__(self, root):
        self.root = root
        self.board = GameBoard()
        self.current_player = 1
        self.game_over = False
        self.buttons = []
        self.phase = "place_ships"  
        self.player1_ships = []  
        self.player2_ships = [] 
        self.create_gui()

    def create_gui(self):
        self.root.title("Battleship")
        self.create_game_buttons()
        self.create_message_label()

    def create_game_buttons(self):
        for row in range(self.board.size):
            button_row = []
            for col in range(self.board.size):
                button = tk.Button(self.root, text=" ", width=3, height=1,
                                   command=lambda r=row, c=col: self.handle_cell_click(r, c))
                button.grid(row=row, column=col)
                button_row.append(button)
            self.buttons.append(button_row)

    def create_message_label(self):
        self.message_label = tk.Label(self.root, text="Player 1, place your ships", font=('Helvetica', 14))
        self.message_label.grid(row=self.board.size, column=0, columnspan=self.board.size)

    def handle_cell_click(self, row, col):
        if self.game_over:
            return

        if self.phase == "place_ships":
            if self.current_player == 1 and len(self.player1_ships) < 5:
                self.board.place_ship(row, col)
                self.player1_ships.append((row, col))
                self.update_board()

                if len(self.player1_ships) == 5:
                    self.change_turn()
            elif self.current_player == 2 and len(self.player2_ships) < 5:
                self.board.place_ship(row, col)
                self.player2_ships.append((row, col))
                self.update_board()

                if len(self.player2_ships) == 5:
                    self.change_turn()

        elif self.phase == "play":
            if self.board.board[row][col] in ('M', 'H'):
                return  

            if self.current_player == 1:
                hit = self.board.fire(row, col)
                if hit:
                    self.update_message("Player 1 hit!")
                    self.player2_ships = [ship for ship in self.player2_ships if ship != (row, col)]
                else:
                    self.update_message("Player 1 missed.")
                self.check_game_over()
                self.current_player = 2
            else:
                hit = self.board.fire(row, col)
                if hit:
                    self.update_message("Player 2 hit!")
                    self.player1_ships = [ship for ship in self.player1_ships if ship != (row, col)]
                else:
                    self.update_message("Player 2 missed.")
                self.check_game_over()
                self.current_player = 1

            self.update_board()

    def change_turn(self):
        if self.current_player == 1:
            self.update_message("Player 2, place your ships")
        elif self.current_player == 2:
            self.update_message("Now the game begins. Player 1's turn.")
            self.phase = "play"
        self.current_player = 3 - self.current_player  

    def update_message(self, message):
        self.message_label.config(text=message)

    def update_board(self):
        for row in range(self.board.size):
            for col in range(self.board.size):
                button = self.buttons[row][col]
                state = self.board.board[row][col]
                if state == 'S':
                    button.config(text=" ", bg="white")
                elif state == 'M':
                    button.config(text="M", bg="gray")
                elif state == 'H':
                    button.config(text="H", bg="red")

    def check_game_over(self):
        if not self.player1_ships:  
            self.game_over = True
            self.update_message("Player 2 wins!")
            messagebox.showinfo("Game Over", "Player 2 wins!")
        elif not self.player2_ships:  
            self.game_over = True
            self.update_message("Player 1 wins!")
            messagebox.showinfo("Game Over", "Player 1 wins!")

if __name__ == "__main__":
    root = tk.Tk()
    game = Game(root)
    root.mainloop()
