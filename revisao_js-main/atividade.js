function esperarBolo(tempoBolo) {
    return new Promise(
        (resolve, reject) => {
            setTimeout(() => {
                if(tempoBolo < 20){
                    reject("Bolo ficou pouco tempo no forno e está cru")
                }
                else if(tempoBolo > 45){
                    reject("Bolo ficou assado")
                }
                else {
                    resolve("Bolo ficou pronto")
                }
            },
        2000)
        }
    )
}

esperarBolo(30)
.then((resultado) => console.log(resultado))
    .catch((erro) => console.error(erro))
    .finally(() => console.log('o bolo está pronto e é so esperar esfriar pra comer!'));

// Criar uma função que recebe um número aleatório, gerem o numero aleatorio
// quando chamar a funcao(usem metodos js)
// se o numero for maior que 5, retorna resolve, se não retorna reject
// usem o finally livremente

function numeroAleatorio(){
    aleatorio = Math.floor(Math.random() * 10)
    console.log(`o número gerado foi:${aleatorio}`)
     return new Promise(
        (resolve,reject) => {
            if (aleatorio > 5){
                resolve("Número maior que 5")
            }
            else {
                reject("Número menor que 5")
            }
        }
    )
}

numeroAleatorio()
.then((resultado) => console.log(resultado))
    .catch((erro) => console.error(erro))
    .finally(() => console.log('Bingo Finalizado'));