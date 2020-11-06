# hibp-bloomed-docker

Check if your users' passwords are safe to use. Pwned Passwords are 500 million real world passwords previously exposed in data breaches.

Reasons to choose Docker over public API:
- Security concerns: since you are going to check real passwords, you should *not* trust any external service!
- Performance: just the password database is over 10 GB in size, but the whole Docker image is only 2GB!
- Easy and fast: ready made Docker image hosted in Docker Hub available for quick experiments

Test it immediately with Docker (there is a ready image in [Docker Hub](https://hub.docker.com/)):
```
TODO
```


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

