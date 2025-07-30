package br.com.wellingtonfalcao.cadastro_ideias.model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.wellingtonfalcao.cadastro_ideias.model.domain.Ideia;

@Repository
public interface IdeiaRepository extends JpaRepository<Ideia, Integer> {
	
	Optional<List<Ideia>> findByTituloContainingIgnoreCase(String titulo);
	
}
