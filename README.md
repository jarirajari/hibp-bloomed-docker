# hibp-bloomed-docker
Have I Been Pwned, Bloomed version, in Docker

Builds on:
- Troy Hunt's password data: https://haveibeenpwned.com/Passwords
- Adewes's Bloom filter and server in Go: https://github.com/adewes
- Docker: https://www.docker.com/

How to use locally:
- sudo bash build.sh    # builds docker image
- sudo bash start.sh    # starts docker container using the built image
- sudo bash connect.sh  # if you want to connect to docker container
- sudo bash test.sh     # execute curl commands and get response back
- sudo bash stop.sh     # stops docker container
- sudo bash demolish.sh # removes the built image

Originally though of doing this with:
- Java
- Spark (for REST)
- mapdb (for persistent maps)
- commons collections v4 (PatriciaTrie for radix trie)
- HIBP (for data)

