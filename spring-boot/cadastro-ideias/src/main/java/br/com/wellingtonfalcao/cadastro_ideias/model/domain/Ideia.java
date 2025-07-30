package br.com.wellingtonfalcao.cadastro_ideias.model.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Ideia {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) //Responsabilidade do banco 
	private Integer id;
	
	private String titulo;
	private String descricao;
	private String categoria;
	private int dificuldade;
	private int grauInteresse;
	private double custo;
	private boolean status;
	private String DataCriacao;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public int getDificuldade() {
		return dificuldade;
	}
	public void setDificuldade(int dificuldade) {
		this.dificuldade = dificuldade;
	}
	public int getGrauInteresse() {
		return grauInteresse;
	}
	public void setGrauInteresse(int grauInteresse) {
		this.grauInteresse = grauInteresse;
	}
	public double getCusto() {
		return custo;
	}
	public void setCusto(double custo) {
		this.custo = custo;
	}
	public boolean getStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public String getDataCriacao() {
		return DataCriacao;
	}
	public void setDataCriacao(String dataCriacao) {
		DataCriacao = dataCriacao;
	}
	
}
