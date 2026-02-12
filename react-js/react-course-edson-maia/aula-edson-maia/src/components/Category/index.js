import styles from "./Category.module.css";

export default function Category( { category, children } ) {
    return (
        <section className={styles.category}>
            <h2>{category}</h2>
            <section>
                {children}
            </section>
        </section>
           
    );
}