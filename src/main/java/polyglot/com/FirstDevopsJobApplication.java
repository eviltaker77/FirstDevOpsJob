package polyglot.com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class FirstDevopsJobApplication extends SpringBootServletInitializer {

	// Agregamos esto metodos 
	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(FirstDevopsJobApplication.class);
    }
	
	public static void main(String[] args) {
		SpringApplication.run(FirstDevopsJobApplication.class, args);
	}

}
