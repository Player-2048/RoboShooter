// 获取元素
const player = document.getElementById('player');
const coin = document.getElementById('coin');
const scoreDisplay = document.getElementById('score');

// 初始位置和分数
let playerX = 180;
let playerY = 180;
let score = 0;

// 设置玩家初始位置
player.style.left = `${playerX}px`;
player.style.top = `${playerY}px`;

// 随机生成金币位置
function generateCoin() {
    const x = Math.floor(Math.random() * 380);
    const y = Math.floor(Math.random() * 380);
    coin.style.left = `${x}px`;
    coin.style.top = `${y}px`;
}

// 检测碰撞
function checkCollision() {
    const playerRect = player.getBoundingClientRect();
    const coinRect = coin.getBoundingClientRect();

    if (
        playerRect.left < coinRect.right &&
        playerRect.right > coinRect.left &&
        playerRect.top < coinRect.bottom &&
        playerRect.bottom > coinRect.top
    ) {
        score++;
        scoreDisplay.textContent = score;
        generateCoin(); // 生成新的金币
    }
}

// 移动玩家
function movePlayer(event) {
    const speed = 10; // 移动速度

    switch (event.key) {
        case 'ArrowUp':
            playerY = Math.max(playerY - speed, 0);
            break;
        case 'ArrowDown':
            playerY = Math.min(playerY + speed, 360);
            break;
        case 'ArrowLeft':
            playerX = Math.max(playerX - speed, 0);
            break;
        case 'ArrowRight':
            playerX = Math.min(playerX + speed, 360);
            break;
    }

    player.style.left = `${playerX}px`;
    player.style.top = `${playerY}px`;
    checkCollision(); // 检测是否捡到金币
}

// 监听键盘事件
document.addEventListener('keydown', movePlayer);

// 初始化游戏
generateCoin();