var usuarioModel = require("../models/usuarioModel"); // requisição
var aquarioModel = require("../models/aquarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha) // aqui, é chamada a função autenticar no arquivo usuarioModel.js da pasta models.
            .then(
                // depois de fazer o select e os dados voltarem para cá, é acionada a sequinte função
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        // os sequintes dados não passam pelo arquivo usuarios.js em routes; eles vão para o login.html diretamente
                        // aquarioModel.buscarAquariosPorEmpresa(resultadoAutenticar[0].empresaId)
                        //     .then((resultadoAquarios) => {
                        //         if (resultadoAquarios.length > 0) {
                                    res.json({
                                        id: resultadoAutenticar[0].id,
                                        email: resultadoAutenticar[0].email_comercial,
                                        razãoSocial: resultadoAutenticar[0].razao_social,
                                        senha: resultadoAutenticar[0].senha,
                                        telefone: resultadoAutenticar[0].telefone_comercial,
                                        cpf: resultadoAutenticar[0].cnpj
                                    });
                            //     } else {
                            //         res.status(204).json({ aquarios: [] });
                            //     }
                            // })
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var cnpj = req.body.cnpjServer;
    var razaoSocial = req.body.razaoSocialServer;
    var telefone = req.body.telefoneServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    // Faça as validações dos valores
    if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (cnpj == undefined) { // validação cnpj
        res.status(400).send("Seu CNPJ está undefined!");
    } else if (razaoSocial == undefined) {
        res.status(400).send("Sua razão social está undefined!");
    } else if (telefone == undefined) {
        res.status(400).send("Seu telefone está undefined!");
    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(razaoSocial, email, senha, telefone, cnpj)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    autenticar,
    cadastrar
}