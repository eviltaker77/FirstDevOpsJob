package polyglot.com.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

	@GetMapping("/test")
	public String TestFirstJob() {
		return "Welcome to MasterDevops |Tomcat v2.0.0 | KUBERNETES EN AWS, POLYGLOT STUDY 29092023";
	}
}
