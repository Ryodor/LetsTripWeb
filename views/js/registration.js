function new_user() {
    let last_name = document.getElementById("last_name").value;
    let first_name = document.getElementById("last_name").value;
    let email = document.getElementById("email").value;
    let password1 = document.getElementById("password1").value;
    let password2 = document.getElementById("password2").value;

    document.getElementById("error_message").innerHTML = "";
    document.getElementById("sucess_message").innerHTML = "";

    if (password1 == password2) {
        document.getElementById("sucess_message").style.display = "inline";
        document.getElementById("sucess_message").innerHTML = "Bienvenue " + first_name + " " + last_name + " :-)";
        document.getElementById("error_message").style.display = "none";

        ajaxRequestGET(`/newuser/${last_name}/${first_name}/${email}/${password1}`, (res) => {
            window.location.reload();
        });
    } else {
        document.getElementById("error_message").style.display = "inline";
        document.getElementById("error_message").innerHTML = "Vous avez écris deux mots de passe différents.";
        document.getElementById("sucess_message").style.display = "none";
    }
}

document.getElementById("sucess_message").style.display = "none";
document.getElementById("error_message").style.display = "none";