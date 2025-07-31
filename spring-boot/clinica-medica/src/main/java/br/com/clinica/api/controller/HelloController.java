package br.com.clinica.api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hello")
public class HelloController {

    @GetMapping
    public String olaMundo() {
        return "Pagina principal";
    }

    @GetMapping("/produtos")
    public String paginaProdutos() {
        return "Pagina de produtos";
    }

    @GetMapping("/clientes")
    public String paginaClientes() {
        return "Pagina de clientes";
    }
}
