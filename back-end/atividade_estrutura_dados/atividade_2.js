class Queue {

    constructor() {
        this.array = new Array()
        this.inicio = 0
    }

    enqueue(value) {
        if (value.isEldery) {
            let contador = this.inicio
            while (contador < this.array.length && this.array[contador].isEldery) contador++
            
            this.array.splice(contador, 0, value)
        }
        else {
            this.array.push(value)
        }
    }

    dequeue() {
        const removido = this.array[this.inicio]
        this.array[this.inicio] = undefined
        this.inicio = this.inicio + 1
        return removido;
        
    }

    mostrarTamanho() {
        return this.array.length
    }
    mostrarFila() {
        return this.array
    }

}

const fila = new Queue();

fila.enqueue({nome:"Ronald", isEldery:false})
fila.enqueue({nome:"Felipe", isEldery:false})
fila.enqueue({nome:"Fred", isEldery:false})

fila.enqueue({nome:"Sebastião", isEldery:true})
fila.enqueue({nome:"Jertrude", isEldery:true})
fila.enqueue({nome:"Terezinha", isEldery:true})
console.table(fila.mostrarFila())

fila.dequeue()
fila.dequeue()
fila.enqueue({nome:"Jertrude", isEldery:true})

console.table(fila.mostrarFila())