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
