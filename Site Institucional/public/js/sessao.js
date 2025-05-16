// sessão
function validarSessao() {
    var email = sessionStorage.EMAIL_PESSOA_JURIDICA;
    var nome = sessionStorage.RAZAO_PESSOA_JURIDICA;
    var cnpj = sessionStorage.CNPJ_PESSOA_JURIDICA;

    var b_usuario = document.getElementById("b_usuario");

    var cnpj = document.getElementById("cnpj");


    if (email != null && nome != null && cnpj != null) {
        b_usuario.innerHTML = nome;
        cnpj.innerHTML = cnpj;
    } else {
        window.location = "./Login.html";
    }
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "./Login.html";
}

// carregamento (loading)
function aguardar() {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "flex";
}

function finalizarAguardar(texto) {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "none";

    var divErrosLogin = document.getElementById("div_erros_login");
    if (texto) {
        divErrosLogin.style.display = "flex";
        divErrosLogin.innerHTML = texto;
    }
}

