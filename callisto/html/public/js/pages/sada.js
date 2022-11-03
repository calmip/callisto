// manage info tab swiper
var swiper = new Swiper('.swiper-container', {
    direction: 'vertical',

    pagination: {
        el: '.swiper-pagination',
    },

    // enables pagination to appear without resizing because slides are appended dynamically
    observer: true,
    observeParents: true
})

// expand and hide info-tab
var expand = document.querySelector('.info-tab .expand-arrow')
var infoTab = document.querySelector('.info-tab')
expand.parentElement.addEventListener('click', function() {
    infoTab.classList.toggle('info-tab--hidden')
    expand.classList.toggle('expand-arrow--down')
    // manage service description transparency
    document.querySelectorAll('.info-tab__description').forEach(element => {
        element.classList.toggle('transparent')
    })
})

function openGetFiles() {
    document.querySelector('#sada-get-files').style = 'right: 1rem'
}
function closeGetFiles() {
    document.querySelector('#sada-get-files').style = 'right: calc(-400px - 2rem)'
}

function showLoadAnimation(service){
    var animationContainer = document.querySelector('#animation-service__container')
    if (animationContainer.classList.contains('hidden')) {
        animationContainer.classList.replace('hidden', 'open')
    }
}

function removeLoadAnimation() {
    var animationContainer = document.querySelector('#animation-service__container')
    animationContainer.classList.replace('open', 'hidden')
}

function hideGetFilesResultBox(){
    var result = document.querySelector('#get-files-results');
    if (result.classList.contains('open')) {
        result.classList.replace('open', 'hidden')
        // result.classList.remove()
    }
}



