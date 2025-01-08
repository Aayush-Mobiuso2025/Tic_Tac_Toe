const rows = 30; 
const cols = 30; 
let currentGrid = Array.from({ length: rows }, () => Array(cols).fill(0)); 
let isRunning = false; 
let interval; 


function createGrid() {
  const grid = document.getElementById("grid");
  grid.style.gridTemplateColumns = `repeat(${cols}, 1fr)`;
  grid.innerHTML = ""; 

  for (let row = 0; row < rows; row++) {
    for (let col = 0; col < cols; col++) {
      const cell = document.createElement("div");
      cell.classList.add("cell");
      cell.dataset.row = row;
      cell.dataset.col = col;

      
      cell.addEventListener("click", () => {
        currentGrid[row][col] = currentGrid[row][col] === 0 ? 1 : 0;
        cell.classList.toggle("alive", currentGrid[row][col] === 1);
      });

      grid.appendChild(cell);
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
      aliveCount += currentGrid[newRow][newCol];
    }
  }

  return aliveCount;
}


function getNextGrid() {
  const nextGrid = Array.from({ length: rows }, () => Array(cols).fill(0));

  for (let row = 0; row < rows; row++) {
    for (let col = 0; col < cols; col++) {
      const aliveNeighbors = countAliveNeighbors(row, col);

      if (currentGrid[row][col] === 1) {
        nextGrid[row][col] = aliveNeighbors === 2 || aliveNeighbors === 3 ? 1 : 0;
      } else {
        nextGrid[row][col] = aliveNeighbors === 3 ? 1 : 0;
      }
    }
  }

  return nextGrid;
}

function updateGrid() {
  document.querySelectorAll(".cell").forEach((cell) => {
    const row = parseInt(cell.dataset.row);
    const col = parseInt(cell.dataset.col);
    cell.classList.toggle("alive", currentGrid[row][col] === 1);
  });
}

function startGame() {
  if (isRunning) return; 
  isRunning = true;

  interval = setInterval(() => {
    currentGrid = getNextGrid();
    updateGrid();
  }, 300); 
}


function pauseGame() {
  isRunning = false;
  clearInterval(interval);
}


function resetGame() {
  pauseGame();
  currentGrid = Array.from({ length: rows }, () => Array(cols).fill(0));
  updateGrid();
}

document.getElementById("start").addEventListener("click", startGame);
document.getElementById("pause").addEventListener("click", pauseGame);
document.getElementById("reset").addEventListener("click", resetGame);
createGrid();
