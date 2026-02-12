import style from "./Card.module.css";

export default function Card ({ id }) {
    return (
        <section className={style.card}> 
            <a 
                href={`https://www.youtube.com/watch?v=${id}`} //B_nq7VTJZds
                rel="noreferrer noopener"
                target="_blank">
                <img src={`https://img.youtube.com/vi/${id}/mqdefault.jpg`} alt="Capa"/>
            </a>
        </section>
    );
}