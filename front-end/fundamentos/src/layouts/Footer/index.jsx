import styles from "./Footer.module.css"


const Footer = ({name}) => {
  return (
    <footer className={styles.footer}>
        <p >Desenvolvido por <a href="https://github.com/FelipeSteffens" target="_blank">{name}</a></p>
    </footer>
  )
}

export default Footer

