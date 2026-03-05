function validarBalenceamento(expressao){
    const pilha = []
    const pares = {
        ")": "(",
        "]": "[",
        "}": "{"
    }
    const quemAbre = new Set(["(", "[", "{"])
    
    for (const caractere of expressao){
        if(quemAbre.has(caractere)) pilha.push(caractere)
        else if(caractere in pares){
            if(pilha.length === 0) return false
            const topo = pilha.pop()
            if(topo !== pares[caractere]) return false
    }
    }
    return pilha.length === 0
}

console.log(validarBalenceamento("((a+b)*c)"))