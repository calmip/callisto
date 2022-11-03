var loadscreen = {
    loadscreen: document.querySelector('#loadscreen'),
    ball: document.querySelector('#loadscreen-animation').children[0].children[0],
    title: document.querySelector('#loadscreen-title'),
    subtitle: document.querySelector('#loadscreen-subtitle'),
}

function activateLoadscreen() {
    loadscreen.loadscreen.style.transform = 'translateX(0)';
};

function hideLoadscreen() {
    loadscreen.loadscreen.style.transform = 'translateX(100%)';
}

setInterval(function() {
    loadscreen.ball.classList.toggle('no-size');
}, 500);

