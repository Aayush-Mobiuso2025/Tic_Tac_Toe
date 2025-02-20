class Board:   #Handles board representation, ship placement, and firing mechanics.
    def __init__(self, size):
        self.size = size
        self.reset_board()

    def reset_board(self):   #Resets the board, clearing ships and hits.
        self.board = [[' ' for _ in range(self.size)] for _ in range(self.size)]
        self.ships = 0
        self.hits = 0

    def place_ship(self, row, col):  #Places a ship at the given coordinates.
        if self.board[row][col] == ' ':
            self.board[row][col] = 'S'
            self.ships += 1
        else:
            raise ValueError("Ship already placed here.")
