
var navBtns = document.querySelectorAll('header li');
var options = [];
// dynamically get option titles with nav 
// if the title and the path don't match it must be indicated like the example below (single case) 
navBtns.forEach(button => {
    var option = button.children[0].textContent.toLowerCase();
    // single case: home and its path name (index) names don't match
    if (option.includes('home')) {
        option = 'index';
    }
    if (option.includes('deposit')) {
        option = 'index-dataverse';
    }

    options.push(option);
});
var path = window.location.pathname.split('/')[1];

// Assign active classes according to path
var i = 0;
var breakLoop = false;
options.forEach(string => {
    if (breakLoop == false) {
        if (path.includes(string + '.php')) {
            navBtns[i].children[0].classList.add('active');
            navBtns[i].children[1].classList.remove('inactive');
            breakLoop = true;

            // single case: if no path specified -> index
        } else if (path == '') {
            navBtns[i].children[0].classList.add('active');
            navBtns[i].children[1].classList.remove('inactive');
            breakLoop = true;
        }
    } 
    i++;
});


// Blue ball indicator trigger animation
navBtns.forEach(element => {
    element.addEventListener('mouseover', function() {
        element.children[1].classList.remove('inactive');
    });
    element.addEventListener('mouseout', function() {
        if (!element.children[0].classList.contains('active')) {
            element.children[1].classList.add('inactive');
        }
    });
});