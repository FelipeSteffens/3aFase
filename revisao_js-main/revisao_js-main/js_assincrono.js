// // Código síncrono
// console.log("Primeiro");
// console.log("Segundo");
// // Código assíncrono
// console.log("Primeiro");
// setTimeout(() => {  console.log("Terceiro (depois de 2s)");}, 2000); // Depois de 2s
// console.log("Segundo");

// resultado da linha 6


// Exemplo de Promise simulando tempo de espera
function esperarTempo(ms) { 
    return new Promise(
        (resolve, reject) => { 
            setTimeout(() => { 
                console.log("antes")
                // resolve(`Esperou ${ms}ms`);
                console.log("depois") 
                // Para simular erro: 
                reject(new Error('Falhou'));
         }, 
            ms); 
        });
}
esperarTempo(2000)
    .then((resultado) => console.log(resultado))
    .catch((erro) => console.error(erro))
    .finally(() => console.log('Finalizado'));









// Criar uma funcao que retorna uma promisse, e a ideia é simular o preparo do bolo
// Receber tempo de assamento
// Lógica que trata, se o tempo que foi passado é suficente pro bolo assar ou não
// Se sim, retorna a função do resolve -> informando que o bolo assou com sucesso
// Se não, retorna reject com bolo queimado ou cru
// finally, criatividade de voces.


// Criar uma função que recebe um número aleatório, gerem o numero aleatorio
// quando chamar a funcao(usem metodos js)
// se o numero for maior que 5, retorna resolve, se não retorna reject
// usem o finally livremente.