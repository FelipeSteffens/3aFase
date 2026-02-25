import Card from '../../components/Cards/Card'
import styles from './Body.module.css'

const Body = () => {

    const usuarios = [
        {nome: "Ana", idade: 22, cidade:"São josé"},
        {nome: "Felipe", idade: 19, cidade:"Floripa"},
        {nome: "Karla", idade: 18, cidade:"São josé"},
    ]

  return (
    <>
       <main className={styles.body}>
            <h2>Usúarios cadastrados</h2>
            <div className={styles.cardContainer}>
                {usuarios.map((usuario, index) => (
                    <Card
                        key={index}
                        nome={usuario.nome}
                        idade={usuario.idade}
                        cidade={usuario.cidade}
                    />
                ))}
            </div>
       </main>
    </>
  )
}

export default Body