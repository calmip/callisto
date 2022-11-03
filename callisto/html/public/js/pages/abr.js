function appendCloseBtn(mainWrapper) {
    var closeBtn = appendElement(mainWrapper, 'span', 'x'/*'&#10006;'*/, {'className': 'circle pos--abs t--0 r--0 close pointer flex flex--center'})
    closeBtn.addEventListener('click', function() {
        mainWrapper.remove()
    })
}

function addAuthor() {
    function setupInputAttributes(input, nameType) {
        input.type = 'text'
        input.placeholder = nameType + ' name' 
    }
    var authorsContainer = document.querySelector('#abr-authors')
    var mainWrapper = appendElement(authorsContainer, 'div', null, {'className': 'flex flex--justify-between w--full m--b--1 pos--rel'})
    var firstContainer = appendElement(mainWrapper, 'div', null, {'className': 'input-container w--50 m--r--1'})
    var firstInput = appendElement(firstContainer, 'input', null, {'className': 'abr-first-name'})
    var lastContainer = appendElement(mainWrapper, 'div', null, {'className': 'input-container w--50 m--l--1'})
    var lastInput = appendElement(lastContainer, 'input', null, {'className': 'abr-last-name'})
    setupInputAttributes(firstInput, 'First')
    setupInputAttributes(lastInput, 'Last')
    appendCloseBtn(mainWrapper)
}

function addClaim() {
    var claimsContainer = document.querySelector('#abr-claims')
    var mainWrapper = appendElement(claimsContainer, 'div', null, {'className': 'input-container m--b--1 pos--rel'})
    var input = appendElement(mainWrapper, 'textarea', null, {'className': 'abr-claim'})
    input.placeholder = 'Example: Only about half of the universe’s expected amount of ordinary matter has ever been cataloged.'
    appendCloseBtn(mainWrapper)
}

function addConcept() {
    var claimsContainer = document.querySelector('#abr-concepts')
    var mainWrapper = appendElement(claimsContainer, 'div', null, {'className': 'input-container m--b--1 pos--rel'})
    var input = appendElement(mainWrapper, 'input', null, {'className': 'abr-concept'})
    input.placeholder = '(Example: Dynamic morphing)'
    appendCloseBtn(mainWrapper)
}

function changeRepoSearchLinks() {
    var manual = document.querySelector('#abr-manual-search')
    var advanced = document.querySelector('#abr-advanced-search')

    manual.href = allegro.prefix + active_repo + '/gruff'
    advanced.href = allegro.prefix + active_repo
}

// function activateAnimation() {
//     var animation = appendElement(document.querySelector('#sada-get-files'), 'div', null, {'className': 'lds-ring m--t--1'})
//     for (let i = 0; i < 4; i++) {
//         appendElement(animation, 'div', null, null)
//     }
// }



function verifyForm() {
    var requiredInputs = document.querySelectorAll('abr-required')
    requiredInputs.forEach(input => {
        if (input.value.length == 0 || input.value.replace(/\s/g, '').length == 0) {
            return false
        } else {
            return true
        }
    })
}
// validate url