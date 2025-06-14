package site.ani4h.film.elasticsearch;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.json.jackson.JacksonJsonpMapper;
import co.elastic.clients.transport.ElasticsearchTransport;
import co.elastic.clients.transport.rest_client.RestClientTransport;
import co.elastic.clients.util.ContentType;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponseInterceptor;
import org.apache.http.message.BasicHeader;
import org.apache.http.ssl.SSLContextBuilder;
import org.elasticsearch.client.RestClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.elasticsearch.repository.config.EnableElasticsearchRepositories;
import org.springframework.http.HttpHeaders;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLContext;
import java.util.List;

@Slf4j
@Configuration
@EnableElasticsearchRepositories(basePackages = "site.ani4h.film.search")
public class ElasticsearchConfig {

    private SSLContext sslContext() {
        try {
            return SSLContextBuilder.create()
                    .loadTrustMaterial(null, (certificate, authType) -> true)
                    .build();
        } catch (Exception e) {
            throw new RuntimeException("Failed to create SSL context", e);
        }
    }

    @Bean
    public ElasticsearchClient elasticsearchClient() {
        HostnameVerifier hostnameVerifier = (hostname, session) -> true;

        RestClient restClient = RestClient.builder(
                new HttpHost("vpc-ani4h-opensearch-gjlrsug2qvkgvxpoc3e6dczp6q.ap-southeast-1.es.amazonaws.com", 443, "https"))
                .setHttpClientConfigCallback(httpClientBuilder -> {
                    try {
                        return httpClientBuilder
                                .setSSLContext(sslContext())
                                .setSSLHostnameVerifier(hostnameVerifier)
                                .setDefaultHeaders(
                                    List.of(
                                        new BasicHeader(
                                                HttpHeaders.CONTENT_TYPE, ContentType.APPLICATION_JSON.toString())))
                                .addInterceptorLast(
                                        (HttpResponseInterceptor)
                                                (response, context) ->
                                                        response.addHeader("X-Elastic-Product", "Elasticsearch"));
                    } catch (Exception e) {
                        throw new RuntimeException("Failed to set SSL context", e);
                    }
                })
                .build();

        ElasticsearchTransport transport = new RestClientTransport(
                restClient, new JacksonJsonpMapper());

        ElasticsearchClient elasticsearchClient = new ElasticsearchClient(transport);

        return elasticsearchClient;
    }
}