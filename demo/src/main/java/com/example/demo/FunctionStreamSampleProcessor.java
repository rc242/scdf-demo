package com.example.demo;

import java.util.function.Function;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class FunctionStreamSampleProcessor {

  @Bean
  public Function<String, String> messenger() {

    return data -> "Hello: " + data + "!";
  }
}