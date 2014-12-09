ironhack.addMyEvent = function(element, event, callback) {

    if(element.addEventListener) {
        element.addEventListener(event, callback, false);
    } else if (element.attachEvent) {
        element.attachEvent('on'+event, callback);
    } else {
        element['on' + event] = callback;
    }

};