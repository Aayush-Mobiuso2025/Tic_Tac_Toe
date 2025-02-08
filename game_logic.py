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

def check_winner(self):  #Check rows, columns, and diagonals for a winner.
        for i in range(3):
            # Check rows and columns
            if self.board[i][0] == self.board[i][1] == self.board[i][2] and self.board[i][0]:
                return True
            if self.board[0][i] == self.board[1][i] == self.board[2][i] and self.board[0][i]:
                return True
        # Check diagonals
        if self.board[0][0] == self.board[1][1] == self.board[2][2] and self.board[0][0]:
            return True
        if self.board[0][2] == self.board[1][1] == self.board[2][0] and self.board[0][2]:
            return True
        return False

    def reset_game(self):  #Reset the board and start again with player X.
        self.board = [[None] * 3 for _ in range(3)]
        self.current_player = 'X'
