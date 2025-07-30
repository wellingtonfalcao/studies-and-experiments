package br.com.wellingtonfalcao.cadastro_ideias.model.service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.wellingtonfalcao.cadastro_ideias.model.domain.Ideia;
import br.com.wellingtonfalcao.cadastro_ideias.model.repository.IdeiaRepository;

@Service
public class IdeiaService {
	
	@Autowired
	private IdeiaRepository ideiaRepository;
	
	public Ideia incluir(Ideia ideia) {
		return ideiaRepository.save(ideia);	
	}
	
	public List<Ideia> obterLista() {
		return ideiaRepository.findAll();
	}
	
	public Optional<Ideia> obterPorId(Integer id){
		return ideiaRepository.findById(id);
	}

	public Optional<Ideia> alterar(Integer id, Ideia ideiaAtualizada) {
		
		//Obtem o livro pelo id, caso não existe ele retorna uma excessão.
		Ideia ideiaExistente = obterPorId(id).orElseThrow(() -> new NoSuchElementException());
		
		//Processo de alteração (Precisa resgatar os valores para não retornar valores nulos casos não sejam alterado).
		ideiaExistente.setTitulo(ideiaAtualizada.getTitulo());
		ideiaExistente.setDescricao(ideiaAtualizada.getDescricao());
		ideiaExistente.setCategoria(ideiaAtualizada.getCategoria());
		ideiaExistente.setDificuldade(ideiaAtualizada.getDificuldade());
		ideiaExistente.setGrauInteresse(ideiaAtualizada.getGrauInteresse());
		ideiaExistente.setCusto(ideiaAtualizada.getCusto());
		ideiaExistente.setStatus(ideiaAtualizada.getStatus());
		ideiaExistente.setDataCriacao(ideiaAtualizada.getDataCriacao());
		
		//Retorna o valor convertido do tipo "Livro" para Optional.
		return Optional.of(ideiaRepository.save(ideiaExistente));
	}
	
	public boolean excluir(Integer id){
		
		//Ideia ideiaExistente = obterPorId(id).orElseThrow(() -> new NoSuchElementException());
		
		if(!ideiaRepository.existsById(id)) {
			throw new NoSuchElementException("A ideia não está cadastrada.");
		}
		
		ideiaRepository.deleteById(id);
		return true;
	}
	
	public Optional<List<Ideia>> obterPorTitulo(String titulo) {
		return ideiaRepository.findByTituloContainingIgnoreCase(titulo);
	}

}
