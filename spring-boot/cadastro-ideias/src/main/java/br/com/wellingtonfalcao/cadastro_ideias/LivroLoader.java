package br.com.wellingtonfalcao.cadastro_ideias;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import br.com.wellingtonfalcao.cadastro_ideias.model.domain.Ideia;
import br.com.wellingtonfalcao.cadastro_ideias.model.service.IdeiaService;

@Component
public class LivroLoader implements ApplicationRunner{
	
	@Autowired
	private IdeiaService ideiaService;
	
	@Override
	public void run(ApplicationArguments args) throws Exception {
		
		//Inclusão
		Ideia ideiaCadastrada = null;

		Ideia i1 = new Ideia();
		i1.setTitulo("Esse é o título 1");
		i1.setDescricao("1 - Descrição do curso");
		i1.setCategoria("Curso");
		i1.setDificuldade(4);
		i1.setGrauInteresse(3);
		i1.setCusto(450.35);
		i1.setStatus(true);
		i1.setDataCriacao("03/03/2025");
		
		ideiaCadastrada = ideiaService.incluir(i1);
		System.out.println("Inclusão da ideia: %s [%d]".formatted(ideiaCadastrada.getTitulo(), ideiaCadastrada.getId()));
		
		Ideia i2 = new Ideia();
		i2.setTitulo("Esse é o título 2");
		i2.setDescricao("2 - Descrição do curso");
		i2.setCategoria("Dica");
		i2.setDificuldade(4);
		i2.setGrauInteresse(3);
		i2.setCusto(450.35);
		i2.setStatus(true);
		i2.setDataCriacao("12/03/2025");
		
		ideiaCadastrada = ideiaService.incluir(i2);
		System.out.println("Inclusão da ideia: %s [%d]".formatted(ideiaCadastrada.getTitulo(), ideiaCadastrada.getId()));
		
		
		Ideia i3 = new Ideia();
		i3.setTitulo("Esse é o título 3");
		i3.setDescricao("3 - Descrição do curso");
		i3.setCategoria("Dica");
		i3.setDificuldade(4);
		i3.setGrauInteresse(3);
		i3.setCusto(450.35);
		i3.setStatus(true);
		i3.setDataCriacao("12/03/2025");
		
		ideiaCadastrada = ideiaService.incluir(i3);
		System.out.println("Inclusão da ideia: %s [%d]".formatted(ideiaCadastrada.getTitulo(), ideiaCadastrada.getId()));
		
		Ideia i4 = new Ideia();
		i4.setTitulo("Esse é o título 4");
		i4.setDescricao("4 - Descrição do curso");
		i4.setCategoria("Dica");
		i4.setDificuldade(4);
		i4.setGrauInteresse(3);
		i4.setCusto(450.35);
		i4.setStatus(true);
		i4.setDataCriacao("12/03/2025");
		
		ideiaCadastrada = ideiaService.incluir(i4);
		System.out.println("Inclusão da ideia: %s [%d]".formatted(ideiaCadastrada.getTitulo(), ideiaCadastrada.getId()));
		
		//Exclusão
		
		try {
//			ideiaService.excluir(2);
//			ideiaService.excluir(10);
		} catch (NoSuchElementException e) {
			System.err.println("[Erro] " + e.getMessage());
		}
		
		//Alteração
	
//		i1.setTitulo("ALT");
//		i1.setDescricao("Descrição do curso alterado");
//		i1.setCategoria("Curso alterado");
//		i1.setDificuldade(5);
//		i1.setGrauInteresse(4);
//		i1.setCusto(455.35);
//		i1.setStatus(false);
//		i1.setDataCriacao("06/03/2020");
		
//		ideiaService.alterar(i1.getId(), i1);
		
		//Busca

		Optional<List<Ideia>> ideias = ideiaService.obterPorTitulo("esse");
		
		if(ideias.isPresent()) {
			List<Ideia> lista = ideias.get();
			
			for(Ideia ideia : lista) {
				System.out.println("Ideia registrada: " + ideia.getTitulo());
			}
		}
		
	}

}
