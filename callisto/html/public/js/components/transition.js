var tIn = document.querySelector('#transition-in');
window.addEventListener('load', function() {
    tIn.style.top = '-100%';
});

function changePage(element) {
    var tOut = document.querySelector('#transition-out');
    tOut.style.top = '0';
    // Redirect after animation time
    setTimeout(function() {
        window.location = element.href;
    }, 300);
}