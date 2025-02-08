class GameLogic:
    def __init__(self):  #Initialize the game board and the starting player.
        self.board = [[None] * 3 for _ in range(3)]
        self.current_player = 'X'

    def make_move(self, row, col):   #Attempts to make a move at the specified row and column.
        if self.board[row][col] is None:
            self.board[row][col] = self.current_player  # Set the move  
            # Check for a winner or draw
            if self.check_winner():
                return f"Player {self.current_player} wins!"
            elif all(cell is not None for row in self.board for cell in row):
                return "It's a draw!"
            # Switch player
            self.current_player = 'O' if self.current_player == 'X' else 'X'
        return None

