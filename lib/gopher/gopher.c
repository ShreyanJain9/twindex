#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <unistd.h>

char* send_gopher_request(const char* server, int port, const char* path, const char* query) {
    struct sockaddr_in serv_addr;
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        perror("Error opening socket");
        return NULL;
    }

    struct hostent* server_info = gethostbyname(server);
    if (server_info == NULL) {
        perror("Error getting server information");
        return NULL;
    }

    memset(&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(port);
    memcpy(&serv_addr.sin_addr.s_addr, server_info->h_addr, server_info->h_length);

    if (connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) {
        perror("Error connecting to server");
        return NULL;
    }

    char request[1024];
    if (strlen(query) == 0) {
        snprintf(request, sizeof(request), "%s\r\n", path);
    } else {
        snprintf(request, sizeof(request), "%s\t%s\r\n", path, query);
    }

    if (send(sockfd, request, strlen(request), 0) < 0) {
        perror("Error sending request");
        return NULL;
    }

    char response[4096] = {0};
    int bytes_received = recv(sockfd, response, sizeof(response) - 1, 0);
    if (bytes_received < 0) {
        perror("Error receiving response");
        return NULL;
    }

    char* result = (char*)malloc(bytes_received + 1);
    memcpy(result, response, bytes_received);
    result[bytes_received] = '\0';

    close(sockfd);
    return result;
}
