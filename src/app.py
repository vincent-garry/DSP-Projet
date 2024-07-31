import os
from flask import Flask, render_template, jsonify, request
import numpy as np

# Ensure we're in the correct directory
os.chdir(os.path.dirname(os.path.abspath(__file__)))

app = Flask(__name__)

class TicTacToe:
    def __init__(self):
        self.board = np.zeros((3, 3), dtype=int)
        self.player_turn = 1  # 1 for X, -1 for O
        self.game_over = False
        self.winner = None

    def make_move(self, row, col):
        if self.board[row][col] == 0 and not self.game_over:
            self.board[row][col] = self.player_turn
            if self.check_winner(row, col):
                self.game_over = True
                self.winner = 'X' if self.player_turn == 1 else 'O'
            elif np.all(self.board != 0):
                self.game_over = True
                self.winner = 'Tie'
            else:
                self.player_turn *= -1
            return True
        return False

    def check_winner(self, row, col):
        # Check row
        if np.all(self.board[row] == self.player_turn):
            return True
        # Check column
        if np.all(self.board[:, col] == self.player_turn):
            return True
        # Check diagonals
        if row == col and np.all(np.diag(self.board) == self.player_turn):
            return True
        if row + col == 2 and np.all(np.diag(np.fliplr(self.board)) == self.player_turn):
            return True
        return False

    def get_state(self):
        return {
            'board': self.board.tolist(),
            'player_turn': 'X' if self.player_turn == 1 else 'O',
            'game_over': self.game_over,
            'winner': self.winner
        }

game = TicTacToe()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/game_state')
def game_state():
    return jsonify(game.get_state())

@app.route('/make_move', methods=['POST'])
def make_move():
    data = request.json
    row, col = data['row'], data['col']
    if game.make_move(row, col):
        return jsonify(game.get_state())
    return jsonify({'error': 'Invalid move'}), 400

@app.route('/reset_game', methods=['POST'])
def reset_game():
    global game
    game = TicTacToe()
    return jsonify(game.get_state())

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')