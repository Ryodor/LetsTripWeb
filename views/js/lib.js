/** Global function library, this file is called in all ejs files */

console.log("The lib is included");

/** Make a GET ajax request (Client => Server) */
function ajaxRequestGET(route, onSuccess, async = true) {
    /** Check integrity */
    if (route == undefined || route == null || route === "") throw new Error("route parameter cannot be null, undefined or empty");
    if (onSuccess == undefined || onSuccess == null) throw new Error("onSuccess parameter cannot be null or undefined");

    /** Making the request */
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {
            onSuccess(this.responseText);
        }
    }
    xhr.open("GET", route, async);
    xhr.send();
}