function appendElement(parent, childElement, string = null, options = null) {
    child = document.createElement(childElement)

    if (string !== null) {
        textNode = document.createTextNode(string)
        child.appendChild(textNode)
    }

    if (options !== null) {
        var availableOptions = [
            'className',
            'src',
            'href',
            'id',
            'target',
            'type',
            'hidden',
            'value'
        ]
        availableOptions.forEach(option => {
            if (option in options) {
                child[option] = options[option]
            }
        })
    }
    parent.appendChild(child)
    return child
}