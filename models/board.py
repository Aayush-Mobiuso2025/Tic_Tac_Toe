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

    def fire_at(self, row, col):  #Handles firing at a given coordinate.
        if self.board[row][col] == 'S':
            self.board[row][col] = 'H'
            self.hits += 1
            return "Hit"
        elif self.board[row][col] == ' ':
            self.board[row][col] = 'M'
            return "Miss"
        return "Already fired"

    def is_game_over(self):  #Checks if all ships have been hit.
        return self.hits == self.ships
