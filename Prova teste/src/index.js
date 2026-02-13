import { buscarProduto, buscarSaida, cadastrarMovimentacoes, cadastrarProduto, limiteEstoque, maiorSaida, relatorio } from "./bibliotecaService.js";
import { pool } from "./config.js";

async function main() {
    // await buscarProduto()
    // await buscarSaida()
    // await cadastrarProduto("Lápis", "Material de Escritório", '03.00', 5, 10);
    // await cadastrarMovimentacoes(6, "ENTRADA", 8, '2026-06-20 10:00:00')
    // await relatorio()
    await maiorSaida()
    await limiteEstoque()
}

main().catch(error=>
    console.error(error)
).finally(async()=>{
    await pool.end();
})