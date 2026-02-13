import { pool } from "./config.js";


export async function buscarProduto() {
    const [rows] = await pool.query("SELECT * FROM vw_estoque",
    )
    console.log(rows)
    return rows;
}

export async function cadastrarProduto(nome_produto, categoria, valor_unitario, estoque_min, estoque_max) {
    const [rows] = await pool.query("INSERT INTO produtos (nome_produto, categoria, valor_unitario, estoque_min, estoque_max) VALUES (?,?,?,?,?)",
    [nome_produto, categoria, valor_unitario, estoque_min, estoque_max]
    )
    console.log(rows)
    return rows;
}

export async function buscarSaida() {
     const [rows] = await pool.query("SELECT * FROM vw_saida",
    )
    console.log(rows)
    return rows;
    
}

export async function cadastrarMovimentacoes(produto_id, tipo, quantidade, data_movimentacao) {
    const [rows] = await pool.query("INSERT INTO movimentacoes (produto_id, tipo, quantidade, data_movimentacao) VALUES (?,?,?,?)",
    [produto_id, tipo, quantidade, data_movimentacao]
    )
    console.log(rows)
    return rows;
}

export async function relatorio() {
    const [rows] = await pool.query("SELECT * FROM vw_relatorio",
    )
    console.log(rows)
    return rows;
}

export async function maiorSaida() {
    const [rows] = await pool.query("SELECT * FROM vw_maior_saida",
    )
    console.log(rows)
    return rows;
    
}

export async function limiteEstoque() {
    const [rows] = await pool.query("SELECT * FROM vw_limite_estoque",
    )
    console.log(rows)
    return rows;
    
}