**package br.com.wellingtonfalcao.cadastro_ideias.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.wellingtonfalcao.cadastro_ideias.model.domain.Ideia;
import br.com.wellingtonfalcao.cadastro_ideias.model.service.IdeiaService;

@RestController
@RequestMapping("/api/ideias")
public class IdeiaController {
	
	@Autowired
	private IdeiaService ideiaService;

	
	@GetMapping
	public ResponseEntity<List<Ideia>> obterLista() {
	    List<Ideia> lista = ideiaService.obterLista();

	    if (lista.isEmpty()) {
	        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	    }
	    return new ResponseEntity<>(lista, HttpStatus.OK);
	}
	
	@PostMapping
	public ResponseEntity<Ideia> incluir(@RequestBody Ideia ideia){
		Ideia novaIdeia = ideiaService.incluir(ideia);
		return new ResponseEntity<Ideia>(novaIdeia, HttpStatus.CREATED);
	}

	 
}
