from models.board import Board

class GameLogic:   #Handles game mechanics, including turns, ship placements, and firing.

    def __init__(self, board_size=10, max_ships=5):
        self.board_size = board_size
        self.max_ships = max_ships
        self.board = Board(self.board_size)
        self.phase = "placing"
        self.ships_placed = 0

    def place_ship(self, row, col):   #Places a ship if possible.
        if self.ships_placed < self.max_ships:
            self.board.place_ship(row, col)
            self.ships_placed += 1
            return True
        return False

    def fire_at(self, row, col):  #Handles firing logic and returns the result.
        return self.board.fire_at(row, col)

    def is_game_over(self):  #Checks if the game is over.
        return self.board.is_game_over()

    def reset_game(self):  #Resets the board and game state.
        self.board.reset_board()
        self.ships_placed = 0
        self.phase = "placing"
