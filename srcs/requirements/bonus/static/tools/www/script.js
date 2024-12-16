document.addEventListener('DOMContentLoaded', (event) => {
    const buttonContainer = document.getElementById('buttonContainer');
    let turn = 0; // Variabile per tenere traccia del turno corrente
    const grid = [
        ['', '', ''],
        ['', '', ''],
        ['', '', '']
    ];

    // Creare una griglia di pulsanti 3x3
    for (let i = 0; i < 3; i++) {
        const row = document.createElement('div');
        row.style.display = 'flex';
        for (let j = 0; j < 3; j++) {
            const button = document.createElement('button');
            button.style.width = '50px';
            button.style.height = '50px';
            button.style.margin = '5px';
            button.addEventListener('click', () => {
                onButtonClick(button, i, j);
            });
            row.appendChild(button);
        }
        buttonContainer.appendChild(row);
    }

    function onButtonClick(button, i, j) {
        let player = currentTurn();
        button.textContent = player;
        button.disabled = true; // Disabilita il pulsante dopo il clic
        grid[i][j] = player;
        turn++; // Incrementa il turno dopo aver aggiornato la griglia
        setTimeout(() => {
            if (checkWinner(player)) {
                alert(`${player} ha vinto!`);
                resetGame();
            } else if (turn === 9) {
                alert('Pareggio!');
                resetGame();
            }
        }, 100); // Ritarda l'alert di 100 millisecondi
    }

    function currentTurn() {
        return turn % 2 === 0 ? 'X' : 'O';
    }

    function checkWinner(player) {
        // Controlla righe
        for (let i = 0; i < 3; i++) {
            if (grid[i][0] === player && grid[i][1] === player && grid[i][2] === player) {
                return true;
            }
        }
        // Controlla colonne
        for (let j = 0; j < 3; j++) {
            if (grid[0][j] === player && grid[1][j] === player && grid[2][j] === player) {
                return true;
            }
        }
        // Controlla diagonali
        if (grid[0][0] === player && grid[1][1] === player && grid[2][2] === player) {
            return true;
        }
        if (grid[0][2] === player && grid[1][1] === player && grid[2][0] === player) {
            return true;
        }
        return false;
    }

    function resetGame() {
        turn = 0;
        for (let i = 0; i < 3; i++) {
            for (let j = 0; j < 3; j++) {
                grid[i][j] = '';
                const button = buttonContainer.children[i].children[j];
                button.textContent = '';
                button.disabled = false;
            }
        }
    }
});