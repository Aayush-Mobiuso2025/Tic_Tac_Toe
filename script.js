const rows = 30;
const cols = 30;

let isRunning = false;
let interval;
let mainBoard; 

function initializeGame() {
  const gameBoard = document.getElementById("gameBoard");
  gameBoard.style.gridTemplateColumns = `repeat(${cols}, 1fr)`;
  mainBoard = Array.from({ length: rows }, () => Array(cols).fill(0));

  for (let row = 0; row < rows; row++) {
    for (let col = 0; col < cols; col++) {
      const cell = document.createElement("div");
      cell.classList.add("cell");
      cell.dataset.row = row;
      cell.dataset.col = col;

      cell.addEventListener("click", () => {
        mainBoard[row][col] = mainBoard[row][col] === 0 ? 1 : 0;
        cell.classList.toggle("alive", mainBoard[row][col] === 1);
      });
      gameBoard.appendChild(cell);
    }
  }
}


function countAliveNeighbors(row, col) {
  let aliveCount = 0;
  const directions = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 1],
    [1, -1], [1, 0], [1, 1],
  ];

  for (const [dx, dy] of directions) {
    const newRow = row + dx;
    const newCol = col + dy;

    if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
      aliveCount += mainBoard[newRow][newCol];
    }
  }
  return aliveCount;
}

function createNextGeneration() {
  const nextGeneration = Array.from({ length: rows }, () => Array(cols).fill(0));

  for (let row = 0; row < rows; row++) {
    for (let col = 0; col < cols; col++) {
      const aliveNeighbors = countAliveNeighbors(row, col);

      if (mainBoard[row][col] === 1) {
        nextGeneration[row][col] = aliveNeighbors === 2 || aliveNeighbors === 3 ? 1 : 0;
      } else {
        nextGeneration[row][col] = aliveNeighbors === 3 ? 1 : 0;
      }
    }
  }
  return nextGeneration;
}

function renderNextGeneration() {
  document.querySelectorAll(".cell").forEach((cell) => {
    const row = parseInt(cell.dataset.row);
    const col = parseInt(cell.dataset.col);
    cell.classList.toggle("alive", mainBoard[row][col] === 1);
  });
}

function startGame() {
  if (isRunning) return;
  isRunning = true;

  interval = setInterval(() => {
    mainBoard = createNextGeneration();
    renderNextGeneration();
  }, 300);
}

function pauseGame() {
  isRunning = false;
  clearInterval(interval);
}

function resetGame() {
  pauseGame();
  mainBoard = Array.from({ length: rows }, () => Array(cols).fill(0));
  renderNextGeneration();
}

document.getElementById("start").addEventListener("click", startGame);
document.getElementById("pause").addEventListener("click", pauseGame);
document.getElementById("reset").addEventListener("click", resetGame);

initializeGame();

